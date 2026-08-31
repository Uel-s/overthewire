# Capture the flag (BANDIT).

A comprehensive guide to Linux commands, SSH, and file operations.

---

## 1. Introduction & Core Concepts.

### **Definitions**

- **SSH (Secure Shell)**: A cryptographic network protocol used for secure remote access to network services over insecure networks. It ensures information remains secret, authentic, and safe.
- **Unix (1970)**: The "Grandpa" of OS. The blueprint that modern OSs were built on (GNU/Linux, macOS, BSD).
- **Linux Kernel**: The middle-man between hardware and software.
- **GNU/Linux**: The combination of GNU (commands, compilers, libraries) and the Linux Kernel, creating OSs like Kali Linux, Debian, and Fedora.
- **Compiler**: A program that translates high-level language (e.g., C++) into machine code (binary) that the processor can run.

---

## 2. Basic Navigation.

### **pwd**

Shows your current working directory.

```bash
pwd
```

_Tip: Useful when you're deep in a filesystem and lost._

### **ls / ll**

Lists files in a directory.

```bash
ls          # Basic listing
ls -l       # Long listing (permissions, sizes, owners)
ls -la      # Long listing including hidden files
ls -il      # Show inode numbers with list
ll          # Alias for 'ls -la' (common in many shells)
ll /        # list root dir
```

### **cd**

Moves between directories..

```bash
cd /path/to/folder
cd ..       # Go up one level
cd ~        # Go to home directory
cd -        # Go to previous directory
```

---

## 3. File Operations.

### **touch**

Creates an empty file or updates timestamp.

```bash
touch newfile.txt
```

### **cat**

Reads or concatenates file contents.

```bash
cat file.txt
cat ./-     # Read a file specifically named '-'
```

### **echo**

Prints text or writes to files.

```bash
echo "Hello"                # Print to screen
echo "Hello" > file.txt     # Overwrite file with "Hello"
echo "World" >> file.txt    # Append "World" to file
```

### **cp**

Copies files or directories.

```bash
cp source.txt target.txt
cp -r folder/ backup_folder/    # Recursive copy (for directories)
cp filename /path/to/dest/      # cp pass.md ~/Documents/

```

### **mv**

Moves or renames files.

```bash
mv old.txt new.txt              # Rename
mv file.txt ~/Documents/        # Move
```

### **rm**

Removes files or directories.

```bash
rm file.txt
rm -rf folder/      # Forcefully delete directory and contents recursively
```

> [!WARNING]
> `rm -rf` is permanent and does not forgive errors.

### **purge**

Uninstall app + system configs.

```bash
sudo apt purge app.name
sudo apt autoremove --purge # Clears any left-overs
sudo apt autoclean
which app name # Checks if the file is gone.
```

### **file**

Detects the file type (text, binary, executable, etc.).

```bash
file mystery.bin
```

---

## 4. Permissions & Ownership

### **chmod**

Changes file permissions.

**Numeric Mode:**

- **7** = `rwx` (Read + Write + Execute)
- **6** = `rw-` (Read + Write)
- **5** = `r-x` (Read + Execute)
- **4** = `r--` (Read only)
- **3** = `-wx` (Write + Execute)
- **2** = `-w-` (Write only)
- **1** = `--x` (Execute only)
- **0** = `---` (No access)

**Common Permissions:**

```bash
chmod 755 script.sh    # Owner: rwx, Group: r-x, Others: r-x (Standard for scripts)
chmod 644 file.txt     # Owner: rw-, Group: r--, Others: r-- (Standard for files)
chmod 600 key.pem      # Owner: rw-, Group: ---, Others: --- (Private keys/Secrets)
chmod 700 directory/   # Owner: rwx, Group: ---, Others: --- (Private directories)
```

**Symbolic Mode:**

- `u` = user/owner, `g` = group, `o` = others, `a` = all
- `+` = add, `-` = remove, `=` = set

```bash
chmod u+x script.sh    # Add execute for user
chmod g+w file.txt     # Add write for group
chmod o-r file.txt     # Remove read for others
```

### **chown**

Changes file owner and group.

```bash
chown user:group file.txt
```

---

## 5. Viewing, Searching & Processing

### **grep**

Searches text for patterns.

```bash
grep "password" file.txt
grep -r "search_term" . # Recursive search in current dir(starting from the current directory (.))
grep -r "search_term"  # Recursive search in current dir(starting from the current directory by default)
# Example; mikneat@miknitt:~/overthewire$ grep -r "Password"
#file.txt:# Passwords for Bandit.
#pass.md:# Passwords for Bandit.
grep -i "text" file.txt     # Case-insensitive
grep -n "text" file.txt     # Show line numbers
grep -F "a.b" file.txt      # Points exactly a.b, not “a + any char + b”
grep -E "cat|dog" file.txt  # Allows for interpretation of operators ie. `|`==`OR`
```

`Flags can be combined ie $ grep -i -n "a" text.txt`

### **find**

Finds files based on properties.

```bash
find / -name README.md 2>/dev/null
find / -type f -size 33c -user bandit -group bandit1 2>/dev/null
```

- `-type f`: File
- `-size 33c`: Exactly 33 bytes
- `2>/dev/null`: Hide error messages

### **sort & uniq**

Sorts lines and handles duplicates.

```bash
sort file.txt                   # Sort alphabetically
sort -n numbers.txt             # Sort numerically
sort -r file.txt                # Reverse sort
sort file.txt | uniq            # Remove distinct duplicates
sort file.txt | uniq -c         # Count occurrences
sort file.txt | uniq -u         # Show only unique lines
sort file.txt | uniq -d         # Show only duplicate lines
```

### **wc(word count)**

Counts lines, words, and characters.

```bash
wc file.txt (everything)
wc -l file.txt # Counts lines
wc -c file.txt # counts characters
wc -w file.txt # counts words
```

### **tr**

Translates or deletes characters.

```bash
echo "HELLO" | tr "A-Z" "a-z"       # Uppercase to Lowercase
echo "pass1234" | tr -d "0-9"       # Delete numbers -> "pass"
echo "Hello   World" | tr -s " "    # Squeeze repeated spaces
```

### **Encodings & Hex**

```bash
# Base64 (value from 0 to 63) (A-Z=0-25) (a-z=(26-51) (0-9=52-61) 62=+or- 63=/or_)
echo "hello" | base64               # Encode -> aGVsbG8K
echo "aGVsbG8K" | base64 -d         # Decode -> hello

# Used to view or convert data in hexadecimal (hex) format
xxd  → convert to hexdump
xxd -r → reverse a formatted hexdump back to binary
xxd -p → output plain hex (no formatting)
xxd -r -p → reverse plain hex back to binary     # Reverse plain hex to binary

# Strings
strings binary_file                 # Extract printable strings
```

### **du**

How much space it takes on disk.

