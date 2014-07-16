# Vagrant Workflow Tests

Specs for my Vagrant / Chef Solo based workflow. 

It is intended for testing whether the environment in which it is used has all the prerequisites installed and that the common scenarios can be excercised. 


# Prerequisites

You are in a sane development environment and have following tools installed:

 * Git
 * Vagrant >= 1.6, with
   * vagrant-omnibus
   * vagrant-berkshelf
   * vagrant-toplevel-cookbooks


# Usage

Whenever you think you are in a sane environment, you can excercise the workflow specs like so:

# `git clone https://github.com/tknerr/vagrant-workflow-test`
# `cd vagrant-workflow-test`
# `bundle install`
# `rake test`

You should see an output like this and all tests should pass:

 TODO
