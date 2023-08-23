#!/bin/bash

echo "> 프론트엔드 빌드 파일을 복사합니다."
sudo cp /home/ubuntu/web/frontend/dist /usr/share/nginx/html

echo "> Nginx를 재가동 합니다."
sudo nginx -s reload