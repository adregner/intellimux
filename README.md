IntelliMux
==========

This is a tool to launch a given command into a new pane in tmux.  It will intelligently handle the current tmux environment and do what it needs to do in order to make sure that you always have a seemless workflow as you focus on more importaint things.

Configuration
-------------

Settings can be made in a configuration file (located at ~/.config/intellimux) or on the command line, with the CLI options always taking precedence.

```
$ intellimux --help
Usage: intellimux [options]
    -h, --help                       Display this help dialog
    -s, --session NAME               Target a given session name
    -w, --window NAME                Target a given window name within the session
    -c, --command COMMAND            Command to execute in the new pane
```
```
$ cat ~/.config/intellimux
# name of the default session all commands/panes will spawn in
session servers

# default window to place panes that aren't otherwise categorized
window unknown
```

Dependencies
------------
Ruby
  * I've only tested this on ruby 1.9.

tmux-ruby gem
  * gem install tmux-ruby
  * version > 0.0.2, not yet released
