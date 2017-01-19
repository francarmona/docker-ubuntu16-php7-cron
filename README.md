# docker-ubuntu16-php7-cron
A docker image for executing scheduled php scripts

## Pull the image

Pull the latest stable version from the [Docker Hub Registry](https://hub.docker.com/r/francarmona/docker-ubuntu16-php7-cron/)
```
docker pull francarmona/docker-ubuntu16-php7-cron:latest
```

If you prefer building the image from source, clone the repository and run docker build

```
git clone https://github.com/franCarmona/docker-ubuntu16-php7-cron.git
docker build -t francarmona/docker-ubuntu16-php7-cron .
```

## Run

Create the /path/to/cron.d directory and put your crontab file/s inside it. Make sure that ownership is root:root and permissions are 644 in other case cron did not run your crontab file/s.

```
mkdir -p /path/to/cron.d
nano /path/to/cron.d/task
sudo chmod -R g-w /path/to/cron.d
sudo chown root:root -R /path/to/cron.d
```

docker run -d -v /path/to/cron.d:/etc/cron.d --name cron docker-ubuntu16-php7-cron
