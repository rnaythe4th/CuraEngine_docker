FROM ubuntu:24.04
LABEL version="0.1"
EXPOSE 8080
ENV PORT=8080

# install all reqiured packages
RUN apt update
RUN apt install -y python3.12-full \
    && alias python=python3 \
    && apt install -y python3-pip \
    && apt install -y pipx \
    && pipx ensurepath \
    && apt install -y ninja-build \
    && apt install -y cmake \
    && apt install -y git \
    && apt install curl

# install some pip packages
RUN pip install Jinja2 --break-system-packages
RUN pipx install conan 
RUN pipx ensurepath
# add conan to PATH
ENV PATH="$PATH:/root/.local/share/pipx/venvs/conan/bin"

# clone CuraEngine repository
WORKDIR /root
RUN git clone https://github.com/Ultimaker/CuraEngine.git 

# build CuraEngine
RUN conan config install https://github.com/ultimaker/conan-config.git 
RUN conan profile detect --force 
WORKDIR /root/CuraEngine
RUN conan install . --build=missing --update
RUN cmake --preset conan-release
RUN cmake --build --preset conan-release
RUN . build/Release/generators/conanrun.sh
# add CuraEngine to PATH
ENV PATH="$PATH:/root/CuraEngine/build/Release"

# create directories for futher use
WORKDIR /root
RUN mkdir InputModels \
    && mkdir OutputGcode \
    && mkdir PrinterConfig \
    && mkdir Downloads

# copy printer configs and example model
COPY /3D_Models/Sharp_bullet.stl /root/InputModels/
ADD /PrinterConfigs/definitions/ /root/PrinterConfig
ADD /PrinterConfigs/extruders/ /root/PrinterConfig
# copy node.js server to image
ADD /server /root/server

# install Node 20
WORKDIR /root/Downloads
RUN curl -fsSL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt install -y nodejs

# install server dependencies
WORKDIR /root/server
RUN npm install
