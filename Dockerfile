FROM ubuntu:16.04

RUN apt-get update && apt-get install -y openssh-server tmux
RUN mkdir /var/run/sshd
RUN echo "Passwordauthentication no" >> /etc/ssh/sshd_config
RUN echo "Match User tmux_login" >> /etc/ssh/sshd_config
RUN echo "  ForceCommand /usr/bin/tmux -S /tmp/tmux_shared_sock/tmux_shared_sock attach -t tmux_shared_sock -r" >> /etc/ssh/sshd_config
RUN mkdir /tmp/tmux_shared_sock
RUN chmod 777 /tmp/tmux_shared_sock
RUN useradd -m -s /bin/bash -U tmux_login 
RUN su -- tmux_login
RUN cat /dev/zero | ssh-keygen -q -N ""
COPY authorized_keys /home/tmux_login/.ssh/authorized_keys
RUN chmod 600 /home/tmux_login/.ssh/authorized_keys
RUN exit
RUN chown tmux_login:tmux_login /home/tmux_login/.ssh/authorized_keys

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
