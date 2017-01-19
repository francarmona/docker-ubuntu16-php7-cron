# docker-ubuntu16-php7-cron
A docker image for executing scheduled php scripts

docker run -d -v /home/fran/githubProjects/docker-ubuntu16-php7-cron/tasks:/etc/cron.d/tasks --name cron1 docker-ubuntu16-php7-cron

https://denibertovic.com/posts/handling-permissions-with-docker-volumes/

* * * * * root echo "Hello world" >> /var/log/cron.log 2>&1
