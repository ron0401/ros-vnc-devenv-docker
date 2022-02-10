FROM dorowu/ubuntu-desktop-lxde-vnc:bionic

# setup timezone
# RUN echo 'Etc/UTC' > /etc/timezone && \
#     ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
#     apt-get update && \
#     apt-get install -q -y --no-install-recommends tzdata && \
#     rm -rf /var/lib/apt/lists/*

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros1-latest.list

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO melodic

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-ros-core=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]

RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

# LABEL maintainer="Tiryoh<tiryoh@gmail.com>"



# RUN apt-get update && \
#     # apt-get upgrade -yq && \
#     # apt-get install -yq wget curl git build-essential vim sudo lsb-release locales bash-completion tzdata gosu && \
#     apt-get install -yq wget curl sudo && \
#     rm -rf /var/lib/apt/lists/*


# COPY ros-install.sh /tmp/
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
# RUN /tmp/ros-install.sh melodic
# RUN useradd --create-home --home-dir /home/ubuntu --shell /bin/bash --user-group --groups adm,sudo ubuntu && \
#     echo ubuntu:ubuntu | chpasswd && \
#     echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
# # RUN git clone https://github.com/Tiryoh/ros_setup_scripts_ubuntu.git /tmp/ros_setup_scripts_ubuntu && \
# #     gosu ubuntu /tmp/ros_setup_scripts_ubuntu/ros-kinetic-desktop.sh && \
# #     rm -rf /var/lib/apt/lists/*
# ENV USER ubuntu