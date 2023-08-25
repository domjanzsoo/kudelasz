#!/usr/bin/env bash

environment="dev"
serve="false"

while getopts "e:s:" var
do
  case "$var" in
    e) environment=${OPTARG};;
    s) serve=${OPTARG};;
  esac
done

setupBackend() {
  echo "$(tput setaf 2)--------------------------- Copying $(environment) environment file ----------------------$(tput sgr 0)"
  cp ./kudelasz/.env-${environment} ./kudelasz/.env
  echo "$(tput setaf 2)--------------------------- Done ----------------------$(tput sgr 0)"

  echo "$(tput setaf 2)--------------------------- Creating virtual environment ----------------------$(tput sgr 0)"
  pip install --upgrade pip
  pip install virtualenv
  virtualenv venv
  source ./venv/Scripts/activate
  echo "$(tput setaf 2)--------------------------- Done ----------------------$(tput sgr 0)"

  echo "$(tput setaf 2)----------------------- Installing dependencies ------------------------------$(tput sgr 0)"
  pip install -r requirements.txt
  echo "$(tput setaf 2)--------------------------- Done ----------------------$(tput sgr 0)"

  echo "$(tput setaf 2)---------------------------Running migrations -----------------------------------$(tput sgr 0)"
  python ./kudelasz/manage.py migrate
  echo "$(tput setaf 2)--------------------------- Done ----------------------$(tput sgr 0)"

  if [[$serve == "true" ]]; then
    echo "$(tput setaf 2)----------------------- Running Django server -------------------------$(tput sgr 0)"
    python ./kudelasz/manage.py runserver
    echo "$(tput setaf 2)--------------------------- Done ----------------------$(tput sgr 0)"
  fi
}

setupFrontend() {
  mkdir frontend

  echo "$(tput setaf 2)------------- Pulling frontend repository ----------------------$(tput sgr 0)"
  cd frontend && git clone git@github.com:domjanzsoo/kudelasz-client.git .
  echo "$(tput setaf 2)--------------------------- Done ----------------------$(tput sgr 0)"

  echo "$(tput setaf 2)---------------- Installing dependencies ------------------------$(tput sgr 0)"
  npm install
  echo "$(tput setaf 2)--------------------------- Done ----------------------$(tput sgr 0)"

  echo "$(tput setaf 2)----------------- Building frontend -----------------------------$(tput sgr 0)"
  npm run build
  echo "$(tput setaf 2)--------------------------- Done ----------------------$(tput sgr 0)"

  cd ../
}

pullBackend() {
  echo "$(tput setaf 2)---------- Pulling master branch ---------------------$(tput sgr 0)"
  cd kudelasz
  git checkout master
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

setupFrontend
setupBackend