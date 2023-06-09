docker pull mysql:latest
mkdir -p mkdir -p /mnt/d/storage/docker/energymobile-data
docker run \
--detach \
--name=energymobile \
--env="MYSQL_ROOT_PASSWORD= " \
--publish 33061:3306 \
--volume=/root/docker/energymobile/conf.d:/etc/mysql/conf.d \
--volume=/d/storage/docker/energymobile-data:/var/lib/mysql \
mysql
docker start energymobile