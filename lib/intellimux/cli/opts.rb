require 'optparse'

# Opts module shamelessly stolen from Chris Wuest

# Public: The CLI Opts module provides methods to abstract and simplify loading
# configuration information, parsing options and providing context to the
# application.
module Opts extend self
  CONFIG_LOCATION = "~/.config/intellimuxrc"
  # Public: Open config files if applicable, overwriting default options with
  # configuration passed files first, then with any options supplied via the
  # command line.
  #
  # Returns a Hash containing an option to value map.
  def parse
    options = {}
    options.merge(parse_config_file(CONFIG_LOCATION))

    argv = parse_argv
    if argv[:config_file].kind_of?(String)
      options.merge(parse_config_file(argv[:config_file]))
    end

    options.merge(argv)
  end

  # Internal: Open and parse a given config file.
  #
  # file - String containing path to a configuration file which will be parsed.
  #
  # Returns a Hash containing an option to value map.
  def parse_config_file(file)
    options = {}
    return options if file.nil?

    config_string = ""
    if File.exists?(File.expand_path(file))
      config_string << File.open(File.expand_path(file)).read
    end

    config_string.each_line do |line|
      line.strip!.gsub!(/#.*/, "")
      next if line.empty?

      opt,value = line.split(/\s*/, 2)
      options[opt.to_sym] = value
    end

    options
  end

  # Internal: Parse and return options passed via the command line.
  #
  # Returns a Hash containing an option to value map.
  def parse_argv
    options = {}

    optparse = OptionParser.new do |opts|
      opts.on '-h', '--help', 'Display this help dialog' do
        puts opts
        exit
      end

      opts.on '-s', '--session NAME', 'Target a given session name' do |opt|
        options[:session] = opt
      end

      opts.on '-w', '--window NAME', 'Target a given window name within the session' do |opt|
        options[:window] = opt
      end

      opts.on '-c', '--command COMMAND', 'Command to execute in the new pane' do |opt|
        options[:command] = opt
      end

      #opts.on '-c', '--config FILE', 'Load configuration saved from previous ' +
      #                               'session (useful with -r)' do |file|
      #  unless File.exists?(File.expand_path(file))
      #    puts "Configuration file #{file} does not exist!  Exiting."
      #    exit
      #  end
      #  options[:config_file] = File.expand_path(file)
      #end
    end
    optparse.parse!

    options
  end
end
