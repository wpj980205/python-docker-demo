conda create -n python_docker python=3.9.6
conda activate python_docker
pip install Flask
pip freeze > requirements.txt
echo '
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, Docker! '
' > app.py
python -m flask run



docker build --tag python-docker .
docker scan
docker tag python-docker:latest python-docker:v1.0.0
docker images
docker rmi python-docker:v1.0.0



docker run python-docker
curl localhost:5000
docker run --publish 5000:5000 python-docker
docker run -d -p 5000:5000 python-docker
docker ps
docker stop wonderful_kalam
docker ps -a
docker restart wonderful_kalam
docker rm wonderful_kalam agitated_moser goofy_khayyam
docker run -d -p 5000:5000 --name rest-server python-docker



docker volume create mysql
docker volume create mysql_config
docker network create mysqlnet
docker run --rm -d -v mysql:/var/lib/mysql -v mysql_config:/etc/mysql -p 3306:3306 --network mysqlnet --name mysqldb -e MYSQL_ROOT_PASSWORD=p@ssw0rd1 mysql
docker exec -ti mysqldb mysql -u root -p
# p@ssw0rd1
pip install mysql-connector-python
pip freeze > requirements.txt
docker build --tag python-docker-dev .
docker run --rm -d --network mysqlnet --name rest-server -p 5000:5000 python-docker-dev
curl http://localhost:5000/initdb
curl http://localhost:5000/widgets


echo '
version: '3.9'

services:
 web:
  build:
   context: .
  ports:
  - 5000:5000
  volumes:
  - ./:/app

 mysqldb:
  image: mysql
  ports:
  - 3306:3306
  environment:
  - MYSQL_ROOT_PASSWORD=p@ssw0rd1
  volumes:
  - mysql:/var/lib/mysql
  - mysql_config:/etc/mysql

volumes:
  mysql:
  mysql_config:
' > docker-compose.dev.yml
docker-compose -f docker-compose.dev.yml up --build
curl http://localhost:5000/initdb
curl http://localhost:5000/widgets



