#!/bin/bash

echo 'creating ' $1 ' app'

if [ $# > 0 ]
then
    if [ -e $1 ] && [ -d $1 ]
    then 
        echo 'this folder already exist'
    else
        mkdir $1 
        cd $1
        touch setup.py

        setup_data='from setuptools import setup\n\nsetup(\n\tname="'$1'",\n\tpackages=["'$1'"],\n\tinclude_package_data=True,\n\tinstall_requires=[\n\t\t"flask",\n\t\t"flask_sqlalchemy"\n\t],\n)'

        echo -e $setup_data >> setup.py

        touch run.sh
        if [ ! -x $run.sh ]
        then 
            chmod +x run.sh
        fi

        run_script='#!/bin/bash \nBASEDIR=$(dirname "$0")\ncd $BASEDIR\n\nexport FLASK_APP='$1'\nexport FLASK_ENV=development\nflask run'

        echo -e $run_script >> run.sh

        mkdir $1
        cd $1

        touch __init__.py

        init_data='from flask import Flask\nfrom flask_sqlalchemy import SQLAlchemy\n\napp = Flask(__name__)\n\napp.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///database.db"\n\ndb = SQLAlchemy(app)\n@app.route("/")\ndef index():\n\treturn "welcome to you new project"'

        echo -e $init_data >> __init__.py
    fi
fi