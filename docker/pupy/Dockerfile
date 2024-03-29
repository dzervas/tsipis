FROM debian:stable-slim

LABEL maintainer "alxchk@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
RUN echo 'deb http://ftp.debian.org/debian stretch-backports main' >>/etc/apt/sources.list && \
	apt-get update && \
	mkdir -p /usr/share/man/man1/ && \
	apt-get install -t stretch-backports --no-install-recommends -y \
	build-essential python-dev python-pip openssh-server tmux sslh wget \
	libcap2-bin john vim-tiny less osslsigncode autoconf automake unzip \
	libtool locales ncurses-term bash tcpdump libpam-cap python-http-parser \
	openjdk-8-jdk-headless python-m2crypto python-cryptography jq curl \
	python-cffi-backend python-paramiko python-pefile python-netifaces \
	python-psutil python-lzma python-colorama python-openssl python-scapy \
	python-pygments python-requests python-httpbin python-rsa git && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /usr/share/doc* /usr/share/man/* /usr/share/info/*
RUN echo 'en_US.UTF-8 UTF-8' >/etc/locale.gen; locale-gen; echo 'LC_ALL=en_US.UTF-8' >/etc/default/locale
RUN useradd -m -d /home/pupy -s /bin/bash pupy
RUN mkdir -p /var/run/sshd /home/pupy/.config/pupy /home/pupy/.ssh /projects
RUN ln -sf /projects/keys/authorized_keys /home/pupy/.ssh/authorized_keys

RUN git clone https://github.com/n1nj4sec/pupy /opt/pupy
WORKDIR /opt/pupy/pupy
RUN cp conf/pupy.conf.docker /home/pupy/.config/pupy/pupy.conf && \
	cp conf/.bashrc /home/pupy/.bashrc.pupy && \
	cp conf/capability.conf /etc/security/capability.conf

RUN chmod +s /usr/sbin/tcpdump
RUN chown pupy:pupy -R /home/pupy; chmod 700 /home/pupy/.ssh
RUN echo 'source /home/pupy/.bashrc.pupy' >> /home/pupy/.bashrc

RUN pip install -r requirements.txt

RUN mkdir -p /opt/mimikatz && curl -s https://api.github.com/repos/gentilkiwi/mimikatz/releases/latest | \
	jq -r '.assets[] | select(.name == "mimikatz_trunk.zip") | .browser_download_url' | \
	wget -O /opt/mimikatz/mimikatz.zip -qi - &&  cd /opt/mimikatz && \
	unzip mimikatz.zip && rm -f mimikatz.zip

RUN apt-get remove -y autoconf automake python-dev libtool build-essential && \
    apt-get -y autoremove && rm -rf /root/.cache/pip && \
    rm -f /etc/ssh/ssh_host_*; rm -f /tmp/requirements.txt

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

EXPOSE 22 1080 5454 5454/udp 8080
VOLUME [ "/projects" ]

ENTRYPOINT [ "/opt/pupy/pupy/conf/pupyenv.sh" ]
CMD [ "default" ]
