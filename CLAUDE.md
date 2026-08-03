# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
./install                        # link dotfiles into $HOME (idempotent), then re-export Brewfile
./install -v                     # same, with dotbot verbose output
brew bundle --file ./Brewfile    # install the recorded formulas/casks/taps
```

There is no build, test, or lint step — this repo is configuration, not code.

## Architecture

`install.conf.yaml` is the single source of truth. It is a [dotbot](https://github.com/anishathalye/dotbot)
config (dotbot is a git submodule) mapping repo files to their destinations. Files here are
*unprefixed* (`zshrc`, `gitconfig`) and get linked to their dotted counterparts (`~/.zshrc`,
`~/.gitconfig`). To add a dotfile, add it to the repo and add a line to `install.conf.yaml` —
never symlink by hand.

`install` is a thin wrapper: it syncs the dotbot submodule, runs dotbot, then runs
`brew bundle dump --force`.

Link targets are conditional on platform via `if:` guards in the config:

- `claude/` → `~/.claude` and `krb5.conf` → `/etc/krb5.conf` are macOS-only
- `krb5.conf` → `~/krb5.conf` and `hosts` → `/etc/hosts` are Linux-only, and the `/etc/hosts`
  link is further suppressed on CERN hosts (which manage their own)

### `claude/` is live config

`claude/` is symlinked to `~/.claude`, so `claude/settings.json`, `claude/agents/*.md`, and
`claude/CLAUDE.md` are the *running* Claude Code configuration, not copies of it. Editing them
takes effect immediately. Note `claude/CLAUDE.md` is the global, all-projects preferences file —
distinct from this repo-scoped one.

`claude/settings.json` denies `Bash(git commit:*)`, so commits are expected to be made by the user.

### Git identity switching

`gitconfig` carries the personal identity and conditionally includes `gitconfig.cern` via
`includeIf "gitdir:"` for `~/Code/cern/` and the AFS home. Both identities sign commits with
SSH keys; `gitconfig.signers` is the allowed-signers file for verification.

## Gotchas

**`/etc` links cannot be repaired by `./install`.** dotbot runs unprivileged, so a wrong or
missing `/etc/krb5.conf` (or `/etc/hosts`) fails with `Failed to remove ...`. Fix it manually and
re-run:

```bash
sudo ln -sfn /Users/barnes-c/Code/dotfiles/krb5.conf /etc/krb5.conf
```

Never suggest `sudo ./install` as a shortcut — it recreates every `$HOME` link owned by root.

**Path casing.** macOS's filesystem is case-insensitive, so `~/code/dotfiles` and `~/Code/dotfiles`
both work, but dotbot compares link targets as *strings* and reports a case-mismatched link as
`Incorrect link`. `install` resolves `BASEDIR` through `realpath` to canonicalise this. Beware that
`alias c="cd $HOME/code"` in `aliases` lands you on the lowercase spelling.

**`./install` always dirties `Brewfile`,** because it ends with `brew bundle dump --force`. A
modified `Brewfile` after running it is expected, not a change you introduced.

## Post-install steps not covered by dotbot

oh-my-zsh plugins (`zsh-syntax-highlighting`, `zsh-autosuggestions`, `zsh-completions`) are cloned
manually into `$ZSH/custom/plugins`; see README.md. `zshrc` degrades gracefully when they are
absent, which is the case on CERN hosts.
