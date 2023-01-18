dateFileName="date +%Y-%m-%d"
echo "Starting Spigot Backup Script"

echo `Files will be named : ${dateFileName}`

# creates backups directory if it doesn't exist
echo "Starting Task 0"
echo "Task 0.0: Checking if backups directory exists"
if [ ! -d ~/backups/spigot ]; then
    echo "Task 0.1: Creating backups directory"
    mkdir ~/backups/spigot
fi

echo "Task 0.2: Checking if backup directory for today exists"
if [ -d ~/backups/spigot/spigot_`${dateFileName}` ]; then
    # echo "Task 0.2: Deleting old backups directory"
    # rm -rf ~/backups/spigot/${dateFileName}

    if [ "$1" == "-f" ]; then
        echo "Task 0.2.1: Deleting old backups directory"
        rm -rf ~/backups/spigot/spigot_`${dateFileName}`
    fi

    echo "Please add -f to force delete old backup for today"
    exit
fi

echo "Task 0.3: Checking if backup tar for today exists"
if [ -d ~/backups/spigot/`${dateFileName}`.tar.gz ]; then
    # echo "Task 0.2: Deleting old backups directory"
    # rm -rf ~/backups/spigot/${dateFileName}

    if [ "$1" == "-f" ]; then
        echo "Task 0.2.1: Deleting old backups directory"
        rm -rf ~/backups/spigot/`${dateFileName}`.tar.gz
    fi

    echo "Please add -f to force delete old backup for today"
    exit
fi
echo "Task 0 Complete"
sleep 1

# stops mc
echo "Starting Task 1"
echo "Task 1.0: Stopping Spigot Server"
docker exec spigot mc_stop
echo "Task 1.1 -- Stopping Spigot Container"
docker stop spigot
echo "Task 1 Complete"
sleep 1

# creates tar
echo "Starting Task 2"
echo "Task 2.0: CD to Spigot Directory"
cd ~/tank/spigot

echo "Task 2.1: Creating Tar"
tar -czvf `${dateFileName}`.tar.gz ./
echo "Task 2 Complete"
sleep 1

# moves tar to backups directory
echo "Starting Task 3"
echo "Task 3.0: Moving tar to backups directory"
cp ~/tank/spigot/`${dateFileName}`.tar.gz ~/backups/spigot

# deletes tar from mc
echo "Task 3.1: Deleting tar from Spigot Directory"
rm 2023-01-18.tar.gz
echo "Task 3 Complete"
sleep 1

# unzip tar
echo "Starting Task 4"
echo "Task 4.0: CD to backups directory"
cd ~/backups/spigot
echo "Task 4.1: Creating directory for tar"
mkdir ./spigot_`${dateFileName}`

# moves tar
echo "Task 4.2: Unzipping tar to new directory"
tar -xf `${dateFileName}`.tar.gz -C ./spigot_`${dateFileName}`
echo "Task 4 Complete"
sleep 1

# starts mc
echo "Starting Task 5"
echo "Task 5.0: Starting Spigot Container"
docker start spigot

echo "Task 5 Complete"
echo "Thank you for using the Spigot Backup Script"

# for var in "$@"
# do
#   echo "$var"
# done