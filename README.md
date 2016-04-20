# alpine_docker_ssh
Base-example to create a container-playground with ssh and central ssh-key.

To create an user on the linux-host:
```
ssh-keygen -f containeradmin -t rsa -b 4096 -C containeradmin -N ''
mkdir -p /home/<dockeradmin>/container/ssh/containeradmin
cp containeradmin.pub /home/<dockeradmin>/container/ssh/containeradmin/authorized_keys
chmod 755 -R /home/<dockeradmin>/container/ssh/containeradmin
```
For an Example look also at: https://github.com/sosyco/alpine-dockerhost
