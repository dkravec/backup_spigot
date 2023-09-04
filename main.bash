#! /bin/sh
dateFileName="date +%Y-%m-%d"
echo "Starting Spigot Backup Script"

echo "Files will be named : `${dateFileName}`"
amountToday=0

backupDir=~/backups/spigot
mainDir=~/tank/spigot
dockerName=spigot

# backupDir=~/Backups
# mainDir=~/Developer/cheese
fileName=`${dateFileName}`

findCurrentAmount() {
    echo "Finding current amount of backups for today"
    found="false"
    let i=0
    while [ "$found" == "false" ];
    do
        if [ "${i}" == 0 ]; then
            echo "find 1.0 - Checking for first backup for today"
            if [ -f "${backupDir}/${fileName}.tar.gz" ]; then
                echo "find 1.1 - Found first backup for today"
                let i=i+1
            else 
                echo "find 1.2 - Can continue with backup"
                let found="true"
            fi
        else
            echo "Checking for $i backup for today"

            if [ -f "${backupDir}/${fileName}_num${i}.tar.gz" ]; then
                echo "find 2.1 - Found first backup for today"
                let i=i+1
            else
                echo "find 2.2 - Can continue with backup"
                let found="true"
            fi
        fi
    done

    if [ "$i" != 0 ]; then
        fileName="${fileName}_num${i}"
    fi

    echo "File will be named ${fileName}"
}

task0_1() {
    echo "Starting Task 0: Directory Check"
    echo "Task 0.1: Checking if backups directory exists"
    if [ ! -d "${backupDir}" ]; then
        echo "Backups directory did not previously exist"
        echo "Task 0.1.1: Creating backups directory"
        # creates backups directory if it doesnt exist
        mkdir "${backupDir}"
    else
        echo "Backups directory previously existed, creation skipped"
    fi

    sleep 2
}

task0_2() {
    echo "Task 0.2: Checking if backup directory for today exists"
    # echo "hello_${backupDir}"
    echo "${backupDir}/spigot_${fileName}"
    if [ -d "${backupDir}/spigot_${fileName}" ]; then
    
        if [ "$1" == "-f" ]; then
            echo "Task 0.2.1: Deleting old backups directory"
            rm -rf "${backupDir}/spigot_${fileName}"
        else
            echo "ERROR: Please add -f to force delete old backup for today"
            echo "Unable to continue"
            exit
        fi
    fi
    sleep 2
}

task0_3() {
    echo "Task 0.3: Checking if backup tar for today exists"
    if [ -d "${backupDir}/${fileName}.tar.gz" ]; then
        if [ "$1" == "-f" ]; then
            echo "Task 0.2.1: Deleting old backups directory"
            rm -rf "${backupDir}/${fileName}.tar.gz"
        else 
            echo "ERROR: Please add -f to force delete old backup for today"
            echo "Unable to continue"
            exit
        fi
    fi
    echo "Task 0 Complete"
    sleep 2
}

task1() {
    # stops mc
    echo "Starting Task 1"
    echo "Task 1.0: Stopping Spigot Server"
    docker exec "${dockerName}" mc_stop
    echo "Task 1.1 -- Stopping Spigot Container"
    docker stop "${dockerName}"
    echo "Task 1 Complete"
    sleep 1
}

task2_0() {
    # creates tar
    echo "Starting Task 2"
    echo "Task 2.0: CD to Spigot Directory"
    cd "${mainDir}"
    pwd
}

task2_1() {
    echo "Task 2.1: Creating Tar"
    tar -czvf "${fileName}".tar.gz ./
    echo "Task 2 Complete"
    sleep 2
}

task3_0() {
    # moves tar to backups directory
    echo "Starting Task 3"
    echo "Task 3.0: Moving tar to backups directory"
    cp "${mainDir}/${fileName}.tar.gz" "${backupDir}"
}

task3_1() {
    # deletes tar from mc
    echo "Task 3.1: Deleting tar from Spigot Directory"
    rm "${fileName}.tar.gz"
    echo "Task 3 Complete"
    sleep 3
}

task4() {
    # unzipping tar
    echo "Starting Task 4"
    echo "Task 4.0: CD to backups directory"
    cd "${backupDir}"

    # if [ "$1" == "-u" ]; then
        echo "Task 4.1: Creating directory for tar"
        mkdir "./spigot_${fileName}"

        echo "Task 4.2: Unzipping tar to new directory"
        tar -xf "${fileName}".tar.gz -C ./spigot_"${fileName}"
        echo "Task 4 Complete"
    # else 
        # echo "Skipping Task 4.2: Unzipping tar to new directory"
    # fi
    sleep 3
}

task5() {
    # starts mc
    echo "Starting Task 5"
    echo "Task 5.0: Starting Spigot Container"
    docker start "${dockerName}"
    echo "Task 5 Complete"
}

# for var in "$@"
# do
#   echo "$var"
# done

programRun() {
    task0_1
    task0_2
    task0_3
    task1
    task2_0
    task2_1
    task3_0
    task3_1
    task4
    task5
}

echo $1
if [ "$1" == "-s" ]; then
    findCurrentAmount
fi

programRun

echo "Thank you for using the Spigot Backup Script"
