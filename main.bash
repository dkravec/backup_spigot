dateFileName="date +%Y-%m-%d" && echo `$dateFileName` && mkdir `${dateFileName}`_Test

# stops mc
docker exec spigot mc_stop
docker stop spigot

# creates tar
cd ~/tank/spigot
tar -czvf 2023-01-18.tar.gz ./

# moves tar
cp ~/tank/spigot/`${dateFileName}`.tar.gz ~/backups/spigot

# deletes tar from mc
rm 2023-01-18.tar.gz

# unzip tar
cd ~/backups/spigot
mkdir `${dateFileName}`
tar -xf `${dateFileName}`.tar.gz -C ./`${dateFileName}`

# starts mc
docker start spigot

