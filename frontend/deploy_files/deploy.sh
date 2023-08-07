#!/bin/bash

echo "> 현재 실행 중인 Docker 컨테이너 pid 확인" >> /home/ubuntu/deploy.log
FRONTEND_PID=$(sudo docker container ls --filter "name=front" -q)

if [ -z $FRONTEND_PID ]
then
  echo "> 현재 구동중인 웹 Docker 컨테이너가 없으므로 종료하지 않습니다." >> /home/ubuntu/deploy.log
else
  echo "> sudo docker stop $FRONTEND_PID" >> /home/ubuntu/deploy.log
  sudo docker stop $FRONTEND_PID
  sleep 5
  sudo docker rm $FRONTEND_PID
  sudo docker rmi $(docker images --filter=reference="h3-umocharacer-front" -q)
fi

cd /home/ubuntu/app/frontend/nginx
sudo docker build -t h3-umocharacer-front .
sudo docker run -d --name h3-umocharacer-front -v ../dist:/usr/share/nginx/html -p 80:80 h3-umocharacer-front