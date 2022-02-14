FROM dorowu/ubuntu-desktop-lxde-vnc:xenial
LABEL ron0401.ros.vnc.devenv.docker.source=https://github.com/ron0401/ros-vnc-devenv-docker.git

# install packages
RUN apt-get update && apt-get install -q -y --no-install-recommends \
    dirmngr \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros1-latest.list

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO kinetic

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-kinetic-ros-core \
    && rm -rf /var/lib/apt/lists/*

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-kinetic-ros-base \
    && rm -rf /var/lib/apt/lists/*

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-kinetic-robot \
    && rm -rf /var/lib/apt/lists/*

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-kinetic-desktop \
    && rm -rf /var/lib/apt/lists/*

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-kinetic-desktop-full \
    && rm -rf /var/lib/apt/lists/*

ENV USER ubuntu
RUN echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc