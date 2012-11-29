$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'intellimux/cli/version'

Gem::Specification.new do |s|
  s.name = "intellimux"
  s.version = IntelliMux::CLI::VERSION

  s.summary = "Launches new tmux panes based on configurable workflow-based options."
  s.description = "IntelliMux is a command-line tool to launch commands into new panes in tmux.  It takes care of setting things up just the way you want it so you can focus on working on the things that matter more."

  s.authors = ["Andrew Regner"]
  s.email = "andrew@aregner.com"
  s.homepage = "https://github.com/adregner/intellimux"

  s.files = `git ls-files lib`.split("\n")
  s.files += `git ls-files bin`.split("\n")
  s.files.reject! { |fn| fn.include?(".dev") }

  s.executables = ["intellimux"]
end
