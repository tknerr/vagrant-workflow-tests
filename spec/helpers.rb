
BASE_DIR=File.expand_path('.')
LOGFILE = "#{BASE_DIR}/acceptance.log"


# enable :should syntax for rspec 3
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end

module Helpers
  # runthe command and return both stdout and stderr
  def run_cmd(cmd)
    `#{cmd} 2>&1`
  end
  # similar to #run_cmd, but uses system and returns the exit code
  # (both stdout and stderr are redirected to acceptance.log)
  def system_cmd(cmd)
    system "echo \"--> Running command: '#{cmd}':\" >>#{LOGFILE}"
    unless (status = system "#{cmd} >>#{LOGFILE} 2>&1")
      puts "Command failed: '#{cmd}'\n  --> see #{LOGFILE} for details"
    end
    status
  end
  # converts the path to using backslashes
  def convert_slashes(path)
    path.gsub('/', '\\').gsub('\\', '\\\\\\\\') #eek
  end
  # runs #system_cmd and checks for success (i.e. exit status 0)
  def cmd_succeeds(cmd)
    system_cmd(cmd).should be true
  end
  # checks if the given line is contained in the environment
  def env_match(line)
    run_cmd("set").should match(/^#{convert_slashes(line)}$/)
  end
  # checks if the given gem is installed at version
  def vagrant_plugin_installed(name)
    run_cmd("vagrant plugin list").should match("#{name}")
  end
  # returns true if the box is already imported into vagrant
  def box_imported?(box)
    run_cmd("vagrant box list").include?(box)
  end

end