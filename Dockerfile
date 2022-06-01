FROM alpine

ADD ./motd /etc/motd
WORKDIR /root
ADD ./add-ssh-key.sh ./
ADD ./add-packages.sh ./
ADD ./packages.txt ./

RUN apk add --no-cache openssh && \
    mkdir /var/run/sshd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    apk add --no-cache curl && \
    sh ./add-ssh-key.sh && \
    apk del curl && \
    sh ./add-packages.sh && \
    rm add-ssh-key.sh add-packages.sh packages.txt && \
    mkdir -p /root/.ssh && \
    mv /root/authorized_keys /root/.ssh/authorized_keys && \
    chmod 0600 /root/.ssh/authorized_keys

EXPOSE 22

CMD /usr/sbin/sshd -D