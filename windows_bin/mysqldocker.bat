docker stop mysql_host & docker rm mysql_host & docker run --name=mysql_host -dit -e MYSQL_ROOT_PASSWORD=root --publish 3316:3306 --volume=E:\dev\mysql_data:/var/lib/mysql mysql:5.7

