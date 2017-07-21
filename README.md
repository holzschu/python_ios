# Python for iOS -- with partial fork() and exec() ability

This project is a patch of Python-2.7.13, designed to make it compile on iOS. Python becomes a framework, and your programs can call python_main(argc, argv) to execute python scripts. 

This was designed to be used in conjunction with [Blinkshell](https://github.com/holzschu/blink), but it can be used independently. 

# Compilation:

- type 'getPackages.sh'

This will download the Python-2.7.13 source code, and patch it. It will also download libffi-3.2.1, and patch it. 

After patching, you have two Xcode projects: 
- Python-2.7.13/Python_ios/Python_ios.xcodeproj
- libffi-3.2.1/libffi.xcodeproj

and you have to compile both. Python uses libffi as a framework; it also uses several include files and frameworks from [Blinkshell](https://github.com/holzschu/blink), so you will have to either download it or comment out the relevant lines (corresponding to libssh, libssl...)

In a full installation, Python needs the following frameworks from [Blinkshell](https://github.com/holzschu/blink):
- file_cmds_ios.framework
- libarchive_ios.framework
- libssh2.framework
- openssl.framework
- shell_cmds_ios.framework
- text_cmds_ios.framework

You can remove any of them, if you comment out the relevant lines in systemFunctions.h and posixmodule.c (for ssh).

# Installation (on your device)

Once you have compiled the Python framework, you can link it with your favorite app (I used [Blinkshell](https://github.com/holzschu/blink), but it's up to you). 

You will need to transfer the Python scripts to your device:
- tar -cvfz pythonScripts.tar.gz Lib/
- transfer the pythonScripts.tar.gz on the device, for example using iTunes
- on the iOS device: tar -xvfz pythonScripts.tar.gz 
- mv Lib ../Library/lib/python2.7

Also transfer the scripts: 
- tar -cvfz binaries.tar.gz Tools/scripts/
- transfer the binaries.tar.gz on your device, for example using iTunes
- on the iOS device: tar -xvfz binaries.tar.gz 
- mv Tools/scripts/ ../Library/bin/

Then, install a few useful modules: 
- python -m ensurepip
- pip install urllib3

(Other pip calls are up to you). 

Inside Python, you can call the shell commands defined by the frameworks: ls, cat, curl, sftp, grep... 

In the shell, you can use all Python scripts: pydoc, which.py, diff.py... 

# Mercurial

To install mercurial:
- download the source: curl https://www.mercurial-scm.org/release/mercurial-4.2.2.tar.gz -O
- unpack the source: tar -xvfz mercurial-4.2.2.tar.gz
- install: cd mercurial-4.2.2 
- python setup.py --pure install

(you can't use pip because pip will try to compile, so you have to do a "pure" install, using only Python).

Mercurial will use your SSH keys, stored in .ssh/ You can create them using Blink, then save them to .ssh/ using "ssh-save-id [name-of-the-key]". You will also have to upload the public key on your server (e.g. [Bitbucket](http://bitbucket.org)). You will need to download the [CAcert certificates](https://www.mercurial-scm.org/wiki/CACertificates). 

Your Mercurial configuration file is stored in  ~/Documents/.hgrc (you don't have the right to write in ~/.hgrc in iOS, unless it's jailbroken). You can place it elsewhere if you change the value of the $HGRCPATH environment variable. 

Once you've done that, you're done. Try "hg clone your-repository". Then edit your files (in place) using [VimIOS](https://github.com/holzschu/VimIOS). 

# TODO:
- make the install process more friendly 
- allow for shell redirection 
