FROM ubuntu:22.04
ARG PROJECT=compmicro-biautils-env
ARG SRC_DIR=/src/${PROJECT}

# below env var required to install libglib2.0-0 non-interactively
ENV TZ=America/Los_Angeles
ARG DEBIAN_FRONTEND=noninteractive

# install python resources + graphical libraries used by qt and vispy
RUN apt-get update && \
    apt-get install -qqy  \
        build-essential \
        python3.10 \
        python3-pip \
        git \
        mesa-utils \
        x11-utils \
        libegl1-mesa \
        libopengl0 \
        libgl1-mesa-glx \
        libglib2.0-0 \
        libfontconfig1 \
        libxrender1 \
        libdbus-1-3 \
        libxkbcommon-x11-0 \
        libxi6 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-randr0 \
        libxcb-render-util0 \
        libxcb-xinerama0 \
        libxcb-xinput0 \
        libxcb-xfixes0 \
        libxcb-shape0 \
        && apt-get clean

COPY . ${SRC_DIR}

ARG REF_NAME=""
# We use the REF_NAME build-arg to reset the docker cache, which prevents
# using a cached build with. Without this, setuptools-scm may not produce
# the correct version.
RUN echo "REF_NAME: $REF_NAME"

RUN pip install --upgrade pip setuptools pip-tools && \
  pip install /src/${PROJECT}

RUN python3 -m unittest discover

ENTRYPOINT ["python3", "-m", "napari"]
