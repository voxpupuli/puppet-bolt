# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`bolt`](#bolt): installs bolt via yumrepo or release package

### Defined types

* [`bolt::project`](#bolt--project): creates required files for a bolt project. Will create one oneshot service for each plan

## Classes

### <a name="bolt"></a>`bolt`

installs bolt via yumrepo or release package

#### Examples

##### install bolt via puppet-tools-release rpm

```puppet
include bolt
```

##### install bolt via puppet-tools-release which is on a mirror

```puppet
class { 'bolt':
  base_url => 'https://mirror.corp.internal',
}
```

##### manage the yumrepo directly

```puppet
class { 'bolt':
  use_release_package => false,
}
```

##### manage the yumrepo with an internal mirror with odd directory layout

```puppet
class { 'bolt':
  base_url         => 'https://internal.mirror.corp/keys/',
  yumrepo_base_url => 'https://internal.mirror.corp/puppet/puppet_tools/rhel8/',
}
```

#### Parameters

The following parameters are available in the `bolt` class:

* [`version`](#-bolt--version)
* [`base_url`](#-bolt--base_url)
* [`release_package`](#-bolt--release_package)
* [`gpgkey`](#-bolt--gpgkey)
* [`use_release_package`](#-bolt--use_release_package)
* [`yumrepo_base_url`](#-bolt--yumrepo_base_url)
* [`manage_repo`](#-bolt--manage_repo)

##### <a name="-bolt--version"></a>`version`

Data type: `String[1]`

desired version for bolt or `absent`

Default value: `'installed'`

##### <a name="-bolt--base_url"></a>`base_url`

Data type: `Stdlib::HTTPSUrl`

HTTPS URL to the yumrepo base

Default value: `$facts['os']['family'] ? { 'Debian' => 'https://apt.puppet.com/', 'RedHat' => 'https://yum.puppet.com/'`

##### <a name="-bolt--release_package"></a>`release_package`

Data type: `String[1]`

filename for the release package rpm

Default value: `$facts['os']['family'] ? { 'Debian' => "puppet-release-${fact('os.distro.codename')}.deb", 'RedHat' => "puppet-tools-release-el-${facts['os']['release']['major']}.noarch.rpm"`

##### <a name="-bolt--gpgkey"></a>`gpgkey`

Data type: `String[1]`

name of the GPG key filename in the repo

Default value: `$facts['os']['family'] ? { 'Debian' => 'DEB-GPG-KEY-puppet-20250406', 'RedHat' => 'RPM-GPG-KEY-puppet-20250406'`

##### <a name="-bolt--use_release_package"></a>`use_release_package`

Data type: `Boolean`

enable/disable the puppet-tools-release package installation. When disabled, we will configure the repo as yumrepo resource

Default value: `$facts['os']['family'] ? { 'Debian' => false, 'RedHat' => true`

##### <a name="-bolt--yumrepo_base_url"></a>`yumrepo_base_url`

Data type: `Stdlib::HTTPSUrl`

configure the full repo URL, useful when you don't exactly mirror yum.puppet.com

Default value: `"${base_url}puppet-tools/el/${facts['os']['release']['major']}/\$basearch"`

##### <a name="-bolt--manage_repo"></a>`manage_repo`

Data type: `Boolean`

when true, a repo will be added to install bolt. Useful when you manage repos externally. See also $use_release_package

Default value: `true`

## Defined types

### <a name="bolt--project"></a>`bolt::project`

creates required files for a bolt project. Will create one oneshot service for each plan

#### Examples

##### create one project and provide plan parameters

```puppet
bolt::project { 'peadmmig': }
-> file { '/opt/peadmmig/profiles::convert.json':
  owner   => 'peadmmig',
  group   => 'peadmmig',
  content => { 'primary_host' => $facts['networking']['fqdn'] }.stdlib::to_json_pretty,
}
```

#### Parameters

The following parameters are available in the `bolt::project` defined type:

* [`basepath`](#-bolt--project--basepath)
* [`project`](#-bolt--project--project)
* [`owner`](#-bolt--project--owner)
* [`group`](#-bolt--project--group)
* [`manage_user`](#-bolt--project--manage_user)
* [`environment`](#-bolt--project--environment)
* [`modulepaths`](#-bolt--project--modulepaths)
* [`local_transport_tmpdir`](#-bolt--project--local_transport_tmpdir)
* [`puppetdb_urls`](#-bolt--project--puppetdb_urls)

##### <a name="-bolt--project--basepath"></a>`basepath`

Data type: `Stdlib::Absolutepath`

rootdir where the project will be created into

Default value: `'/opt/'`

##### <a name="-bolt--project--project"></a>`project`

Data type: `String[1]`

the name of the project

Default value: `$name`

##### <a name="-bolt--project--owner"></a>`owner`

Data type: `String[1]`

the user that will own the files and run the service

Default value: `$project`

##### <a name="-bolt--project--group"></a>`group`

Data type: `String[1]`

the group for all files

Default value: `$project`

##### <a name="-bolt--project--manage_user"></a>`manage_user`

Data type: `Boolean`

if we should create the user+group or not

Default value: `true`

##### <a name="-bolt--project--environment"></a>`environment`

Data type: `String[1]`

the desired code environment we will use

Default value: `'peadm'`

##### <a name="-bolt--project--modulepaths"></a>`modulepaths`

Data type: `Array[Stdlib::Absolutepath]`

an array of directories where code lives

Default value: `["/etc/puppetlabs/code/environments/${environment}/modules", "/etc/puppetlabs/code/environments/${environment}/site", "/etc/puppetlabs/puppetserver/code/environments/${environment}/site/", "/etc/puppetlabs/puppetserver/code/environments/${environment}/modules/", '/opt/puppetlabs/puppet/modules']`

##### <a name="-bolt--project--local_transport_tmpdir"></a>`local_transport_tmpdir`

Data type: `Optional[Stdlib::Absolutepath]`

the bolt tmpdir for all local transports

Default value: `undef`

##### <a name="-bolt--project--puppetdb_urls"></a>`puppetdb_urls`

Data type: `Array[Stdlib::HTTPUrl]`

URIs for PuppetDB, usually the localhost http listener

Default value: `['http://127.0.0.1:8080']`

