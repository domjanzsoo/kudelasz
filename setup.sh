#!/usr/bin/env bash

setupBackend() {
  echo "$(tput setaf 2)--------------------------- Creating virtual environment ----------------------$(tput sgr 0)"
  pip install --upgrade pip
  pip install virtualenv
  virtualenv venv
  source ./venv/Scripts/activate

  echo "$(tput setaf 2)----------------------- Installing dependencies ------------------------------$(tput sgr 0)"
  pip install -r requirements.txt

  echo "$(tput setaf 2)---------------------------Running migrations -----------------------------------$(tput sgr 0)"
  python ./kudelasz/manage.py migrate

  echo "$(tput setaf 2)----------------------- Running Django server -------------------------$(tput sgr 0)"
  python ./kudelasz/manage.py runserver
}

setupFrontend() {
  mkdir frontend

  echo "$(tput setaf 2)------------- Pulling frontend repository ----------------------$(tput sgr 0)"
  cd frontend && git clone git@github.com:domjanzsoo/kudelasz-client.git .

  echo "$(tput setaf 2)---------------- Installing dependencies ------------------------$(tput sgr 0)"
  npm install

  echo "$(tput setaf 2)----------------- Building frontend -----------------------------$(tput sgr 0)"
  npm run build
}

pullBackend() {
  echo "$(tput setaf 2)---------- Pulling master branch ---------------------$(tput sgr 0)"
  cd kudelasz
  git pull origin master
}

pullFrontend(){
  if [ ! -f "frontend" ]; then
    die "Frontend directory not found"
  fi

  echo "--------------- Pulling master branch ------------------------------$(tput sgr 0)"
  cd "frontend"
  git pull origin master
}

setupBackend







