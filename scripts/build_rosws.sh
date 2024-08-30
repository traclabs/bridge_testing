#!/usr/bin/env bash

echo ""
echo "##### Building rosws #####"
echo ""

COMPOSE_FILE="docker-compose-dev.yml"
CODE_DIR="/code"
DISTRO="kinetic"

build_rosws_code() {
  docker compose -f ${COMPOSE_FILE} run -w ${CODE_DIR}/craftsman_ws rosws /bin/bash  -ic "source /opt/ros/${DISTRO}/setup.bash && catkin build -j4 vehtek_2d_ui"
  ret=$?
  if [ $ret -ne 0 ]; then
    echo "!! Failed in catkin build step for brash !!"
    return 1  
  fi
  
  return 0
}

# Going...
echo "**** Building rosws... ****"
build_rosws_code
rosws_res=$?

if [ $rosws_res -eq 1 ]; then
  exit 1
fi

echo ""
echo "##### Done! #####"
exit 0

