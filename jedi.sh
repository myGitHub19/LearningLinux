#!/bin/bash

# Deletes the passed user and their  home directory then recreates them
remove_create_user(){
    userdel $1
    rm -r /home/$1
    useradd $1
    echo Function complete!
}
# For the users in the list, create them if they do not exist
# if they do exist then dleete and recreate them
users=(Padme JarJar Anakin)
for user in ${users[@]}
do
    # if the user is not in the passwd file
    if ! grep -q $user /etc/passwd;
    then
       useradd $user
    else
       remove_create_user $user
    fi
done

# Add the groups Naboo and Besotted
groupadd Naboo
groupadd Besotted

# Move the users into their respective groups
usermod -a -G Naboo Padme
usermod -a -G Naboo JarJar
usermod -a -G Besotted Padme
usermod -a -G Besotted Anakin

# Change JarJar home directory to meesahome
usermod -d /home/meesahome -m JarJar

# Create passwords for each user
echo "Padme:secret123" | chpasswd
echo "JarJar:secret123" | chpasswd

echo ')(DLKJK@$#$%LKJEW_*$Nnnnsert87X' | passwd --stdin Anakin


# Add Anakin to the sudoers (wheel) group
usermod -aG wheel Anakin
