# dotfiles

This repository contains my personal dotfiles for configuring my MacOS devices. It includes settings for Zsh, Homebrew, Git, and other tools.

## Install

Running the [`install`](https://github.com/barnes-c/dotfiles/blob/master/install) script will link files from this repository to your `$HOME`. It will also export all installed brew formulas, casks and taps.

### Installing brew

To install the brew formulas, casks and taps run following command:

```bash
brew bundle --file ./Brewfile
```

## License

- This repository is licensed under the [GNU AGPLv3](https://github.com/barnes-c/dotfiles/blob/master/LICENSE).
