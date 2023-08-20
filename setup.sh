#!/usr/bin/env bash

setupBackend() {
  echo "--------------------------- Creating virtual environment ----------------------"
  pip install virtual env
  virtualenv venv
  source venv/Script/active

  echo "----------------------- Installing dependencies ------------------------------"
  pip install -r requirements.txt

  echo "----------------------- Running Django server -------------------------"
  python kudelasz/manage.py runserver
}

setupFrontEnd() {
  touch frontend
  cd frontend

  echo "------------- Pulling frontend repository ----------------------"
  git clone git@github.com:domjanzsoo/kudelasz-client.git .

  echo "---------------- Installing dependencies ------------------------"
  npm install

  echo "----------------- Building frontend -----------------------------"
  npm run build
}

pullBackend() {
  echo "---------- Pulling master branch ---------------------"
  cd kudelasz
  git pull origin master
}

pullFrontend(){
  if [ ! -f "frontend" ]; then
    die "Frontend directory not found"
  fi

  echo "--------------- Pulling master branch ------------------------------"
  cd "frontend"
  git pull origin master
}

setupBackend
setupFrontEnd







