#!/usr/bin/env zsh

set -euo pipefail

repo_dir=${0:A:h}
zsh_custom=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

clone_if_missing() {
    local url=$1
    local destination=$2

    if [[ -d "$destination/.git" ]]; then
        if [[ "${UPDATE_DOTFILES_DEPS:-0}" == 1 ]]; then
            git -C "$destination" pull --ff-only
        fi
        return 0
    fi
    if [[ -e "$destination" ]]; then
        print -u2 "Cannot install $url: $destination exists and is not a Git checkout."
        return 1
    fi
    mkdir -p "${destination:h}"
    git clone --depth=1 "$url" "$destination"
}

clone_if_missing https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
clone_if_missing https://github.com/zsh-users/zsh-completions.git "$zsh_custom/plugins/zsh-completions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_custom/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/romkatv/powerlevel10k.git "$zsh_custom/themes/powerlevel10k"
clone_if_missing https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"

if command -v brew >/dev/null 2>&1 && ! command -v gh >/dev/null 2>&1; then
    brew install gh
fi

link_dotfile() {
    local file=$1
    local source="$repo_dir/$file"
    local destination="$HOME/$file"

    if [[ -L "$destination" && "$(readlink "$destination")" == "$source" ]]; then
        return 0
    fi

    if [[ -e "$destination" || -L "$destination" ]]; then
        local backup="$destination.$(date +%Y%m%d%H%M%S).bak"
        mv "$destination" "$backup"
        print "Backed up $destination to $backup"
    fi

    ln -s "$source" "$destination"
}

link_dotfile .vimrc
link_dotfile .zshrc

if [[ ! -e "$HOME/.zshrc.local" ]]; then
    cat > "$HOME/.zshrc.local" <<'EOF'
# Machine-specific shell settings. This file is intentionally not tracked.
# export PULUMI_CONFIG_PASSPHRASE='replace-me'
EOF
    chmod 600 "$HOME/.zshrc.local"
    print "Created $HOME/.zshrc.local; add local secrets there."
fi

if command -v vim >/dev/null 2>&1; then
    vim +PluginInstall +qall
fi

print "Dotfiles installed from $repo_dir"
