# tmux_sshd_container

You can share your tmux session with the guests as **a readonly session** using ssh **securely**.

* Host's Port: 10000
* Host's Socket: /tmp/tmux_shared_session/tmux_shared_sock
* Host's Session: tmux_shared_session

## Required

* docker
* tmux

## Usage

### 1. Setup your tmux session.

```
sudo mkdir /tmp/tmux_shared_session
sudo chmod 777 /tmp/tmux_shared_session
tmux -S /tmp/tmux_share_sock new -s tmux_shared_session
```

### 2. Setup the authorized_keys.

* Add the users' ssh private keys sharing the tmux session to `authorized_keys` file.

e.g.
```
cat id_ed25519.pub >> authorized_keys
```

### 3. Run setup.sh

```
./setup.sh
````
