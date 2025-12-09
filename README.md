# Linux BASIC Commands(BANDIT).

A comprehensive guide to Linux commands, SSH, and file operations.

---

## 1. Introduction & Core Concepts

### **Definitions**
*   **SSH (Secure Shell)**: A cryptographic network protocol used for secure remote access to network services over insecure networks. It ensures information remains secret, authentic, and safe.
*   **Unix (1970)**: The "Grandpa" of OS. The blueprint that modern OSs were built on (GNU/Linux, macOS, BSD).
*   **Linux Kernel**: The middle-man between hardware and software.
*   **GNU/Linux**: The combination of GNU (commands, compilers, libraries) and the Linux Kernel, creating OSs like Kali Linux, Debian, and Fedora.
*   **Compiler**: A program that translates high-level language (e.g., C++) into machine code (binary) that the processor can run.

---

## 2. Basic Navigation

### **pwd**
Shows your current working directory.
```bash
pwd
```
*Tip: Useful when you're deep in a filesystem and lost.*

### **ls / ll**
Lists files in a directory.
```bash
ls          # Basic listing
ls -l       # Long listing (permissions, sizes, owners)
ls -la      # Long listing including hidden files
ls -il      # Show inode numbers with list
ll          # Alias for 'ls -l' (common in many shells)
```

### **cd**
Moves between directories.
```bash
cd /path/to/folder
cd ..       # Go up one level
cd ~        # Go to home directory
cd -        # Go to previous directory
```

---

## 3. File Operations

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
cp filename /path/to/dest/
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
*   **7** = `rwx` (Read + Write + Execute)
*   **6** = `rw-` (Read + Write)
*   **5** = `r-x` (Read + Execute)
*   **4** = `r--` (Read only)
*   **0** = `---` (No access)

**Common Permissions:**
```bash
chmod 755 script.sh    # Owner: rwx, Group: r-x, Others: r-x (Standard for scripts)
chmod 644 file.txt     # Owner: rw-, Group: r--, Others: r-- (Standard for files)
chmod 600 key.pem      # Owner: rw-, Group: ---, Others: --- (Private keys/Secrets)
chmod 700 directory/   # Owner: rwx, Group: ---, Others: --- (Private directories)
```

**Symbolic Mode:**
*   `u` = user/owner, `g` = group, `o` = others, `a` = all
*   `+` = add, `-` = remove, `=` = set
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
grep -r "search_term" .     # Recursive search in current dir
grep -i "text" file.txt     # Case-insensitive
grep -n "text" file.txt     # Show line numbers
```

### **find**
Finds files based on properties.
```bash
find / -name README.md 2>/dev/null
find / -type f -size 33c -user bandit -group bandit1 2>/dev/null
```
*   `-type f`: File
*   `-size 33c`: Exactly 33 bytes
*   `2>/dev/null`: Hide error messages

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

### **wc**
Counts lines, words, and characters.
```bash
wc file.txt (everything)
wc -l file.txt      # Count lines
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
# Base64
echo "hello" | base64               # Encode -> aGVsbG8K
echo "aGVsbG8K" | base64 -d         # Decode -> hello

# Hex Tools
xxd file.bin   
xxd -p file.bin # only hex                     # Hex dump
xxd -r -p hex.txt > output.bin      # Reverse plain hex to binary

# Strings
strings binary_file                 # Extract printable strings
```

### **du**
Shows disk usage.
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
tar -cf archive.tar file1 file2     # Create archive
tar -tf archive.tar                 # List contents
tar -xf archive.tar                 # Extract archive
tar -czf archive.tar.gz folder/     # Create Gzip compressed archive
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
bzip2 file.txt          # Compresses to file.txt.bz2
bunzip2 file.txt.bz2    # Extracts to file.txt
```

---

## 7. Network & Remote Access

### **SSH (Secure Shell)**
Connecting to a remote machine.
```bash
ssh user@host
ssh -p 2220 user@localhost  # Connect to specific port
```

### **Key Management**
Generating keys:
```bash
# New Standard (Recommended)
ssh-keygen -t ed25519 -C "email@example.com"

# Old Standard
ssh-keygen -t rsa
```

### **SSH Agent**
Avoid re-typing passphrases.
```bash
eval "$(ssh-agent -s)"      # Start agent
ssh-add ~/.ssh/id_ed25519   # Add key
ssh-add -l                  # List keys
```

### **SCP (Secure Copy)**
Transfer files securely over SSH.
```bash
# Local -> Remote
scp -P 2220 file.txt user@host:~/destination/

# Remote -> Local
scp -P 2220 user@host:~/file.txt ~/local_destination/

# Recursive (Directories)
scp -r -P 2220 user@host:~/dir ~/local_dir/
```

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
1.  Generate key: `ssh-keygen -t ed25519 -C "github" || ssh-keygen -t rsa`
2.  Copy public key: `cat ~/.ssh/id_ed25519.pub`
3.  Add to GitHub Settings -> SSH Keys.
4.  Configure Git:
    ```bash
    git config --global user.name "Your Name"
    git config --global user.email "email@example.com"
    git config --global --list # test config--
    ```
---
### **Configure passphrase**

```bash
$ eval "$(ssh-agent -s)"
$ ssh-add ~/.ssh/id_ed25519 # add private key
$ ssh-add -l # confirm key is loaded
```
---

## 8. Shell Syntax & Scripting

### **Control Operators**
*   `;` (Semicolon): Run commands sequentially.
    ```bash
    touch file.txt ; echo "Done"
    ```
*   `&&` (AND): Run next command ONLY if previous succeeds.
    ```bash
    make && make install
    ```
*   `||` (OR): Run next command ONLY if previous fails.
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

## 9. Miscellaneous

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
- At times we wish to save or share the `STDOUT` stream,  we use the operator `>`

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