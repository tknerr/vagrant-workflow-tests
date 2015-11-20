# Vagrant Workflow Tests

Specs for my Vagrant / Chef Solo based workflow. 

It is intended for testing whether the environment in which it is used has all the prerequisites installed and that the common scenarios can be excercised. It also serves as the acceptance tests for [Bill's Kitchen](https://github.com/tknerr/bills-kitchen) (a Chef/Vagrant development environment for Windows) and my [Linus' Kitchen](https://github.com/tknerr/linus-kitchen/) (a Chef/Vagrant development environment inside an Ubuntu VM).


## Scenarios

The common scenarios are centered around:

 * A [sample-toplevel-cookbook](https://github.com/tknerr/sample-toplevel-cookbook) with all kinds cookbook tests: syntax check, style checks, linting, unit and integration tests
 * A [sample-infrastructure-repo](https://github.com/tknerr/sample-infrastructure-repo) which defines a sample server infrastructure with environments and databages via Vagrant / Chef Solo


## Prerequisites

You are in a development environment with Git, Vagrant (>= 1.6), and the following Vagrant plugins installed:

 * [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus) - installs omnibus chef in a vagrant VM
 * [vagrant-berkshelf](https://github.com/berkshelf/vagrant-berkshelf) - berkshelf integration for vagrant
 * [vagrant-toplevel-cookbooks](https://github.com/tknerr/vagrant-toplevel-cookbooks) - support for one top-level cookbook per vagrant VM


## Usage

Whenever you think you are in a sane environment, you can excercise the workflow specs like so:

 1. `git clone https://github.com/tknerr/vagrant-workflow-tests`
 2. `cd vagrant-workflow-tests`
 3. `rspec`

You should see an output like this and all tests should pass:

![output of running rspec](https://cloud.githubusercontent.com/assets/365744/3607278/0579cae2-0d45-11e4-81f0-9236c592562a.png)
