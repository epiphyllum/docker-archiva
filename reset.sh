tfs-archiva stop
sudo docker rm -f tfs-archiva
tfs-archiva clean
tfs-archiva run
sudo docker logs -f tfs-archiva

