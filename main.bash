#! /bin/sh
scriptVersion="1.1.6"
dateFileName="date +%Y-%m-%d"
amountToday=0

backupDir=~/backups/spigot
mainDir=~/tank/spigot
dockerName=spigot

# backupDir=~/Backups
# mainDir=~/Developer/cheese
fileName=`${dateFileName}`

# Finds how many backups already today, and increments file name
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

# Shows help menu
helpMenuShow() {
    echo "-s    Creates secondary backup for today if it already exists";
    echo "-f    Forces backup, even if it already exists for today !!WILL DELETE PREVIOUS BACKUP FROM TODAY!!";
    echo "-h    Shows the help menu";
    echo "-u    Will unzip the tar file right away";
    echo "-v    Shows current version of script.";
}

# Shows version of script
showVersionNum() {
    # Update later to show the git version, in the git history
    echo "The current version of the script is ${scriptVersion}"
}

# Task 0.1: Checks if there is a directory for backups
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

# Task 0.2: Checks if there was already a backup directory for today
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

# Task 0.3: Checks if there was already a backup tar for today
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

# Task 1: Stops minecraft and minecraft container
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

# Task 2: CDs to spigot directory
task2_0() {
    # creates tar
    echo "Starting Task 2"
    echo "Task 2.0: CD to Spigot Directory"
    cd "${mainDir}"
    pwd
}

# Task 2.1: Creates tar file of minecraft files
task2_1() {
    echo "Task 2.1: Creating Tar"
    tar -czvf "${fileName}".tar.gz ./
    echo "Task 2 Complete"
    sleep 2
}

# Task 3.0: Copies the tar file to backups directory
task3_0() {
    # moves tar to backups directory
    echo "Starting Task 3"
    echo "Task 3.0: Moving tar to backups directory"
    cp "${mainDir}/${fileName}.tar.gz" "${backupDir}"
}

# Task 3.1: Deletes tar file from the main MC folder
task3_1() {
    # deletes tar from mc
    echo "Task 3.1: Deleting tar from Spigot Directory"
    rm "${fileName}.tar.gz"
    echo "Task 3 Complete"
    sleep 3
}

# Task 4: unzips the backup tar
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

# Task 5: Runs MC again
task5() {
    # starts mc
    echo "Starting Task 5"
    echo "Task 5.0: Starting Spigot Container"
    docker start "${dockerName}"
    echo "Task 5 Complete"
}

# Starting for program
startRun() {
    #clear
    echo "--------------"
    echo "Starting Spigot Backup Script"
    echo ""

}

# Ending for program
endRun() {
    echo ""
    echo "Thank you for using the Spigot Backup Script"
    echo "--------------"

    exit 0;
}

# Main running for program
programRun() {
    echo "Files will be named : ${fileName}"

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


exitEarly=false
i=0

flag_S=false
flag_C=false
flag_H=false
flag_V=false

# Check args input, and runs flag commands
for flag in "$@"
do
    #echo "$flag"
    if [ "$flag" == "-c" ]; then
        flag_C=true
    fi

    if [ "$flag" == "-s" ]; then
        flag_S=true
    fi

    if [ "$1" == "-h" ]; then
        flag_H=true
        exitEarly=true
    fi

    if [ "$flag" == "-v" ]; then
        flag_V=true
        exitEarly=true
    fi
    #echo $i
    #echo $flag
    #echo $(($@+1))
    i=$((i+1))
done

# Runs flag commands after, to allow for specific order
# Also makes sure only 1 for each command is ran
if [ "$flag_C" = true ]; then 
    clear
fi

startRun

if [ "$flag_S" = true ]; then 
    findCurrentAmount
fi

if [ "$flag_H" = true ]; then 
    helpMenuShow
fi

if [ "$flag_V" = true ]; then 
    # clears an extra line, looks nicer
    if [ "$flag_H" = true ]; then 
        echo ""
    fi
    showVersionNum
fi


# Ends early, before the backing up
if [ "$exitEarly" = true ]; then
    endRun
fi

# Runs main backup script 
programRun
endRun