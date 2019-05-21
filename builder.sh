#! /bin/bash

virtualenv ansible -p python3
. ansible/bin/activate
pip install -r requirements.txt
