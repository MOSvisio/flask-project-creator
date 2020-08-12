#!/bin/bash 

if command -v pip3 
then
pip3 freeze > requirements.txt
else
echo "pip3 is not installed, install it and run : pip3 freeze > requirements.txt"
fi
