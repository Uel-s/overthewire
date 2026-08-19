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

20. To gain access to the next level, you should use the setuid binary in the homedirectory. Execute it without arguments to find out how to use it. The password for this level can be found in the usual place (/etc/bandit_pass), after you have used the setuid binary.

NOTE: We are loggedin as bandit19 so we have no privileges for bandit20

```py
$ ll # search for a SETUID file

$ ./bandit20-do whoami # to see owner 

$ ./bandit20-do cat /etc/bandit_pass/bandit20 # Accessing files as bandit19 due to SETUID privilege 

21.There is a setuid binary in the homedirectory that does the following: it makes a connection to localhost on the port you specify as a commandline argument. It then reads a line of text from the connection and compares it to the password in the previous level (bandit20). If the password is correct, it will transmit the password for the next level (bandit21).

```bash
$ tmux new -s bandit20

$ nc -l 4040 # Submit password bandit20 4pIjcunZ0fK2vmp3IwfG8Vf7VhxD6pOA

$ Ctrl B + % # To split terminal.

$ ./suconnect 4444 # wait and the password will show.

```
22. A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.

```bash
$ ll
$ cat cronjob_bandit22
cat /usr/bin/cronjob_bandit22.sh 
cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
```

23. A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.

```bash
$ cd etc/cron.d
$ cat cronjob_bandit23
$ cat /usr/bin/cronjob_bandit23.sh 
```
### Output Script

```bash
#!/bin/bash
myname=$(whoami) 
mytarget=$(echo I am user $myname | md5sum | cut -d ' ' -f1)
# md5sum used to hash the text: output --> 8ca319486bfbbc3663ea0fbe81326349 -
# `cut -d ' ' -f1` extracts the first field from the input and discards all remaining fields.
# Example: 8ca319486bfbbc3663ea0fbe81326349 (See the - missing)
echo "Copying passwordfile /etc/bandit_pass/$myname to /tmp/$mytarget"
```
```bash
$ echo I am user bandit23 | md5sum | cut -d ' ' -f1
#8ca319486bfbbc3663ea0fbe81326349
$ cat /tmp/8ca319486bfbbc3663ea0fbe81326349
```

24. A program is running automatically at regular intervals from cron, the time-based job scheduler. Look in /etc/cron.d/ for the configuration and see what command is being executed.

NOTE: This level requires you to create your own first shell-script. This is a very big step and you should be proud of yourself when you beat this level!

NOTE 2: Keep in mind that your shell script is removed once executed, so you may want to keep a copy around

```bash

$ cat /etc/cron.d/cronjob_bandit24
$ cat /usr/bin/bandit24.sh # Read the script and understand it
$ mkdir /tmp/mydir24
$ chmod 777 /tmp/mydir24
$ cd /tmp/mydir24
$ nano bandit24.sh
cat /etc/bandit_pass/bandit24 > /tmp/mydir24/password.txt
$ chmod +x bandit24.sh
$ ll # make sure bandit24.sh is executable 
$ cd ~
$ cp /tmp/mydirb24/bandit24.sh /var/spool/bandit24/foo/script.sh # cp my script into the cron time-based job scheduler wait 60s
$ cat cat /tmp/mydir24/password # password will show.
```

25.A daemon is listening on port 30002 and will give you the password for bandit25 if given the password for bandit24 and a secret numeric 4-digit pincode. There is no way to retrieve the pincode except by going through all of the 10000 combinations, called brute-forcing.
You do not need to create new connections each time

```bash
$ mkdir  /tmp/BandiT25
$ chmod /tmp/BandiT25
$ cd /tmp/BanditT25
$ nano bandit25.sh

#!/bin/bash

for char in {0..9}{0..9}{0..9}{0..9}; do
# Try every possible 4-digit PIN: 0000 → 9999.

    result=$(echo "TOKEN $char" | ncat localhost 30002 | grep -Evi "please|Wrong!|Try again| I am")
    # Send the PIN to the server and remove the normal "wrong" messages.
    # Save whatever is left in "result".

    if [[ -n "$result" ]]; then
    # If "result" is NOT empty...

        echo "Correct Pin: $char"
        # Show the PIN that worked.

        echo "$result"
        # Show the server's response.

        break
        # Stop trying PINs.

    fi
done
# Finish the loop.


$ chmod +x bandit25.sh
$ bash -n bandit25.sh # test script
$ ./bandit25.sh

