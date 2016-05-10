
require_relative '../helpers'

include Helpers

describe "usage scenarios" do

  PLAYGROUND = "#{BASE_DIR}/playground"
  APP_COOKBOOK_DIR = "#{PLAYGROUND}/sample-toplevel-cookbook"
  INFRA_REPO_DIR = "#{PLAYGROUND}/sample-infrastructure-repo"
  BASEBOX = "opscode_ubuntu-12.04_provisionerless"

  before(:all) do
    require 'fileutils'
    FileUtils.rm_rf LOGFILE
    FileUtils.rm_rf PLAYGROUND
    FileUtils.mkdir PLAYGROUND
  end


  describe "checking prerequisites" do
    it "has Git installed" do
      run_cmd("git --version").should match('git version')
    end
    it "has Vagrant 1.6, 1.7 or 1.8 installed" do
      run_cmd("vagrant -v").should match(/(1.6|1.7|1.8)/)
    end

    it "has 'vagrant-omnibus' plugin installed" do
      vagrant_plugin_installed "vagrant-omnibus"
    end
    it "has 'vagrant-berkshelf' plugin installed" do
      vagrant_plugin_installed "vagrant-berkshelf"
    end
    it "has 'vagrant-toplevel-cookbooks' plugin installed" do
      vagrant_plugin_installed "vagrant-toplevel-cookbooks"
    end
  end

  describe "developing top-level cookbooks" do
    it "clones an top-level cookbook via `git clone`" do
      cmd_succeeds("cd #{PLAYGROUND} && git clone https://github.com/tknerr/sample-toplevel-cookbook.git")
    end

    it "installs gem dependencies via `bundle install`" do
      cmd_succeeds("cd #{APP_COOKBOOK_DIR} && bundle install")
    end
    it "runs the unit tests via `rake test`" do
      cmd_succeeds("cd #{APP_COOKBOOK_DIR} && rake test")
    end
    it "runs the integration tests via `rake integration`" do
      cmd_succeeds("cd #{APP_COOKBOOK_DIR} && rake integration")
    end
  end

  describe "managing infrastructure" do
    it "clones an infrastructure repo via `git clone`" do
      cmd_succeeds("cd #{PLAYGROUND} && git clone https://github.com/tknerr/sample-infrastructure-repo.git")
    end

    it "brings up a VM via `vagrant up`" do
      cmd_succeeds("cd #{INFRA_REPO_DIR} && vagrant up app_v1")
    end
    it "can talk to that VM via `vagrant ssh`" do
      run_cmd("cd #{INFRA_REPO_DIR} && vagrant ssh app_v1 -c 'pwd'").should match("/home/vagrant")
    end
    it "can access the sample.html page served by the VM" do
      http_get("http://172.16.40.30/sample.html").should match("Chuck Norris")
    end
    it "can provision that VM via `vagrant provision`" do
      cmd_succeeds("cd #{INFRA_REPO_DIR} && vagrant provision app_v1")
    end
    it "can destroy that VM via `vagrant destroy`" do
      cmd_succeeds("cd #{INFRA_REPO_DIR} && vagrant destroy -f app_v1")
    end
  end
end
