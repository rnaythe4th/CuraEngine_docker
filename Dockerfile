FROM ubuntu:24.04
LABEL version="0.1"
EXPOSE 8080
ENV PORT=8080
RUN apt update
RUN apt install -y python3.12-full 
RUN alias python=python3 
RUN apt install -y python3-pip 
RUN apt install -y pipx 
RUN pipx ensurepath
RUN pipx install conan 
RUN pipx ensurepath 
RUN pip install Jinja2 --break-system-packages
RUN apt install -y ninja-build
RUN apt install -y cmake
RUN apt install -y git
WORKDIR /root
RUN git clone https://github.com/Ultimaker/CuraEngine.git 
ENV PATH="$PATH:/root/.local/share/pipx/venvs/conan/bin"
WORKDIR /root
RUN conan config install https://github.com/ultimaker/conan-config.git 
RUN conan profile detect --force 
WORKDIR /root/CuraEngine
RUN conan install . --build=missing --update
RUN cmake --preset conan-release
RUN cmake --build --preset conan-release
RUN . build/Release/generators/conanrun.sh
WORKDIR /root
RUN mkdir InputModels
RUN mkdir OutputGcode
RUN mkdir PrinterConfig
COPY Sharp_bullet.stl /root/InputModels/
#COPY Ender_scorpion.json /root/PrinterConfig
ADD /definitions/ /root/PrinterConfig
ADD /extruders/ /root/PrinterConfig
ENV PATH="$PATH:/root/CuraEngine/build/Release"
RUN mkdir Downloads
WORKDIR /root/Downloads
RUN apt install curl
RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
WORKDIR /root
ADD /server /root/server
RUN apt install -y nodejs
WORKDIR /root/server
RUN npm install
