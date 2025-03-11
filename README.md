<div align="center">
<pre>
 _______  _______  _______  __   __  _______ 
|       ||       ||       ||  | |  ||       |
|    ___||   _   ||       ||  | |  ||  _____|
|   |___ |  | |  ||       ||  |_|  || |_____ 
|    ___||  |_|  ||      _||       ||_____  |
|   |    |       ||     |_ |       | _____| |
|___|    |_______||_______||_______||_______|
---------------------------------------------
block distracting websites with ease
available on Linux
</pre>
</div>

focus is a tool that allows you to block specified websites by modifying your `hosts` file. 

This can be easily toggled, though the extra step may just be enough to keep you on task!

## Installation

Run the `install.sh` script as sudo to install focus.

```
sudo ./install.sh
```

After running the installation script, use `focus` to generate a generic hosts.blocked file.

This can be skipped by creating one manually at: `/etc/hosts.blocked`.

Edit `hosts.blocked` to add websites you'd like to temporarily block. 

## Usage
To view command line usage

```
focus
```
Toggle focus with `on` and `off`.

`off` simply reverts to your original `hosts` file.

```
focus on
```

(or)

```
focus off
```

### Sample hosts.blocked file

```
# Static table lookup for hostnames.
# See hosts(5) for details.
127.0.0.1 localhost
127.0.1.1 hostname

# focus
# To block a website, add a line with: 0.0.0.0 website.com or uncomment one of the examples.
0.0.0.0 facebook.com
0.0.0.0 twitter.com
# 0.0.0.0 youtube.com
0.0.0.0 reddit.com
# 0.0.0.0 instagram.com

```
