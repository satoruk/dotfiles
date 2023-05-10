# vi: ft=ruby
require "readline"

def prompt(msg)
  Readline.readline("#{msg} (y/N) > ").downcase == 'y'
end

target_creator = prompt("Do you use creator's tools?")
puts target_creator

tap "1password/tap"
tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-fonts"
tap "homebrew/core"

brew "anyenv"
brew "awscli"
brew "gh"
brew "git"
brew "hadolint"
brew "jq"
brew "mas"
brew "mosh"
brew "shellcheck"
brew "tfenv"
brew "tig"
brew "tmux"
brew "vim"

cask "1password"
cask "1password-cli"
cask "deepl"
cask "discord"
cask "docker"
cask "fig"
cask "firefox"
cask "font-hackgen-nerd"
cask "google-chrome"
cask "iterm2"
cask "microsoft-edge"
cask "slack"
cask "visual-studio-code"
cask "warp"
cask "zoom"

if target_creator
  cask "raspberry-pi-imager"
  cask "OBS"
  cask "nordvpn"
  cask "vlc"
end

# mas "1Password", id: 443987910

