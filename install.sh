#!/usr/bin/env bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

source install/git.sh

# only perform macOS-specific install
if [ "$(uname)" == "Darwin" ]; then
    echo -e "\\n\\nRunning on macOS"

    if test ! "$( command -v brew )"; then
        echo "Installing homebrew"
        ruby -e "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install )"
    fi

    # install brew dependencies from Brewfile
    brew bundle

    go get -u github.com/mdempsky/gocode

    # setup jenv
    jenv enable-plugin maven
    jenv enable-plugin export
    # add all jdk to jenv for easy switching
    /usr/libexec/java_home --xml | awk '/JVMHomePath/{getline; print}' | awk -F '[<>]' '{for(i=3;i<=NF;i+=3){print $i}}' | xargs -n1 jenv add

    # After the install, setup fzf
    echo -e "\\n\\nRunning fzf install script..."
    echo "=============================="
    /usr/local/opt/fzf/install --all --no-bash --no-fish

    # after the install, install neovim python libraries
    echo -e "\\n\\nRunning Neovim Python install"
    echo "=============================="
    pip3 install pynvim

    # Change the default shell to zsh
    zsh_path="$( command -v zsh )"
    if ! grep "$zsh_path" /etc/shells; then
        echo "adding $zsh_path to /etc/shells"
        echo "$zsh_path" | sudo tee -a /etc/shells
    fi

    if [[ "$SHELL" != "$zsh_path" ]]; then
        chsh -s "$zsh_path"
        echo "default shell changed to $zsh_path"
    fi

    source install/osx.sh
fi

echo "creating vim directories"
mkdir -p ~/.vim-tmp

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s "$(command -v zsh)"
fi

# Setup Oh My Zsh
if ! [[ -d "$ZSH" ]]; then
    ZSH="$HOME/.dotfiles/oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    rm ~/.zshrc
fi

echo "Installing dotfiles."

source install/link.sh

echo "Done. Reload your terminal."
