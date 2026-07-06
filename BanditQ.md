11. - Q. The password for the next level is stored in the file data.txt, where all lowercase (a-z) and uppercase (A-Z) letters have been rotated by 13 positions

```py
$ cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

12. - Q. The password for the next level is stored in the file data.txt, which is a hexdump of a file that has been repeatedly compressed. For this level it may be useful to create a directory under /tmp in which you can work. Use mkdir with a hard to guess directory name. Or better, use the command “mktemp -d”. Then copy the datafile using cp, and rename it using mv (read the manpages!)

***steps***

```py
# 1. Create workspace
$(mktemp -d) = tmpdir
cd $tmpdir tmpdir

# 2. Copy file
cp ~/data.txt .

# 3. Reverse hexdump → binary
xxd -r data.txt > file

# 4. Check type
file file   # → gzip

# 5. Decompress gzip
mv file file.gz
gunzip file.gz

# 6. Check again
file file   # → bzip2

# 7. Decompress bzip2
mv file file.bz2
bunzip2 file.bz2

# 8. Check again
file file   # → tar

# 9. Extract tar
tar -xf file

# 10. Repeat process (VERY IMPORTANT)
file *
```

13. - Q. The password for the next level is stored in /etc/bandit_pass/bandit14 and can only be read by user bandit14. For this level, you don’t get the next password, but you get a private SSH key that can be used to log into the next level. Look at the commands that logged you into previous bandit levels, and find out how to use the key for this level.

```py
$ scp -P 2220 bandit13@bandit.labs.overthewire.org:~/sshkey.private ~/bandit13 # on localhost cli

$ chmod 700 ~/bandit13 # to give permission to cp.

$ ssh -i bandit13 bandit14@bandit.labs.overthewire.org -p 2220 # cp into bandit14 ./ssh

```

14. The password for the next level can be retrieved by submitting the password of the current level to port 30000 on localhost.

```py
$ bandit14@bandit:~$ nc localhost 30000
aaWecNkG4FhxJQxz07uiwzVP6bJiYS65
```
15. The password for the next level can be retrieved by submitting the password of the current level to port 30001 on localhost using SSL/TLS encryption.
```bash
$ openssl s_client -connect localhost:30001
pbLYuZtTg4MgaqfJx8jbA9gKKGqM68A7
```

17.The credentials for the next level can be retrieved by submitting the password of the current level to a port on localhost in the range 31000 to 32000. First find out which of these ports have a server listening on them. Then find out which of those speak SSL/TLS and which don’t. There is only 1 server that will give the next credentials, the others will simply send back to you whatever you send to it.

- The `-ign_eof(ignore End-Of-File)` used to keep a connection open after the standard input (stdin) has closed in an openssl network connection.

```py
$ nmap -p 31000-32000 localhost # to find open ports
$ openssl s_client -connect localhost:31790 -ign_eof # prevent network from closing
$ mktemp -d # create a dir to store the private sshkey.
$ touch sshprivate.key # cp sshkey
$ nano sshprivate.key # paste key here
$ exit # to use local terminal
$ scp -P bandit16@bandit.labs.overthewire.org:/tmp/key/sshprivate.key ~./bandit17.key
$ chmod 600 bandit17.key # grant permission.
$ ssh -i bandit17.key bandit17@bandit.labs.overthewire.org -p 2220 # access to bandit 17.
```
19.The password for the next level is stored in a file readme in the homedirectory. Unfortunately, someone has modified .bashrc to log you out when you log in with SSH.
```py
# override bashrc
$ ssh bandit19@bandit.labs.overthewire.org -p 2220  cat readme
     or
$ ssh -t bandit19@bandit.labs.overthewire.org -p 2220 /bin/sh or /bin/dash     
    
    or
$ ssh -t bandit19@bandit.labs.overthewire.org -p 2220 'bash --norc --noprofile'

# Rename the broken file.

$ ssh bandit19@bandit.labs.overthewire.org -p 'mv ~/.bashrc  ~/.bashrc.bak'

```
