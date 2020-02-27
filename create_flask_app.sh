#!/bin/bash

# This script create a simple flask application 

# Created by : SCHUTZ Lucas
# http://lucas-schutz.tech

projectName=$1
projectName="$( echo $projectName | tr '-' '_')"

echo 'creating ' $projectName ' app'

if [ $# -gt 0 ]
then
    if [ -e $projectName ] && [ -d $projectName ]
    then 
        echo 'Error! : this folder already exist'
    else
        mkdir $projectName
        cd $projectName
        touch setup.py

        setup_data='from setuptools import setup\n\nsetup(\n\tname="'$projectName'",\n\tpackages=["'$projectName'"],\n\tinclude_package_data=True,\n\tinstall_requires=[\n\t\t"flask",\n\t\t"flask_sqlalchemy"\n\t],\n)'
        echo -e $setup_data >> setup.py

	#make run.sh executable 
        touch run.sh
        if [ ! -x $run.sh ]
        then 
            chmod +x run.sh
        fi

        run_script='#!/bin/bash \nBASEDIR=$(dirname "$0")\ncd $BASEDIR\n\nexport FLASK_APP='$projectName'\nexport FLASK_ENV=development\nflask run'
        echo -e $run_script >> run.sh

	#Procfile used to push to heroku
	touch Procfile
	procfile_data='web: gunicorn '$projectName':app'
	echo -e $procfile_data >> Procfile

	#folder that will contains source code
        mkdir $projectName
        cd $projectName

        touch __init__.py

        init_data='from flask import Flask\nfrom flask_sqlalchemy import SQLAlchemy\n\napp = Flask(__name__)\n\napp.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///database.db"\n\ndb = SQLAlchemy(app)\n@app.route("/")\ndef index():\n\treturn "welcome to your new project"'

        echo -e $init_data >> __init__.py

    fi
else
	echo "Error! : Enter your project's name"
fi
