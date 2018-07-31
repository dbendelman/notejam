# Notejam under Docker

## Quick Start

```
cd flask
docker build -t notejam .

# Start the database:
docker run -d --name=mariadb -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=password \
    mariadb:10.3.8

# Initialize the db:
docker exec -t mariadb mysql -u root -ppassword -e \
    "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password'; \
    CREATE DATABASE IF NOT EXISTS notejam;"

MYSQL_HOST="$(docker network inspect bridge --format='{{json .IPAM.Config}}' | jq -r .[0].Gateway)"

# Initialize models:
docker run -it --rm --name=notejam-db-init \
    -e MYSQL_HOST=$MYSQL_HOST \
    notejam \
        python db.py

# Run the app:
docker run -it --rm --name=notejam -p 5000:5000 \
    -e MYSQL_HOST=$MYSQL_HOST \
    notejam
```