```bash
du -h file.txt          # Human-readable size
du -sh *                # Summary of all files in current dir
du -h . | sort -h       # Sort by size
```

---

## 6. Compression & Archives

### **tar**

Tape ARchive - used for combining multiple files.

```bash
tar -cf archive.txt file1.txt file2.txt
tar -cf archive.txt file1 file2     # Creates files within archive.txt
tar -tf archive.txt                 # List contents within archive.txt
tar -xf archive.tar                 # Extract  files from archive.txt
tar -czf archive.tar.gz folder/     # Create Gzip compressed archive -z → compress with gzip -f → specify filename
tar -xzf archive.tar.gz             # Extract Gzip compressed archive
```

### **gzip / gunzip**

Fast compression.

```bash
gzip file.txt           # Compresses to file.txt.gz
gunzip file.txt.gz      # Extracts to file.txt
```

### **bzip2 / bunzip2**

Higher compression ratio, slower speed.

```bash
mv file.txt file.bz2    # change into bz2
bzip2 file.txt          # Compresses to file.txt.bz2
bunzip2 file.txt.bz2    # Extracts to file.txt
```

---

## 6. Network & Remote Access

### **SSH (Secure Shell)**

Connecting to a remote machine.

```bash
ssh user@host
ssh -p 2219 user@localhost  # Connect to specific port
```

### **Key Management**

Generating keys:

```bash
# New Standard (Recommended)
ssh-keygen -t ed25518 -C "email@example.com"

# Old Standard
ssh-keygen -t rsa
```

### **SSH Agent**

Avoid re-typing passphrases.

```bash
eval "$(ssh-agent -s)"      # Start agent
ssh-add ~/.ssh/id_ed25518   # Add key
ssh-add -l                  # List keys
```

## 7. Shell Syntax & Scripting

### **Control Operators**

- `;` (Semicolon): Run commands sequentially.

  ```bash
  touch file.txt ; echo "Done"
  ```

- `&&` (AND): Run next command ONLY if previous succeeds.

  ```bash
  make && make install
  ```

- `||` (OR): Run next command ONLY if previous fails.

  ```bash
  cat missing_file.txt || echo "File not found"
  ```

### **Case Statement Example double-semicolon**

```bash
#!/bin/bash
read -p "Enter a number 1-3: " num
case $num in
    1) echo "One" ;;
    2) echo "Two" ;;
    3) echo "Three" ;;
    *) echo "Invalid" ;;
esac
```

---

## 8. Miscellaneous

### **Manual & Help**

```bash
man grep        # Open manual for grep
grep --help     # Quick help flags
```

### **System Info**

```bash
whoami          # Show current user
history         # Show command history
```

---

### **Piping and Redirection!**

- Every program we run on the command line has 3 data streams connected to it.

```bash
1. STDIN(0) - Standard input (data fed into the program).
2. STDOUT(1) - Standard output (data printed by the program, default to terminal).
3. STDERR(2) - Standard Error (for error messages, also default to the terminal).
```

- **Piping and Redirection** is the means by which we connect these `streams` between programs and files to direct data in interesting and useful ways

---

### **Redirecting to a file**

- At times we wish to save or share the `STDOUT` stream, we use the operator `>`

```bash
1. kay@kay:$ ls

   barry.txt bob example.png firstfile foo1 video.mpeg

2. kay@kay:$ ls > myoutput

3. kay@kay:$ ls
   barry.txt bob example.png firstfile foo1 myoutput video.mpeg

4. kay@kay:$ cat myoutput
   barry.txt
   bob
   example.png
   firstfile
   foo1
   myoutput
   video.mpeg

 5. kay@kay:$
```

### **Saving to an Existing File**

- If the file doesn’t exist, the shell creates it.`>`
  If the file already exists, the shell wipes everything in it before writing new stuff.

```bash
$ cat myoutput

  barry.txt
  bob
  example.png
  firstfile
  foo1
  myoutput
  video.mpeg
$ wc -l barry.txt > myoutput

$ cat myoutput

  7 barry.txt
```

- We can instead get the new data to be appended to the file by using the double greater than operator `>>`.

```bash
$ cat myoutput

  7 barry.txt
$ ls >> myoutput

$ cat myoutput

  barry.txt
  bob
  example.png
  firstfile
  foo1
  myoutput
  video.mpeg
  7 barry.txt
```

### **Redirecting from a File**

- Sometimes you don’t want random extra info (like filenames) in your output.
  Using < `less than` hides the source — it sends “anonymous data.”

```bash
$ wc -l myoutput
  8 myoutput
$ wc -l < myoutput
  7
```

- Combining both to save memory.

```bash
$ wc -l < barry.txt > myoutput
  8
```

### **Redirecting STDERR**

- Streams have int on each; `STDIN 0` , `STDOUT 1`, `STDERR 2`.

- Three things happen when a command is written `STDIN` command received to the program `STDOUT` programs' output ob terminal and `STDERR` error message printed on the cli.

**EXAMPLE**

```bash
ls -l video.mpg blah.foo
```

- video.mpg exists → goes to STDOUT

- blah.foo does NOT exist → error → goes to STDERR.

**Redirect ONLY errors (STDERR → file)**

- To hide the error message `2>`

```bash
$ ls -l file.txt example.txt  myoutput

 cannot access 'example.txt': No such file or directory
 -rw-rw-r-- 1 kay kay 20 Dec 11 15:43 file.txt
```

```bash
$ ls -l file.txt example.txt 2> myoutput
  -rw-rw-r-- 1 kay kay 20 Dec 11 15:43 file.txt
```

- To have both normal output and error message into a single file.

```bash
 $ ls -l file.txt example.txt > myoutput 2>&1
  ls: cannot access 'example.txt': No such file or directory
 -rw-rw-r-- 1 kay kay 20 Dec 11 15:43 file.txt
```

### **Piping**

