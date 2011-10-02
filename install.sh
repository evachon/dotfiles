#!/bin/bash
DEST_DIR=$HOME
INSTALL_SCRIPT_DIR="$( cd -P "$( dirname "$0" )" && pwd )"
FILES_TO_LINK=
RUBY_VERSION_COMMANDT=1.8.7

# Load RVM into a shell session *as a function*
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  # First try to load from a user install
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]]; then
  # Then try to load from a root install
  source "/usr/local/rvm/scripts/rvm"
else
  echo "ERROR: An RVM installation was not found."
fi

function install_all() {
  install_vim
}

function install() {
for file in $FILES_TO_LINK
do
  echo "Making a link from file $INSTALL_SCRIPT_DIR/$file to $DEST_DIR/$file"
  if [ -d $DEST_DIR/$file ];then
    # Ln can't overwrite directory, so we do it for him
    echo "$DEST_DIR/$file already exist, would you like to overwrite it? (Y/N):"
    read ANSWER
    if [[ "$ANSWER" != [Nn] ]];then
      rm -R $DEST_DIR/$file
      create_link
    fi
  else
    create_link
  fi
done
}

function install_vim() {
echo "Starting Vim plugins installation..."
FILES_TO_LINK=".vimrc .vim"
install
install_commandT
}

function install_commandT() {
echo "Trying to automatically install commandT..."
RUBY_GOOD_VERSION=true
COMMANDT_INSTALL_FOLDER="$HOME/.vim/bundle/command-T/ruby/command-t"
if [ ! -d $COMMANDT_INSTALL_FOLDER ];then
  echo "You must run ./install vim first."
  exit
fi
if [ $(which ruby) ];then
  if [[ ! $(ruby --version) == *$RUBY_VERSION_COMMANDT* ]];then
    if [ $(which rvm) ];then
      rvm use $RUBY_VERSION_COMMANDT > /dev/null
      if [[ ! $(ruby --version) == *$RUBY_VERSION_COMMANDT* ]];then
        RUBY_GOOD_VERSION=false
      fi
    fi
  fi
else
  echo "FALSEFALSEFALSE"
  RUBY_GOOD_VERSION=false
fi

if [ $RUBY_GOOD_VERSION == true ];then
  if [[ $(which make) ]];then
    cd $COMMANDT_INSTALL_FOLDER
    rm *.o
    (ruby extconf.rb && make) || echo "Can't compile Command-T, see the README in commandT folder to install it manualy."
    cd $INSTALL_SCRIPT_DIR
  else
    echo -e "CommandT needs 'make' to be built. Install it then, run this script again with commandT as argument:\n     ./install commandT"
  fi
else
  echo -e "CommandT needs 'ruby $RUBY_VERSION_COMMANDT' to be built, install it and then, run this script again with commandT as argument:\n   ./install commandT\nFor more informations on the tools needed for installing and running commandT, see ~/.vim/bundle/commandT/README."
fi
}

function create_link() {
ln -nis $INSTALL_SCRIPT_DIR/$file $DEST_DIR/$file
}

if [ "$1" == "vim" ];then
  install_vim
elif [[ "$1" == command[Tt] ]];then
  install_commandT
else
  install_all
fi
