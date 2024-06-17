# Bolt Puppet Module

[![Build Status](https://github.com/voxpupuli/puppet-bolt/workflows/CI/badge.svg)](https://github.com/voxpupuli/puppet-bolt/actions?query=workflow%3ACI)
[![Release](https://github.com/voxpupuli/puppet-bolt/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-bolt/actions/workflows/release.yml)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/bolt.svg)](https://forge.puppetlabs.com/puppet/bolt)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/bolt.svg)](https://forge.puppetlabs.com/puppet/bolt)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/bolt.svg)](https://forge.puppetlabs.com/puppet/bolt)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/bolt.svg)](https://forge.puppetlabs.com/puppet/bolt)
[![puppetmodule.info docs](https://www.puppetmodule.info/images/badge.png)](https://www.puppetmodule.info/m/puppet-bolt)
[![AGPL v3 License](https://img.shields.io/github/license/voxpupuli/puppet-bolt.svg)](LICENSE)

## Table of contents

* [Usage](#usage)
  * [Running plans](#running-plans)
* [Limitations](#limitations)
* [Contributions](#contributions)
* [License and Author](#license-and-author)

## Usage

The idea of this module is to configure bolt. The default is to install the
`puppet-tools-release` package from `yum.puppet.com`. The source is
configureable via the `base_url` parameter. Examples and all parameters are
documented in the [REFERENCE.md](https://github.com/voxpupuli/puppet-bolt/blob/master/REFERENCE.md)

### Running plans

This module provides a way to run bolt plans in a complicated way. There's a
defined resource that creates a bolt project, `bolt::project`. It's also
documented in the [REFERENCE.md](https://github.com/voxpupuli/puppet-bolt/blob/master/REFERENCE.md).

The defined resource will create its own directory and user. It will also create
a multi-instance systemd unit like `$project@%i.service`. You can start the unit
with any plan name **and systemd will run the plan in the background**.

This is useful if you need to start plans via the PE orchestrator that
manipulate the orchestrator itself. That usually deadlocks or restarts the
orchestrator which in turn kills the plan.

Now you can:

* Use PE Orchestrator API to start a task
* the [service](https://forge.puppet.com/modules/puppetlabs/service/readme) task will start the systemd unit
* systemd will start bolt in the background
* consecutive service tasks can check for the state of the bolt systemd unit

## Limitations

This module is only written for RedHat-like systems at the moment. For an
update list of operating systems we test on please check the metadata.json.

## Contributions

Contribution is fairly easy:

* Fork the module into your namespace
* Create a new branch
* Commit your bugfix or enhancement
* Write a test for it (maybe start with the test first)
* Create a pull request

Detailed instructions are in the [CONTRIBUTING.md](https://github.com/voxpupuli/puppet-bolt/blob/master/.github/CONTRIBUTING.md)
file.

## License and Author

This module was originally written by [Tim Meusel](https://github.com/bastelfreak).
It's licensed with [AGPL version 3](LICENSE).
