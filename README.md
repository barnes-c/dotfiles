# dotfiles

This repository contains my personal dotfiles for configuring my MacOS devices. It includes settings for Zsh, Homebrew, Git, and other tools.

## Install

Running the [`install`](https://github.com/barnes-c/dotfiles/blob/master/install) script will link files from this repository to your `$HOME`. It will also export all installed brew formulas, casks and taps.

### oh-my-zsh

To install the plugins for oh-my-zsh run:

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-completions \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
```

### Installing brew

To install the brew formulas, casks and taps run following command:

```bash
brew bundle --file ./Brewfile
```

and to update the Brewfile you can export it with:

```bash
brew bundle dump --describe --force
```

## License

- This repository is licensed under the [GNU AGPLv3](https://github.com/barnes-c/dotfiles/blob/master/LICENSE).
