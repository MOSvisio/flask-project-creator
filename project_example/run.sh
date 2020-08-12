#!/bin/bash 
BASEDIR=$(dirname "$0")
cd $BASEDIR

export FLASK_APP=project_example
export FLASK_ENV=development
flask run
