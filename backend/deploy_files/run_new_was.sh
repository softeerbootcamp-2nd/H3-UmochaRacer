IS_GREEN=$(docker ps | grep green) # 현재 실행중인 App이 blue인지 확인합니다.
DEFAULT_CONF="/etc/nginx/nginx.conf"

if [ -z $IS_GREEN  ];
then # blue라면

  echo "### BLUE => GREEN ###"

  echo "1. green 이미지 가져옴"
  docker-compose pull green # green으로 이미지를 내려받습니다.

  echo "2. green 컨테이너 올림"
  docker-compose up -d green # green 컨테이너 실행

  while [ 1 = 1 ]; do
  echo "3. green health check..."
  sleep 3

  REQUEST=$(curl http://127.0.0.1:8080) # green으로 request
    if [ -n "$REQUEST" ]; then # 서비스 가능하면 health check 중지
            echo "health check success"
            break ;
            fi
  done;

  echo "4. nginx 재가동"
  sudo cp nginx.green.conf /etc/nginx/nginx.conf
  sudo nginx -s reload

  echo "5. blue 컨테이너 내림"
  docker-compose stop blue
else
  echo "### GREEN => BLUE ###"

  echo "1. blue 이미지 가져옴"
  docker-compose pull blue

  echo "2. blue 컨테이너 올림"
  docker-compose up -d blue

  while [ 1 = 1 ]; do
    echo "3. blue health check..."
    sleep 3
    REQUEST=$(curl http://127.0.0.1:8081) # blue로 request

    if [ -n "$REQUEST" ]; then # 서비스 가능하면 health check 중지
      echo "health check success"
      break ;
    fi
  done;

  echo "4. nginx 재가동" 
  sudo cp nginx.blue.conf /etc/nginx/nginx.conf
  sudo nginx -s reload

  echo "5. green 컨테이너 내림"
  docker-compose stop green
fi