- Sending data from one program to another the operator `|` is used.
- head is used to start from the front and tail from the back with (-#) the number of file you need.

**EXAMPLE**

```bash
 $ ls > myoutput

  file.txt
  myoutput
  pass.md
  README.md
  script.sh
  vscode.f
```

- Now i want the first 3.

```bash
$ ls | head -3
 file.txt
 myoutput
 pass.md
```

- The last three

```bash
$ ls | tail -3
 README.md
 script.sh
 vscode.f
```

### Redirect and Piping Combination

```bash
$ ls > myoutput
file.txt
myoutput
pass.md
README.md
script.sh
vscode.f
```

- To get only one

```bash
$ ls | head -3 | tail -2 > myoutput
  myoutput
  pass.md

```

## 10. Rotation

- A cipher is an algorithm or method for performing encryption and decryption to secure messages.

### ROT13

- Used to rotate alphabets both Upper and lower at the 13th position(M/m).

_**In-site**_

```py
ABCDEFGHIJKLM NOPQRSTUVWXYZ
NOPQRSTUVWXYZ ABCDEFGHIJKLM

abcdefghijklm nopqrstuvwxyz 
nopqrstuvwxyz abcdefghijklm
```

***Example**_

```py
Hello → Uryyb 
Uryyb → Hello
```

```py
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

### ROT5

- ROT5 is a practice similar to ROT13 that applies to numeric digits (ROT13+ROT5).

_**In-site**_

```py
01234 56789
56789 01234
```

***Example1**_

```py
Hello123
Hello678
```

_**Example2**_

- Find the code which is encoded with  ROT18.

```py
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m' | tr '0-9' '5-90-4'
```

### ROT47

- ASCII maps characters (letters, digits, symbols) to numbers (0–127)
- 👉 ROT47 = shift printable ASCII(usually 94 char) characters by 47 positions.
- It affects letters, numbers, and symbols (not just letters)

_**Example1**_

```py
echo "ROT47 test 123!" | tr '\!-~' 'P-~\!-O'
```

_**Example2**_

```py
Input:  The Quick Brown Fox
Output: %96 "F:4< qC@H? u@I
```

## Hex dump

- A hex dump is just a way to look at raw data (bytes) as hexadecimal numbers so you can see exactly what’s inside a file.

- Computers store everything as bytes (8 bits).

- A hex dump shows each byte like this:

```py
00000000 → memory/file position (offset)

48 65 6c 6c 6f (Hello) -> raw bytes in Hex
```

`Hex = base 16 (0–9, A–F)`

- For spotting hidden formatting issues.

```py
Common hex values:
0a → newline (\n)
09 → tab (\t)
20 → space
00 → null byte (end or padding)
*  → repeated identical lines were skipped to save space
```

## Summary

`Hex dump (xxd {used in ctf}, hexdump {more readable}, od -x {low level lang})`

- Use to see raw bytes

`cat`

- Use to see normal text

`strings`

- Use to extract readable text from binary

_**example**_

```py
echo -e "A\tB\nC" | xxd
#(hex dump)
00000000: 4109 420a 430a                           A.B.C.
```

```py
echo -e "A\tB\nC" | hexdump -C

00000000  41 09 42 0a 43 0a                                 |A.B.C.|
00000006
```

```py
echo  "A\tB\nC" | od -x 

0000000 5c41 4274 6e5c 0a43
0000010
```

```py
echo "00000000: 4109 420a 430a" | xxd -r -p (human readable)
output:A       B
C
```

```py
echo "00000000: 4109 420a 430a" | xxd -p (hexadecimal)
output: 30303030303030303a2034313039203432306120343330610a
```

## 11. SSH/OpenSSH/Keys

- The **private key** is kept on the computer you log in from, while the **public key** is stored on the `~/.ssh/authorized_keys` file on all the computers you want to log in to.

- In remote server ssh checks if `public_key == private_key` then allow for authorization.

### SSH (Secure Shell)

Connecting to a remote machine.

```py
ssh user@host
ssh -p 2220 user@localhost  # Connect to specific port 
```

### Key Management

**Generating keys:**

```py
# New Standard (Recommended)

ssh-keygen -t ed25519 -C "comment"  

# Old Standard

ssh-keygen -t rsa
```

**SSH Agent**
Avoid re-typing passphrases.

`Linux`

```py
eval "$(ssh-agent -s)"      # Start agent
ssh-add ~/.ssh/id_ed25519   # Add private-key
ssh-add -l                  # List keys
```

`Windows`

```py
Get-Service ssh-agent
Set-Service -Name ssh-agent -StartupType Automatic
Start-Service ssh-agent
ssh-add $env:USERPROFILE\.ssh\id_ed25519
ssh-add -l
```

### **SCP (Secure Copy)**

Transfer files securely over SSH.

```bash

# Local → Remote (upload file)
scp -P 2220 local_file.txt username@host:~/remote_path/

# example
scp -P 2220 key.txt bandit13@bandit.labs.overthewire.org:~/

# Remote → Local (download file)

scp -P 2220 username@host:~/remote_file.txt ~/local_path/

# example
scp -P 2220 bandit13@bandit.labs.overthewire.org:~/sshkey.private ~/key

# Recursive copy (directories)

# Local → Remote directory
scp -r -P 2220 my_folder/ username@host:~/remote_folder/

# Remote → Local directory
scp -r -P 2220 username@host:~/remote_folder/ ~/my_folder/

# - -P = SSH port (IMPORTANT: uppercase P)
# - -r = recursive (folders)
# - format is ALWAYS:
#   scp [options] source destination
```

### ⚠️ Key troubleshooting checklist for failure

- Its usually 90% either `Permissions` and `wrong file placement`

**1.Permissions (BIGGEST cause of failure)**

- `If permissions are too open → SSH refuses key login`

- For secure ssh run the following:

```py
chmod 700 ~/.ssh # Only owner can -rwx-
chmod 600 ~/.ssh/authorized_keys # only owner can -rw- key files.
chmod go-w ~/ # Remove write permission (w) from group (g) and others (o) on your home directory (~)
```

**2.SSH config must allow Keys.**

- Run the command below to make sure;
 `PubkeyAuthentication: yes and RSAAuthentication: yes`

```py
sudo cat /etc/ssh/sshd_config
$ sudo service ssh restart # To apply any change/fix
```

**3.Public Key not copied correctly**

- How to copy .pub-key

```py
$ ssh-copy-id user@host # Copies your public key to the remote server for login
   or
$ cat id_rsa.pub >> ~/.ssh/authorized_keys

# To view .pub-key

$ cat ~/.ssh/id_ed22519.pub || $ cat ~/.ssh/authorized_keys

```

**4.Debug connection**

```py
ssh -v user@host
# look for the following;
Offering public key → good
Permission denied → problem
```

**5.SSH agent Issue**

`ERROR`

```py
Agent admitted failure to sign
```

`FIX`

```py
ssh-add
```

**6.Still asking for Password**

- 👉 Likely causes:

- Wrong permissions
- Key not in authorized_keys
- SSH config disabled keys

**7.Encrypted home directory issue**

 `👉 SSH can’t read:`

```py
~/.ssh/authorized_keys
```

`Fix`

- move it to:

```py
/etc/ssh/<username>/authorized_keys

eg:

/etc/ssh/mikneat/authorized_keys
```

```py

`.bashrc` is simply a script that Bash executes when it starts

#################################
# SSH COMMON FLAGS + USE CASES
#################################

# Use specific private key
ssh -i key user@host
# → when key is not default (~/.ssh/id_*)

# Specify port
ssh -p 2220 user@host
# → when server not on port 22 (Bandit uses 2220)

# Verbose (debugging)
ssh -v user@host
ssh -vvv user@host
# → shows why auth fails

# Disable strict host checking (CTF/testing)
ssh -o StrictHostKeyChecking=no user@host
# → avoids "authenticity" prompt

# Use different config file
ssh -F custom_config user@host
# → for custom setups

# Forward local port
ssh -L 8080:localhost:80 user@host
# → access remote service locally

# Run command without shell
ssh user@host "ls -la"
# → execute remote command directly

# Allocate TTY (force interactive shell)
ssh -t user@host
# → needed for some commands (sudo, etc.)

# Quiet mode
ssh -q user@host
# → suppress output

# Background connection
ssh -f user@host
# → run in background (with port forwarding)

# Jump host (proxy)
ssh -J jumpuser@jumphost user@target
# → connect through another server

```

## 12. IP Address and Ports

- Every device on a network has an IP(Internet Protocol ) address (a unique identifier for communication).

- IPv4 addresses are 32-bit, written as four octets (0–255) like 216.27.61.137.(IPv6 exists  
  (128-bit), e.g. 2001:db8::1)

- Your ISP assigns your router a public IP, while your devices usually get private IPs inside
  your network.

- You can connect to servers using either a domain name or an IP address (though many modern  
  servers require the domain).

- A MAC address is the hardware address of a network interface (Wi-Fi card, Ethernet card). ($ ip link)

```bash
Public IP 102.89.10.25 Identifies your network on the Internet
Local (Private) IP 192.168.100.17 Identifies your device inside your local network
MAC Address 34:56:FE:A1:22:9C Identifies device's serial number/ID card
```

### Commands to use

- 1. To check your Local IP/Private IP.

```py
ip a || hostname -I
```

- 1. Public IP

```py
curl ifconfig.me
```

- 1. To check (DNS query) information about a domain name eg IP address.
(DNS=converting names into IP addresses)

```py
$ dig +short google.com # Only IP

$ dig google.com || $ nslookup google.com 

# How does my computer decide where to send network traffic
$ ip route

#  Checking which services or applications are listening for incoming network connections.
$ ss -tuln

```

- A **subnet**, or subnetwork, is a logical subdivision of an IP network. The practice of dividing a network into two or more networks is called subnet

***
`Technologies used to manage addresses in a computer network`
Private IPs (local network):
192.168.x.x, 10.x.x.x, 172.16–31.x.x

Public IP = visible on the internet (given by ISP)

Classless Inter-Domain Routing (CIDR) (/24) = splits network vs host (e.g. 192.168.1.108/24) - prevents waste of IP addresses and help internet routers direct traffic efficiently.

Dynamic IP = Temporary Address assigned automatically and can change over time(smart tv,smartphone).

Dynamic Host Configuration Protocol(DHCP) = The automated service that hand out dynamic ip address.

Static IP = Permanent,manually configured address that never changes. (website,servers)
***

### LocalHost

- localhost = your own machine talking to itself.

- $ curl = a command-line tool to send requests to URLs (servers) and get responses.

```py
$ curl -Iv https://google.com #HTTPS debugging
# Get API data
curl https://api.github.com

# Show headers + debug
curl -v https://example.com

# Download a file
curl -O https://example.com/file.zip

# HTTP REQUESTS
$ curl -X POST https://api.example.com/users \
-H "Content-Type: application/json" \
-d '{"name":"John"}'

$ curl -X PUT https://api.example.com/users/1 \
-d '{"name":"Mike"}'

$ curl -X DELETE https://api.example.com/users/1
```

- `Loopback/localhost` is a built-in networking feature where your computer sends traffic back to itself instead of out to the network.
- `Packets` is data divided into smaller units for transmission and reassembled at the destination

```py
Main loopback addresses:

127.0.0.1 #IPv4
::1       #IPv6
```

- localhost is just a label → loopback is what actually does the work

***
A. Loopback (127.0.0.1)

Use: local testing, dev servers
Safe + isolated

B. Private IP (192.168.x.x)

Use: access from other devices (same WiFi)
Example: phone → your laptop server

C. Public IP / domain

Use: expose to internet
Example: deployed apps
***

- `Name resolution` is how you system turns the name `localhost` to an `IP` which is stored in /etc/hosts

- IP gets you to the server and Port gets you to the exact service

***
Common ports you should memorize

80 → HTTP (web)

443 → HTTPS (secure web)

22 → SSH (remote login)

25 → SMTP(Simple Mail Transfer Protocol) email sending

53 → DNS (domain lookup) UDP&TCP
***

- TCP → reliable, ordered (web, email, SSH)
- UDP → faster, no guarantee (streaming, games)
- LAN → Locally
- WAN → Globally

**Command under IP/Ports**

`1.ssh`

- Used to log into another computer _SAFELY_

```bash
ssh bandit14@bandit.labs.overthewire.org -p 2220
ssh -L 8080:localhost:80 user@server # this is port forwarding allows port 8080 to reach port 80 
```

`2.telnet(Primitive TCP testing)`.

```bash
$ telnet google.com 80

Use-cases:

Check if port is reachable
Manually test plaintext protocols:
SMTP
HTTP
POP3 = Download emails to your device and optionally remove them from server
Redis = Stores data to RAM.

Bad for:

Security (not encrypted).
Modern remote login.
```

`3.nc(netcat)→ The hacker’s screwdriver`

```bash
Use-cases:

Port testing
Debugging services
Ad hoc file transfer
Reverse shells (security testing)
```

```py
Check port:

$ nc -zv google.com 80

Output:

Connection succeeded

Create listener:

$ nc -l 4444

Connect to listener:

$ nc localhost 4444

Now chat between machines.

Send file Remote:

Receiver(listens first):

$ nc -l 4444 > file1.txt

Sender:

$ nc host 4444 < file.txt # nc 192.168.1.20 4444 < file.txt

Send file locally:

Receiver:

$ nc -l 4444 > file1.py

Sender:

$ nc localhost 4444 < file.py



Scan ports:

$ nc -zv 192.168.1.1 20-100

-z  -> scan mode (don’t send data)
-v  -> verbose output
```

`4.openssl s_client→ TLS detective`(low level curl)

- This is a tool used for troubleshooting and testing used to connect to servers over ssl/tls and inspect the secure connection details.

***

1. TLS (Transport Layer Security)~NEW~

Security protocol used in HTTPS.

Encrypts data between browser and server.
telnet
Prevents spying and tampering.

Handles the “secure handshake” before data is exchanged.

In short: `Transport layer Security` = encryption + secure communication layer.

1. Certificate (SSL/TLS Certificate)

Digital identity of a website/server.

Proves the server is who it claims to be.

Contains:

Domain name

Public key
telnet
Expiry date

Issuer (Certificate Authority)

Issued by trusted authorities like:

Let's Encrypt

DigiCert

In short: `Certificate` = website ID card for trust.

1. SNI (Server Name Indication)

Extension of TLS.

Sends the website name before encryption starts.

Needed when many websites share one IP address.

Helps server choose the correct certificate.

In short: `Server Name Indication` = tells server which website you want.

4.SSL (Secure Sockets Layer) is the standard security technology for establishing an encrypted link between a server and a client. It ensures that all data passed between a web server and a browser remains private and secure. ~OLDER~

How they work together

Browser connects to server

Sends SNI (requested domain)

Server responds with correct certificate

TLS handshake starts

Secure encrypted connection begins

One-line memory trick

TLS = secure tunnel

Certificate = identity proof

SNI = chooses the right website

***

```bash
Connect to HTTPS:

$ openssl s_client -connect google.com:443

Shows:

Certificate chain
Cipher suite
TLS version
Verification status

Check specific hostname cert:

$ openssl s_client -connect example.com:443 -servername example.com

(important for SNI)

Extract certificate:

$ openssl s_client -connect example.com:443 </dev/null
```

`5.nmap → Recon scanner(What’s running on this machine/network?)`

***
Use-cases:

Discover devices
Security auditing
Find forgotten services
Identify exposed ports
***

```bash
Basic scan:
1. Shows open ports.

$ nmap 192.168.1.1

2. Service detection:

$ nmap -sV 192.168.1.1

3. OS detection:

$ sudo nmap -O 192.168.1.1

4. Aggressive scan:tell me everything about this host

$ sudo nmap -A 192.168.1.1

5. Scan subnet:

$ nmap 192.168.1.0/24

6. Find live hosts:

$ nmap -sn 192.168.1.0/24

7. $ nmap -p 22 192.168.100.1 # ssh lookup

8. $ sudo nmap -sn 192.168.100.17/24 # show specific devices connected to the network
```

### 1. Certificate inspection

- if curl or your browser complains about an untrusted certificate, use the `showcerts` flag to dump the full chain sent by the server.

```py
openssl s_client -connect example.com:443 -servername example.com -showcerts < /dev/null
```

### 2. Deep Protocol Hex-Dumps (True "Verbose" Debugging)

- If a connection is dropping mid-handshake and you do not know why, you can peek at the raw data packets using -debug or -msg

```py
openssl s_client -connect example.com:443 -servername example.com -msg -debug < /dev/null

```

### 3.Testing for Legacy System Compatibility

- To check whether a machine support you specific tls version and force openssl to drop to older protocol levels.

```py
openssl s_client -connect example.com:443 -servername example.com -tls1_2 < /dev/null #1.2 only.
openssl s_client -connect example.com:443 -servername example.com -tls1_3 < /dev/null #1.3 only.

```

### 4. Testing a specific Cipher Suite.(specific/weak cipher)

```py
# Test a TLS 1.2 cipher
openssl s_client -connect example.com:443 -servername example.com -cipher ECDHE-RSA-AES128-GCM-SHA256 < /dev/null

# Test a TLS 1.3 cipher
openssl s_client -connect example.com:443 -servername example.com -ciphersuites TLS_AES_256_GCM_SHA384 < /dev/null

```

### 5. Troubleshooting mTLS (Mutual TLS / Client Certificates)

- When a server demands a client certificate to let you in, debugging it can be tricky. Pass your local client certificate and key to test the handshake:

```py
openssl s_client -connect example.com:443 -servername example.com -cert client.crt -key client.key -CAfile rootCA.crt
```

### 6.Testing Non-Web Services (STARTTLS)

```py
# Test a Mail Server (SMTP)
openssl s_client -connect ://example.com -starttls smtp

# Test a Database (MySQL)
openssl s_client -connect ://example.com -starttls mysql
```

## 13. Network troubleshooting

`1.ncat(Netcat)`.

- A simpler (`nc`) network client/server tool.

 Use Cases.

- Test if a port is open.
- Create a quick TCP server.
- Send raw data to a service.
- Debug network connectivity.
`for commands same as nc`

`2.socat (Source ↔ Destination) .`

- A much powerful version of netcat.

Use Case:

- Forwarding ports.
- Bridge Protocols.
- Create encrypted tunnels.
- Connect files, sockets, serial ports, TCP & UDP

```py
#port forwarding 8080 -> 80
$ socat TCP-LISTEN:8080,fork TCP:example.com:
$ curl -vk https://localhost:8080 

# local Chat.

## Machine A (listener).
$ socat TCP-LISTEN:4444,fork STDOUT 

## Machine B (client).
$ socat STDIN TCP:localhost:4444

# Same Network Chat.

## Machine A.
$ socat TCP-LISTEN:4444,reuseaddr STDIO

## Machine B.

$ socat STDIO TCP:192.168.1.10:4444

# Remote Chat.

$ socat TCP-LISTEN:4444,reuseaddr STDIO

### Client 

$ socat STDIO TCP:<Public_IP>:4444 #Pub.IP192.123.123.1

# Requirements.
On the server side ONLY :

Determine the machine's local IP:

hostname -I

Allow the port through the firewall:

sudo ufw allow 4444/tcp

Start the listener:

socat TCP-LISTEN:4444,reuseaddr STDIO

## TLS Client.(This performs a TLS handshake.)
$ socat - OPENSSL:google.com:443
GET / HTTP/1.1
Host: google.com

## TLS Server.
$ openssl req -x509 -newkey rsa:2048 \
 -keyout key.pem \
 -out cert.pem \
 -nodes

 $ socat OPENSSL-LISTEN:4444,cert=cert.pem,key=key.pem,fork STOUT #Start TLS Server.
 $ socat STDIN OPENSSL:localhost:4444,verify=0 # Connect 

 ## File Transfer.

 ### Receiver.

 $ socat TCP-LISTEN:4444,fork FILE:received.txt,create

 ### Sender

 $ socat FILE:file.txt TCP:localhost:4444 

# A `Unix domain socket` is a secure data communication endpoint that allows two different applications running on the same physical computer to exchange data.

### Connect to a UNIX Socket server .

$ socat UNIX-LISTEN:/tmp/chat.sock,fork STDOUT

### Connect 

$ socat STDIN UNIX-CONNECT:/tmp/chat.sock

### Connect to an Existing UNIX Socket.

$ socat - UNIX-CONNECT:/tmp/chat.sock

```

`3. netstat(Network Statistics)`

- a command-line tool used to display active network connections (both incoming and outgoing),  routing tables, and interface statistics.

```py

# show listening ports:

$ netstat -tulnp

```

```py

# Show routing table

$ netstat -rn

```

```py
# Continuos mode to watch live connections.

$ netstat -c 

```

```py

# This flag includes all established outbound web-browsing connections too not just listening.

$ netstat -a

```

```py

#  Interface Statistics. Shows a quick health breakdown of packets sent, received, or dropped on your Wi-Fi card

$ netstat -i

```

```py

# Protocol Summary.

netstat -s

```

`4.ss (Socket Statistics).`

- Used to display detailed information about `network sockets`.

```py
# Listening ports and processes

$ ss -tunlp

```

```py

```py
# Establish connection.

$ ss -tan

```

```py

# shows only connections that are actively transmitting data right now.

$ ss -t state established #(or just -t) (or -tp to see specific server)

```

- A `socket` is an internal software endpoint that allows two different programs (either on the same computer or across the internet) to talk to each other.

### Network troubleshooting summary

```bash
| Tool       | Main Purpose                                |
| ---------- | ------------------------------------------- |
| ss         | See network connections and listening ports |
| netstat    | Older version of `ss`                       |
| nmap       | Discover and scan hosts/services            |
| nc(netcat) | Create simple TCP/UDP connections           |
| ncat       | Enhanced netcat with extra features         |
| socat      | Connect almost anything to almost anything  |

`nmap` explores remote systems over the network, while `ss` investigates your own local machine

```

```
tunlp
-t -> show tcp port.
-u -> show udp port.
-n -> show numerical addresses (192.168.0.1:80).
-l -> show only listening port.
-p -> show the PID(process ID) and program name using port.
```

```bash
Quick Memory Trick
Command What it does
s_client Connect to TLS server
x509 Read/manage certificates
req Create/read CSRs(Certificate Signing Requests)
genpkey Generate private keys
verify Validate certificates

Flow: genpkey → req → x509 → verify → s_client

Typical Workflow
Step 1: Generate Private Key
openssl genpkey -algorithm RSA -out private.key

Step 2: Create CSR
openssl req -new -key private.key -out request.csr 

#Create
openssl req \
-x509 \
-new \
-key private.key \
-out cert.pem \
-days 365


Step 3: Obtain Certificate

CA signs your CSR and returns cert.pem.

Step 4: Inspect Certificate
openssl x509 -in cert.pem -text -noout 


Step 5: Verify Certificate
openssl verify -CAfile ca.pem cert.pem

Step 6: Test TLS Server
openssl s_client -connect example.com:443
```

## PORT SCAN

- Is like walking down a hallway in a building and knocking on every door to see which ones are unlocked and who answers but now for ports.

- `PortSweep` - is to scan multiple hosts for a specific listening port.

### TCP/IP Basics — Key Points

- TCP/IP is the protocol suite that powers the Internet.
- Network services are identified by:
  1. Host (IP) address
  2. Port number
- There are 65,535 usable ports (1–65,535). Port 0 is not usable.
- Most services use one or a small range of ports.
- Some port scanners only check common or high-risk ports.

### Port Scan Results

- Open – A service is listening and accepts connections.
- Closed – No service is listening; connections are rejected.
- Filtered – No response, usually due to a firewall or packet filtering.

### Security Implications

- Open ports can expose:

1. Vulnerabilities in the service/application listening on the port.
2. Vulnerabilities in the operating system itself.

- Filtered ports generally present less risk because they are inaccessible from the scanner's perspective.

### diff(difference)

`diff` - command used to compare two files line by line.

```py
# Flags

$ diff -u old.txt new.txt  # show what left(-) in the old file and whats new in the new file(+). (space) file is unchanged.

$ diff -y file1.txt file2.txt  # side by side comparision.

$ diff -i file.text file2.txt # ignore case and reports no difference if file has mixed upper and lower case but same data. 

$ diff -q file.text file2.txt # Only report whether files differ

$ diff -r dir1 dir2 # compares directories .

$ diff --color=auto # show the different colors on the diffrent dat in files.

$ diff -rN dir1 dir2 # Treat missing files as empty

$ diff -b file1.txt file2.txt # Ignore changes in amount of whitespace

$ diff -B file1.txt file2.txt # Ignore blank lines

$ diff -w file1.txt file2.txt # ignore whitespace

```

## Set User Identity (setuid) and Set Group Identity(Setgid)

- SetUID – Allows a user to run a program with the file owner's permissions.
- SetGID – Allows a user to run a program with the file group's permissions.
- Used to perform specific privileged tasks (e.g., changing passwords) without giving users     full root access.

### How to tell a SETUID/GID file

```py
s replaces the owner's x → SetUID enabled.
-rwsr-xr-x

s replaces the group's x → SetGID enabled.
-rwxr-sr-x

t adds permission to create file in the dir

drwxrwxrwt

```

### To find SETUID and SETGID Programs

```py
$ ll

$ find / -perm  -4000 2>/dev/null # SETUID

$ find / -perm  -2000 2>/dev/null # SETGID

find / -perm -1000 2>dev/null # sticky bit # used mainly on dir (Users can only delete or rename files that they own, even if everyone has write permission to the directory.)

```

### Set the SetUID/SetGID to files

```py

chmod u+s filename or chmod 4755 # GETUID (u-s) #reverse

chmod g+s filename or chmod 2755 # GETGID. (g-s) # reverse

chmod ug+s filename or chmod 6755  # both GETUID/GID

chmod +t directory or chmod 1755  # set sticky bit. (Without the Sticky Bit, one user could delete another user's files.)

```

### Test sticky bit

```py
$ ls -ld /tmp

out: drwxrwxrwt
```

`SetUID/SetGID are generally ignored on shell scripts (Bash, Python, Perl, etc.) for security reasons.`

## Managing Programs in GNU/LINUX

`1. Bash` -The shell(Command Interprate).
`2. Job control` - Manage processes(pause,resume,move) started from the current shell.
`3. Screen` - Keeps terminal session running after you disconnet from SSH or terminal.
`4. tmux` - Modern terminal multiplexer with panes and windows.

### BASH

- The normal commands:

```bash
ll
pwd
name=Meaknit;echo $name
```

### Job Control

- Common commands:

```bash
$ sleep 100 # Running process.

Press Ctrl + z #  Stops the process.

# The process isn't killed its just `Suspended`
```

```bash

# Show background/suspended Process.

$ jobs # [1]+  Stopped   sleep 100

```

```bash
# Continues a suspended job in the background

$ bg

# [1]+ sleep 100 &
```

```bash
# Brings a background job back to the foreground.

$ fg

# Sleep 100 
# Now the shell waits for it again.

```

```bash
# Start a program directly in the background use `&`.

$ sleep 100 &

output: [1] 23456

# [1] = Job number.
# 23456 = Process ID.

```

```bash
# Stop a running process.

$ sleep 100

press Ctrl + c

# The process exists Immediatly.
```

```bash
# Ends a process

$ kill 23456 # process ID.
or
$ kill %1 # job number.

$ fg %2 # After killing kill %1 continue with [2] don't jump to current process [3]
$ bg %2 # Same as for fg

```

#### Summary

```py
[1]+ Stopped sleep 1000    # + → Current job (the default job used by commands like fg and bg)
[2]- Running sleep 2000 &  # - → Previous job (the one that becomes current if the + job ends)
[3] Running sleep 3000 &   # No symbol → Other jobs

| State                 | `jobs` output                         |
| --------------------- | ------------------------------------- |
| Running in foreground | Doesn't appear in `jobs` while active |
| Stopped (`Ctrl+Z`)    | No `&`                                |
| Running in background | Has `&`                               |
# The & means "run this command in the background"
```

### Screen

- Is a tool that allows programs to continue running even when you disconnect from SSH or terminate the  terminal.

## Example

```py
screen # To activate tool.

python app.py # run a script/program.

ctrl + a + d # detach without stopping.

screen -ls # Show sessions.

screen -r # Reconnect.
```

#### Common screen commands

```bash
screen                           # Create session
screen -ls                       # List sessions
screen -r                        # Reattach
screen -S sessionName           #  Name a session
screen -r sessionName           #  switch between specific running processes.
screen -d sessionName           #  Detach the sessionName session remotely
screen -d -r sessionName        # Force-detach and reattach to sessionName 
screen -X -S sessionName quit   # End a named session
```

### tmux

- Terminal Multiplayer is a more modern and feature-rich alternative to `screen.`

- Added advantage to `tmux` is splitting the terminal.

```bash
CTRL+B %  # vertical split
CTRL+B "  # Horizontal split
```

### Common tmux commands

```bash
tmux # Start. 

CTRL+B D  # Detach.

tmux ls # list previous sessions.

tmux attach  # Reconnect.

tmux new -s sessionName  # Create a new sesion.

tmux kill-session -t sessionName # Kill a session
```

## cron, crontab crontab file

### 1. cron

- This is background service that constantly checks whether it's time to run a scheduled `jobs`.

```bash
# Think of it as an alarm clock.

09:59
cron: Not yet...

10:00
cron: Time to run the backup script!

10:01
cron: Waiting for the next scheduled task...
```

- `cron` runs in the background you don't get to interact with it.

### crontab

- crontab is command-line tool used to create, edit, list or remove scheduled jobs.

```bash
crontab -e # create/edit your cron jobs.

crontab -l # List your cron jobs.

crontab -r # Remove your cron jobs.
```

### Examples

```bash

crontab -e # Choose nano

28 19 * * * DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus notify-send "Break Time" "Take a break!" # save and you will receive a notification.
```

```bash

$ crontab -e

48 19 * * * echo "This is a test" > /home/mikneat/Documents/Securty/overthewire/test.txt
# at exactly 1948 hrs 
# * → Every day of the month
# * → Every month
# * → Every day of the week
```

```bash
$ mkdir crontest

$ nano file.sh 

# add script 
#!/bin/bash

LOGFILE="/home/mikneat/cron/update.log"

echo "========== $(date) ==========" >> "$LOGFILE"

apt update >> "$LOGFILE" 2>&1
apt upgrade -y >> "$LOGFILE" 2>&1
apt autoremove -y >> "$LOGFILE" 2>&1
apt autoclean -y >> "$LOGFILE" 2>&1

echo "Update complete." >> "$LOGFILE"
echo "" >> "$LOGFILE"

$ chmod +x file.sh

$ sudo crontab -e # bypass password

# under nano add.

00 9 * * * /home/mikneat/crontest/file.sh # 00 9 * * 0  (0-7) day of the week 0 == Sunday

# add save

$ systemctl status cron # check if active

$ cat ~/updates/update.log # inspect updates
```

### Simple Example

```bash

$ mkdir cronexample

$ touch cron.sh

# add script.
#!/bin/bash

echo "===========" >> home/mikneat/cronexample/log.txt
date >> home/mikneat/cronexample/log.txt
pwd >> home/mikneat/cronexample/log.txt
ls >> home/mikneat/cronexample/log.txt
echo "" >> home/mikneat/cronexample/log.txt

$ chmod +x cron.sh

$ crontab -e

# Add the command

00 9 * * * /home/mikneat/cronexample/cron.sh

$ cat log.txt # Check if it passed.
```

## Crontab File

-It is simply a text file containing cron jobs

```bash
# Daily backup
0 2 * * * /home/mikneat/scripts/backup.sh

# Weekly update
0 3 * * 0 /home/mikneat/updates/update.sh

# Every 10 minutes
*/10 * * * * echo "Running..."
```

### Creating personal crontab file

```bash
 nano mycron

 crontab mycron
 ```

 ```bash
man 1 crontab # This is the one you'll use regularly (crontab -e, -l, -r).
man 5 crontab # When you need to look up syntax, special strings, environment variables, or advanced features.
man 8 crontab # When administering the cron service, troubleshooting why jobs aren't running, or learning how the daemon works.
```

`/usr/bin`- is a directory that stores executable programs

# Quick Summary

| Directory | Purpose |
| ----------- | --------- |
| `/` | Root of the filesystem |
| `/home` | User home directories |
| `/bin` | Essential commands available to user |
| `/sbin` | System administration commands |
| `/usr` | used to store user-related programs and data, including executable files, libraries, and documentation. |
| `/tmp` | Temporary files |
| `/etc` | Stores Configuration files and installed applications |
| `/boot` | Boot files and is responsible for  |
| `/dev` | Converts hardware and Virtual devices into files where programs and users can interect with them. |
| `/lib` | Contains shared libraries(reuseble programs) that programs need to run. |
| `/media`  → usually where USB/external drives are mounted |
| `/mnt`    → usually where you manually mount something temporarily |
| `/opt` | Optional software installed from 3rd party sources |
| `/proc` | Process and kernel information |
| `/root` | Root user's home |
| `/run` | What process,services,sockets are runnuing right now |
| `/srv` | Files that a server is sharing/providing to others. |
| `/sys` | Hardware and kernel information |
| `/var` | Files that change while Linux is running. |

```

### Core Usage and Flags

```bash
$ shopt :Lists all available shell options and shows if they are on or off.
$ shopt -s [name]: Turns on (sets) a specific shell option.
$ shopt -u [name]: Turns off (unsets) a specific shell option.
$ shopt [name]: Checks the current status of a single option.
```

### Common Options

```bash
shopt -s nullglob 
# Makes wildcards (*, ?, []) expand to nothing(empty output)if they don't match any files, instead of remaining as literal text.
```

## more,vi,id.

```bash
more → READ
vi   → EDIT
id   → IDENTIFY
```

### more.

- Used to read file page by page

```bash
more filename # Will show some data in the file but in % ie 2%, press up-down arrow to increase %.
```~

```bash
Space       → next page
Enter       → next line
q           → quit
/word       → search for "word"
```
```bash
more -d file.txt # Shows helpful instructions when you reach the end


more -c file.txt  # Redraws the screen instead of scrolling normally.
```

### vi 

- Used to open and edit a file

```bash
i    → enter insert mode
x    → delete a character
dd   → delete a line
yy   → copy a line
p    → paste
```

```bash
vi file       → open file
i             → start typing
Esc           → stop typing
:w            → save
:q            → quit
:wq           → save + quit
:q!           → quit without saving
```

### id.

- Find out who you are

```bash
uid
$ id -u

Shows your User ID.

Example:

1000
gid
$ id -g

Shows your primary Group ID.

Username
$ id -un

Shows your username:

mikneat

$ id -gn # Shows your primary group name only.
mikneat

$ id -Gn
mikneat adm cdrom sudo dip plugdev users lpadmin lxd. # Shows the groups you belong to.


```

## The most important Git concepts to learn.

```bash
# ============================================================
# BASIC
# ============================================================

git init                         # Create a new Git repository
git clone <URL>                  # Clone/download a remote repository
git status                       # Show current state of working tree
git help <command>               # Show help for a Git command


# ============================================================
# STAGING & COMMITS
# ============================================================

git add filename                 # Stage a specific file
git add .                        # Stage all changes in current directory
git restore filename              # Discard unstaged changes to a file
git restore --staged filename     # Unstage a file (keep its changes)

git commit -m "message"          # Create a commit from staged changes
git commit --amend               # Modify the latest commit
git commit --amend --no-edit     # Modify latest commit without changing its message

# 1. Change the commit message
git commit --amend -m "Better message"

# 2. Add/change files in the latest commit
git add file.txt
git commit --amend


# ============================================================
# VIEWING CHANGES & HISTORY
# ============================================================

git diff                          # Show unstaged changes
git diff --staged                 # Show staged changes
git log                           # Show detailed commit history
git log --oneline                 # Show compact commit history
git log --oneline --graph --all   # Show compact visual history of all branches
git show <commit> #eg a83f91c     # Show details of a specific commit
git blame filename                 # Show who last changed each line


# ============================================================
# BRANCHES
# ============================================================

git branch                       # List local branches
git branch <name>                # Create a new branch
git switch <name>                # Switch to an existing branch
git switch -c <name>             # Create AND switch to a new branch

# Older Git syntax:
git checkout <name>              # Older way to switch branches

git branch -d <name>             # Delete a branch if it has been merged
git branch -D <name>             # Force-delete a branch


# ============================================================
# MERGING
# ============================================================

git merge <branch name>               # Merge another branch into current branch
git merge --abort                # Cancel an in-progress merge/conflict


# ============================================================
# REMOTES
# ============================================================

git remote -v                    # Show remote repository URLs
git remote                       # Show remote names

git remote add origin <URL>      # Add a remote named "origin"
git remote remove origin         # Remove the "origin" remote
git remote rename origin <name>  # Rename a remote

git fetch                        # Download remote changes WITHOUT modifying your branch
git fetch --all                  # Fetch from all configured remotes

git pull                         # Fetch + integrate remote changes
git pull --rebase                # Update my feature from remote feature.  #Rebase keeps your commit  history linear and clean eg A-B-C-D-E.

# ============================================================
# 1. Start on main and make sure it's up to date
# ============================================================

git switch main
git pull


# ============================================================
# 2. Create your feature branch
# ============================================================

git switch -c feature


# ============================================================
# 3. Make your changes.
# ============================================================

# edit your files...

git status
git add .
git commit -m "Add feature"


# ============================================================
# 4. Push feature to GitHub
# ============================================================

git push -u origin feature


# ============================================================
# 5. Someone may have updated main while you were working
#    Update your feature branch with the latest main
# ============================================================

git switch feature

git fetch origin
git rebase origin/main

# If there are conflicts:
#   1. Fix the conflicted files
#   2. git add <file>
#   3. git rebase --continue
#
# To cancel the rebase:
#   git rebase --abort


# ============================================================
# 6. Because rebase changed your feature commits,
#    update the remote feature branch
# ============================================================

git push --force-with-lease


# ============================================================
# 7. Feature is ready → go to main.
# ============================================================

git switch main
git pull


# ============================================================
# 8. Merge your feature into main
# ============================================================

git merge feature

# ============================================================
# MERGE FEATURE INTO MAIN — FAST-FORWARD ONLY
# ============================================================

git switch main
# Switch to the main branch.
# You MUST be on main because you want feature → main.


git pull --rebase
# Update local main from origin/main.
# --rebase avoids creating an unnecessary merge commit
# if your local main and origin/main have diverged.


git merge --ff-only feature
# Merge feature into main ONLY if Git can do a fast-forward if not stop.
#
# "Fast-forward" means main has no unique commits of its own.
#
# Before:
#
# main:     A---B
#                \
# feature:       C---D
#
# After:
#
# main:     A---B---C---D
#                     ↑
#                  feature
#
# No merge commit is created.
#
# If a fast-forward is NOT possible, Git stops and does NOT
# automatically create a merge commit.


git push
# Push the updated main branch to GitHub.
```

### Remote repositories

```bash
git remote -v
git fetch         # download remote history without changing your current branch or files
git pull          # fetch + integrate the changes.
git push          # send your commits to remote.
```

### Undo / rollback — VERY important

```bash
git commit --amend          # Modify the latest commit.

git reset --soft HEAD~1           # Undo latest commit; keep changes STAGED

git reset --mixed HEAD~1          # Undo latest commit; keep changes but UNSTAGE them
# --mixed is the default reset mode

git reset --hard HEAD~1           # Undo latest commit AND discard changes
# ⚠️ Dangerous: can permanently discard work

git revert <commit> #eg a83f91c               # Create a NEW commit that reverses an old commit

git reflog                        # Show where HEAD/branches have previously pointed
# Extremely useful for recovering from accidental resets/rebases


# ============================================================
# RESET — UNDERSTAND THE THREE MODES
# ============================================================

git reset --soft <commit> #eg a83f91c         # Move HEAD; keep changes staged
git reset --mixed <commit> #eg a83f91c        # Move HEAD; keep changes unstaged
git reset --hard <commit> #eg a83f91c         # Move HEAD; discard changes


# ============================================================
# TAGS
# ============================================================

git tag                           # List tags
git tag v1.0                      # Create a tag
git tag -a v1.0 -m "Release 1.0"  # Create an annotated tag
git push origin v1.0              # Push a tag to remote
git push origin --tags            # Push all tags


# ============================================================
# USEFUL SEARCH / INSPECTION
# ============================================================

git grep "text"                  # Search tracked files for text
git status -sb                   # Short/compact status
git log --oneline -5             # Show last 5 commits
git diff HEAD                    # Show all changes since last commit
git diff <commit1> <commit2>     # Compare two commits


# ============================================================
# CLEANUP
# ============================================================

git clean -n                     # Preview untracked files that would be deleted
git clean -f                     # Delete untracked files
git clean -fd                    # Delete untracked files AND directories
# ⚠️ Dangerous: deleted files aren't moved to Trash


# ============================================================
# CONFIGURATION
# ============================================================

git config --list                # Show Git configuration
git config user.name "Name"      # Set your Git username
git config user.email "email"    # Set your Git email

git config --global user.name "Name"
# Set username globally for all repositories

git config --global user.email "email"
# Set email globally for all repositories
```
