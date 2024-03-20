FROM ubuntu:20.04

RUN apt-get update && apt-get install -y openssh-server curl

# Install python
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install python3.11 -y
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 
RUN pip3.11 install poetry

# Prepare SSH
RUN mkdir /var/run/sshd
RUN echo 'root:root123' | chpasswd
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
COPY linux_ansible_id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys && \
    chown root:root /root/.ssh/authorized_keys

# Port settings
EXPOSE 22
EXPOSE 8000

CMD ["/usr/sbin/sshd", "-D"]

