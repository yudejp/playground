FROM alpine

ADD ./motd /etc/motd
ADD ./add-ssh-key.sh
ADD ./add-packages.sh
ADD ./packages.txt

RUN apk add --no-cache openssh && \
    mkdir /var/run/sshd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    sh ./add-ssh-key.sh
    sh ./add-packages.sh

EXPOSE 22

CMD mkdir -p ~/.ssh && \
    mv ~/authorized_keys ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys &&  \
    /usr/sbin/sshd -D