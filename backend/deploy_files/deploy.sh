#!/bin/bash

echo "> 현재 실행 중인 Docker 컨테이너 pid 확인" >> /home/ubuntu/deploy.log
BACKEND_PID=$(sudo docker container ls --filter "name=back" -q)

if [ -z $BACKEND_PID ]
then
  echo "> 현재 구동중인 서버 Docker 컨테이너가 없으므로 종료하지 않습니다." >> /home/ubuntu/deploy.log
else
  echo "> sudo docker stop $BACKEND_PID" >> /home/ubuntu/deploy.log
  sudo docker stop $BACKEND_PID
  sleep 5
  sudo docker rm $BACKEND_PID
  sudo docker rmi $(sudo docker images --filter=reference="h3-umocharacer-back" -q)
fi

cd /home/ubuntu/app/backend
sudo docker build -t h3-umocharacer-back .
sudo docker run -d --name h3-umocharacer-back --restart=always -p 9999:9999 h3-umocharacer-back
