# dotfiles

My personal dotfiles: Zsh, Git, SSH, Kerberos, Homebrew and Claude Code configuration.

Symlinks are managed by [dotbot](https://github.com/anishathalye/dotbot), vendored as a submodule. Files are stored here and linked to their dotted destinations.

## Install

```bash
git clone --recurse-submodules https://github.com/barnes-c/dotfiles.git
cd dotfiles
./install
```

[`install`](https://github.com/barnes-c/dotfiles/blob/master/install) syncs the dotbot
submodule, links everything declared in
[`install.conf.yaml`](https://github.com/barnes-c/dotfiles/blob/master/install.conf.yaml),
then re-exports the `Brewfile`. It is idempotent — re-run it after pulling changes.

To add a dotfile, commit it here and add an entry to `install.conf.yaml`. Don't link by hand.

### What gets linked

|                   Source                   |                     Destination                     |    Platform     |
| ------------------------------------------ | --------------------------------------------------- | --------------- |
| `aliases`, `bash_profile`, `zshrc`         | `~/.aliases`, `~/.bash_profile`, `~/.zshrc`         | all             |
| `gitconfig`, `gitconfig.cern`, `gitignore` | `~/.gitconfig`, `~/.gitconfig.cern`, `~/.gitignore` | all             |
| `gitconfig.signers`                        | `~/.ssh/git_signers`                                | all             |
| `sshconfig`                                | `~/.ssh/config`                                     | all             |
| `claude`                                   | `~/.claude`                                         | macOS           |
| `krb5.conf`                                | `/etc/krb5.conf`                                    | macOS           |
| `krb5.conf`                                | `~/krb5.conf`                                       | Linux           |
| `hosts`                                    | `/etc/hosts`                                        | Linux, non-CERN |

`claude/` is linked as a whole directory, so `claude/settings.json` and `claude/agents/` are
the running Claude Code configuration rather than copies of it.

### oh-my-zsh

Plugins are not vendored. `zshrc` enables each one only if present, so this step is optional
(and skipped on CERN hosts, where only `git` is available):

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-completions \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
```

### Homebrew

To restore the recorded formulas, casks and taps:

```bash
brew bundle --file ./Brewfile
```

`./install` refreshes the `Brewfile` automatically on every run, so it will often show up as
modified in `git status` afterwards. To export it by hand:

```bash
brew bundle dump --describe --force
```

## Git identities

`gitconfig` holds the personal identity and conditionally includes `gitconfig.cern` via
`includeIf "gitdir:"` for work checkouts under `~/Code/cern/` and the AFS home. Both sign
commits with SSH keys; `gitconfig.signers` is the allowed-signers file used to verify them.

## License

- This repository is licensed under the [GNU AGPLv3](https://github.com/barnes-c/dotfiles/blob/master/LICENSE).
