#!/bin/bash
git remote add gigalixir https://$GIGALIXIR_EMAIL:$GIGALIXIR_API_KEY@git.gigalixir.com/$GIGALIXIR_APP_NAME.git
git push -f gigalixir HEAD:refs/heads/master

# # install gigalixir-cli
# - sudo apt-get install -y python-pip
# - sudo pip install --upgrade setuptools
# - sudo pip install gigalixir
#
# # login
# - gigalixir login -e "$GIGALIXIR_EMAIL" -p "$GIGALIXIR_PASSWORD" -y
# - gigalixir set_git_remote $GIGALIXIR_APP_NAME
#
# # set up ssh so we can migrate
# - mkdir ~/.ssh
# - printf "Host *\n StrictHostKeyChecking no" > ~/.ssh/config
# - echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
#
# # migrate
# - gigalixir migrate $GIGALIXIR_APP_NAME
