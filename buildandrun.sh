docker stop busygit
docker rm busygit
docker rmi busyboxgit

docker build -t busyboxgit /root/busyboxgit
docker run -it -d --name busygit -p 8080:8080 busyboxgit
docker exec -it busygit /bin/sh
