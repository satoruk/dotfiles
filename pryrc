# vim:set ft=ruby:

# Alias
Pry.config.commands.alias_command 'w', 'whereami'

# Hit Enter to repeat last command
Pry::Commands.command /^$/, 'repeat last command' do
  _pry_.run_command Pry.history.to_a.last
end
