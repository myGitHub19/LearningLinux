#!/bin/bash

adduser homer
adduser marge
adduser bart
adduser lisa

groupadd family
groupadd finance

usermod -a -G family homer
usermod -a -G famliy marge
usermod -a -G family bart
usermod -a -G family lisa

usermod -a -G finance homer
usermod -a -G finance marge

mkdir /home/family

chown -R marge /home/family
chgrp family /home/family
chmod 754 /home/family

mkdir /home/finance
chown -R marge /home/finance
chgrp finance /home/finance
chmod 754 /home/finance

cd /home/finance
touch testfile.txt

cd ..
cd /home/family
touch testfile2.txt


