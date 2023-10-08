FROM ubuntu:22.04

LABEL version="1.0"
LABEL description="Dockerized pintos for POSTECH [CSED312]Operating System. Using qemu, confirmed operation on M1 MacBook Pro."

ENV DEBIAN_FRONTEND=noninteractive
ENV PINTOSPATH="/pintos"
ENV PATH="$PATH:/$PINTOSPATH/src/utils"

RUN sed -i "s/archive.ubuntu.com/mirror.kakao.com/g" /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential libncurses5-dev texinfo gdb gcc-multilib
RUN apt-get install -y qemu-system-x86 libvirt-daemon-system libvirt-clients
RUN apt-get install -y wget vim zsh git

WORKDIR /tmp

RUN sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN sed -i 's/ZSH_THEME=robbyrussell/ZSH_THEME="agnoster"/g' /root/.zshrc

RUN git clone git://pintos-os.org/pintos-anon pintos
RUN mv ./pintos /pintos && rm -rf *

RUN sed -i 's/SIMULATOR = --bochs/SIMULATOR = --qemu/g' /pintos/src/threads/Make.vars
RUN sed -i 's/$sim = "bochs" if !defined $sim;/$sim = "qemu" if !defined $sim;/g' /pintos/src/utils/pintos
RUN sed -i "s,GDBMACROS=/usr/class/cs140/pintos/pintos/src/misc/gdb-macros,GDBMACROS=$PINTOSPATH/src/misc/gdb-macros,g" /pintos/src/utils/pintos-gdb
RUN sed -i 's/LOADLIBES/LDLIBS/g' /pintos/src/utils/Makefile

WORKDIR /pintos/src/threads
RUN make

WORKDIR /pintos

CMD ["/usr/bin/zsh"]