################################################
# Build ros-base                               #
# (ROS image with default packages)           #
################################################
FROM osrf/ros:noetic-desktop-full AS ros-base
ENV DEBIAN_FRONTEND=noninteractive

#RUN pip3 install cfdp pymongo tornado

# Switch to bash shell
SHELL ["/bin/bash", "-c"]


# Create a brash user
#ENV USERNAME ubuntu
#ENV HOME_DIR=/home/${USERNAME}
ENV CODE_DIR=/code

# Dev container arguments
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

# Create new user and home directory
#RUN groupadd --gid ${USER_GID} ${USERNAME} \
#&& useradd --uid ${USER_UID} --gid ${USER_GID} --create-home ${USERNAME} \
#&& echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
#&& chmod 0440 /etc/sudoers.d/${USERNAME} \
#&& mkdir -p ${CODE_DIR} \
#&& chown -R ${USER_UID}:${USER_GID} ${CODE_DIR}

RUN mkdir -p ${CODE_DIR} \
  && chown -R ${USER_UID}:${USER_GID} ${CODE_DIR}

# Swith to username
#USER ${USERNAME}
WORKDIR ${CODE_DIR}


################################################
# Build noetic-dev                             #
################################################

FROM ros-base AS jaxa-roscfe-dev
ENV DEBIAN_FRONTEND=noninteractive

RUN sudo apt-get update \
 &&  sudo apt-get install -y \
  python3-pip \ 
  ros-noetic-geometric-shapes \
  ros-noetic-octomap-msgs \
  ros-noetic-srdfdom \
  ros-noetic-joint-state-publisher-gui \
  ros-noetic-control-msgs \
  ros-noetic-controller-manager-msgs \
  ros-noetic-joint-trajectory-controller \
  ros-noetic-angles \
  ros-noetic-controller-manager \
  ros-noetic-hardware-interface \
  libboost-filesystem-dev \
  libnlopt-dev \
  xterm \
  gdb \
  ros-noetic-catkin \
  ros-noetic-moveit-ros-planning

#RUN  pip3 install toppra --break-system-packages


RUN sudo mkdir -p ${CODE_DIR} && \
   sudo chown -R ${USERNAME}:${USERNAME} ${CODE_DIR}


# Get ready with ROS workspace
RUN mkdir -p ${CODE_DIR}/ros_ws

# Make workspace brash
WORKDIR ${CODE_DIR}/ros_ws
