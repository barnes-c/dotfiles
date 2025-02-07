# Dotfiles Repository

This repository contains my personal dotfiles for configuring my development environment. It includes settings for Zsh, Homebrew, Git, and other tools.

## Usage

To set up your environment using these dotfiles:

1.  Clone this repository to your local machine:

    ```sh
    git clone <repository_url> ~/.dotfiles
    cd ~/.dotfiles
    ```

2.  Run the [bootstrap.sh](bootstrap.sh) script:

    ```sh
    bash bootstrap.sh
    ```

    This script will:

    - Install Oh My Zsh.
    - Symlink configurations to your home directory.
    - Install Homebrew and the packages listed in [brew_programs_list.txt](brew/brew_programs_list.txt) and [brew_casks_list.txt](brew/brew_casks_list.txt).

## Customization

- **Aliases**: Add or modify aliases in [.aliases](http://_vscodecontentref_/4).
- **Homebrew**: To update the lists of Homebrew packages in [brew_programs_list.txt](brew/brew_programs_list.txt) and [brew_casks_list.txt](brew/brew_casks_list.txt) run:
  ```sh
  bash export_brew.sh
  ```
  in the brew folder
- **Zsh**: Modify your Zsh configuration in [.zshrc](shell/.zshrc).

## License

This project is licensed under the MIT License - see the [LICENSE](http://_vscodecontentref_/9) file for details.
