#! /bin/sh
docker image build . -t tmux_sshd_container
docker run -d -p 10000:22 -v /tmp/tmux_shared_sock:/tmp/tmux_shared_sock:ro tmux_sshd_container
