# Linux Command Mastery — README

A clean, practical cheat-sheet of everything learned so far in this journey. Simple explanations, real use-cases, and zero fluff.

---

## 1. **Basic Navigation Commands**

### **pwd**

Shows your current working directory.

```
pwd
```

Useful when you're deep in a filesystem and lost like a character in a bad horror movie.

### **ls / ll**

Lists files in a directory.

```
ls      # basic listing
ll      # long listing (ls -l) with permissions, sizes, owners
```

### **cd**

Moves between directories.

```
cd /path/to/folder
cd ..   # go up one level
```

---

## 2. **File Operations**

### **cat**

Reads the contents of a file.

```
cat file.txt
```

### **touch**

Creates an empty file.

```
touch newfile.txt
```

### **echo**

Prints text or writes text into files.

```
echo "Hello" > file.txt
```

### **mv**

Moves or renames files.

```
mv old.txt new.txt
mv file.txt /another/path/
```

### **cp**

Copies files.

```
cp source.txt target.txt
cp -r folder/ backup_folder/
```

### **rm / rm -rf**

Removes files.

```
rm file.txt
rm -rf folder/   # delete folder and contents recursively
```

**Warning:** rm -rf does not forgive.

---

## 3. **Viewing & Searching**

### **grep**

Searches text for patterns.

```
grep "password" file.txt
```

Useful flags:

* `-r` → recursive inside folders
* `-i` → case-insensitive
* `-n` → show line numbers

### **find**

Finds files based on name, type, size, etc.

```
find / -name secret.txt
```

### **file**

Detects a file's real type.

```
file mystery.bin
```

Great for CTFs, TryHackMe, and when Linux trolls you with weird extensions.

### **du**

Shows disk usage.

```
du -h folder/
```

`-h` → human-readable (MB/GB instead of raw bytes)

---

## 4. **Editors**

### **nano**

Simple terminal editor.

```
nano file.txt
```

### **pico**

Older version of nano. Works the same.

---

## 5. **SSH & Remote Operations**

### **ssh**

Connects to a remote server.

```
ssh user@host
```

### **scp**

Copies files between machines.

```
scp file.txt user@host:/path/
```

The remote version of `cp`.

---

## 6. **Permissions**

### **chmod**

Changes permissions.

```
chmod 755 script.sh
chmod +x script.sh
```

### **chown** *(not previously mentioned but important)*

Changes file owner.

```
chown user:user file.txt
```

---

## 7. **Manual Pages**

### **man**

Reads help documentation.

```
man grep
```

Your built-in Linux textbook.

---

## 8. **Compression & Extraction**

### **tar**

Archives files.

```
tar -cvf archive.tar folder/
tar -xvf archive.tar
```

### **gzip / gunzip**

Compress or decompress single files.

```
gzip file.txt
gunzip file.txt.gz
```

### **bzip2 / bunzip2**

Like gzip but slower and more compressed.

```
bzip2 file.txt
bunzip2 file.txt.bz2
```

---

## 9. **Hex Tools**

### **xxd**

Turns binary → hex or hex → binary.

```
xxd demo.bin            # show hex
xxd -p demo.bin         # plain hexdump
xxd -r -p demo.hex > out.bin   # reverse plain hex back
```

`-p` outputs plain hex without ASCII formatting.

---

## 10. **Text & Line Tools**

### **sort**

Sorts lines.

```
sort file.txt
```

### **uniq**

Removes duplicates in sorted input.

```
uniq file.txt
uniq -c file.txt   # count occurrences
```

### **wc** *(added because you used it earlier)*

Counts lines, words, characters.

```
wc -l file.txt
```

---

## 11. **Shell Syntax**

### **; (semicolon)**

Runs commands sequentially, even if the first fails.

```
cmd1 ; cmd2
```

### **&& (and)**

Runs the next command only if the first succeeds.

```
cmd1 && cmd2
```

### **|| (or)**

Runs the next command if the first fails.

```
cmd1 || cmd2
```

---

## 12. **Misc Tools**

### **whoami**

Shows your current user.

### **hostname**

Shows the machine name.

### **history**

Shows previously used commands.

### **clear**

Wipes your terminal screen.

---

## 13. **Network Basics**

(You used some earlier in SSH lessons, so adding them.)

### **ping**

Tests if a host is reachable.

### **ifconfig / ip addr**

Shows network interfaces.

### **netcat (nc)** *(Encountered in Bandit levels)*

Sends/receives data over network.

```
nc host port
```

---

## 14. **TryHackMe / Bandit Essentials**

### Identify file types

```
file filename
```

### Decode hex → binary

```
xxd -r -p hex.txt > out.bin
```

### Searching for passwords

```
grep -r "pattern" .
```

### Extracting weird archives

```
tar, gzip, bzip2, file, xxd
```


