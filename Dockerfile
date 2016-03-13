FROM alpine:3.3
MAINTAINER Ingo Peter <sosyco@googlemail.com>

VOLUME ["/etc/ssh/containeradmin"]

# Setup ssh and install supervisord
RUN apk update
RUN apk upgrade
RUN apk add openssh supervisor 
RUN ssh-keygen -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t ecdsa -N '' -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -t ed25519 -N '' -f /etc/ssh/ssh_host_ed25519_key
RUN mkdir /var/run/sshd
RUN mkdir /var/log/supervisor
RUN sed -i 's/AuthorizedKeysFile.*/AuthorizedKeysFile      \/etc\/ssh\/\%u\/authorized_keys/' /etc/ssh/sshd_config
RUN adduser -D -s /bin/ash containeradmin
RUN sed -i 's/containeradmin:!/containeradmin:/' /etc/shadow
# sudo for the containeradmin will not function this way.
# for the moment: don't know
# workaround in containerinit.ash
#RUN apk add sudo
#RUN echo "containeradmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# Setup services at containerstart
RUN cp /etc/supervisord.conf /etc/supervisord.conf.org
ADD supervisord.conf /etc/supervisord.conf
ADD containerinit.ash /usr/local/bin/containerinit.ash
RUN chmod 755 /usr/local/bin/containerinit.ash
EXPOSE 22 
ENTRYPOINT ["/usr/local/bin/containerinit.ash"]
CMD ["cont:start"]
