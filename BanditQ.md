11. - Q. The password for the next level is stored in the file data.txt, where all lowercase (a-z) and uppercase (A-Z) letters have been rotated by 13 positions

```py
$ cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

12. - Q. The password for the next level is stored in the file data.txt, which is a hexdump of a file that has been repeatedly compressed. For this level it may be useful to create a directory under /tmp in which you can work. Use mkdir with a hard to guess directory name. Or better, use the command “mktemp -d”. Then copy the datafile using cp, and rename it using mv (read the manpages!)

***steps***

```py
# 1. Create workspace
tmpdir=$(mktemp -d)
cd $tmpdir

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

$ chmod 600 ~/bandit13 # to give permission to cp.

$ ssh -i bandit13 bandit14@bandit.labs.overthewire.org -p 2220 # cp into bandit14 ./ssh

```
