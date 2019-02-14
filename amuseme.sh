#!/bin/sh

# if no parameters were passed, prompt the user.
if [ -z "$*" ];
then
    echo 'please input a parameter'
fi

# if the rhymes directory exists,
# a) remove the directory and recreate it
# b) create the directory
if [ -d "./rhymes" ];
then
    rm  -r ./rhymes
    mkdir -p ./rhymes
else
    mkdir -p  ./rhymes
fi

# redirects the program to the rhymes folder
# which contains the story and the html file.
cd ./rhymes

# grabs the story from the designated url
url=https://acit2420.jlparry.com/data/JackAndJill.txt

# assigns the user variable
uUsed=$USER

# returns the actual text from the url supplied
result=$(wget -qO- $url)

# boolean variable for allowing firefox to be opened
# at the end of the file
openFirefox=False

# moves the actual story text to a txt file for
# string replacement
echo $result > ./jackandjill.txt

# for all the parameters
# -x) allows firefox to be opened at the end of all
#    replacements
# -u) sets the parameter after -u to be the name inputted
# Afterwards the words crown and vinegar are replaced with
# inputted strings
while [ $# -gt 0 ]
do
    # if the first parameter is -x then allow firefox to open
    if [ $1 = "-x" ]; then
        openFirefox=True
        shift;
        continue
    fi
    # if the first parameter is -u, then the next parameter
    # will be the user defined name.
    if [ $1 = "-u" ]; then
        name=$2
        shift;shift;
        continue
    fi

    param1=$1
    param2=$2

    sed -i -e "s/crown/$param1/g" ./jackandjill.txt
    sed -i -e "s/vinegar/$param2/g" ./jackandjill.txt
    sed -i -e "s/Jill/$name/g" ./jackandjill.txt
    # send the text from the txt file to the html file
    echo $(cat ./jackandjill.txt) > ./index.html

    break;
done

# open firefox if -x was inputted
if [ $openFirefox = True ]; then
    firefox ./index.html
fi
