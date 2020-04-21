## Runing WORDPRESS

### Step 1 Create DB Network
~# docker network create -d bridge --subnet 192.168.79.0/24 dbnet
~# docker network create -d bridge --subnet 10.0.0.0/24 webnet

### Step 2
~# docker run --name db --net dbnet -d -e MYSQL_DATABASE='wpdb' -e MYSQL_USER='wpuser' -e MYSQL_PASSWORD='wppass' -e MYSQL_RANDOM_ROOT_PASSWORD='1' mysql:5.7 

~# docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' db

~# docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)

### Step 3 
~# dbip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' db)

~# docker run --name wp --net dbnet --net webnet -d -e WORDPRESS_DB_HOST='db.magedu.com' -e WORDPRESS_DB_USER='wpuser' -e WORDPRESS_DB_PASSWORKD='wppass' -e WORDPRESS_DB_NAME='wpdb' --add-host "db.magedu.com:${dbip}" wordpress:fpm-alpine
OR
~# docker run --name wp --net dbnet --net webnet -d --env-file wordpress/env.list --add-hosts "db.magedu.com:${dbip}" wordpress:fpm-alpine

### Step 4
~# wpip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' wp)
~# docker run --name nginx --net bridge -d --add-host "wp.magedu.com:${wpip} -v nginx/default.conf:/etc/nginx/conf.d/default.conf  nginx:alpine
