### **Firewall (UFW)**

Manage network access.

```bash
sudo ufw enable             # Turn on firewall
sudo ufw status             # Check status
sudo ufw allow ssh          # Allow default SSH
sudo ufw allow 2220         # Allow specific port
sudo ufw deny 23            # Block Telnet
```

### **GitHub & SSH**

1. Generate key: `ssh-keygen -t ed25519 -C "github" || ssh-keygen -t rsa`
2. Copy public key: `cat ~/.ssh/id_ed25519.pub`
3. Add to GitHub Settings -> SSH Keys.
4. Configure Git:

    ```bash
    git config --global user.name "Your Name"
    git config --global user.email "email@example.com"
    git config --global --list # test config--
    ```

---

### **Configure passphrase**

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519 # add private key
ssh-add -l # confirm key is loaded
```

---



### **GNU.**

 `uname -m`   <!-- Show Computer Processor.  -->

`kill -9 #`    <!-- Kill process -->

 <!-- Deleting file/apps -->

 ```py
 1.sudo apt remove --purge filename
 2.sudo apt autoremove

 ##Bonus; $npm uninstall -g filename
 ```

### System DNS

**systemctl** = manage services

**resolvectl** = check DNS

**systemd-resolved** = the actual DNS service running in the background

 <!-- Reset DNS connection -->

 ```py
 1. $ sudo rm /etc/resolv.conf

    $ sudo ln -s /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

 2. $ resolvectl status wlp2s0 

 3. $ ping -c 2 8.8.8.8  # Check dns

 4. $ ping -c 2 google.com # checks connection 
 ```

### Connecting Nextdns

```py
$ sudo nano /etc/systemd/resolved.conf
(add script from nextdns web)
$ sudo systemctl restart systemd-resolved
$ systemctl daemon-reload (reloads units).
```

etc/ == File Cabinet,Where all the system settings are stored.

systemd/ ==The Manager,The software suite that runs the OS.

resolved.conf == The Address Book,The settings for how your computer finds websites.

### Auto Updates.

```py
$ sudo apt install unattended-upgrades.
$ sudo dpkg-reconfigure –priority=low unattended-upgrades.
```

### Overloading a port.

- Installing iftop for observation`
`$ sudo apt install iftop`
`$ sudo iftop (run)`

- Test by running;
`$ sudo ping -s 1300 -f 172.18.0.11 `

- For heavy loading install;

`$ sudo apt install hping3`
`$ sudo hping3 -S -V  --flood 172.18.0.11`
