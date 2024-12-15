#
# @summary installs bolt via yumrepo or release package
#
# @param version desired version for bolt or `absent`
# @param base_url HTTPS URL to the yumrepo base
# @param release_package filename for the release package rpm
# @param gpgkey name of the GPG key filename in the repo
# @param use_release_package enable/disable the puppet-tools-release package installation. When disabled, we will configure the repo as yumrepo resource
# @param yumrepo_base_url configure the full repo URL, useful when you don't exactly mirror yum.puppet.com
# @param manage_repo when true, a repo will be added to install bolt. Useful when you manage repos externally. See also $use_release_package
#
# @example install bolt via puppet-tools-release rpm
#   include bolt
#
# @example install bolt via puppet-tools-release which is on a mirror
#   class { 'bolt':
#     base_url => 'https://mirror.corp.internal',
#   }
#
# @example manage the yumrepo directly
#   class { 'bolt':
#     use_release_package => false,
#   }
#
# @example manage the yumrepo with an internal mirror with odd directory layout
#   class { 'bolt':
#     base_url         => 'https://internal.mirror.corp/keys/',
#     yumrepo_base_url => 'https://internal.mirror.corp/puppet/puppet_tools/rhel8/',
#   }
#
# @author Tim Meusel <tim@bastelfreak.de>
#
class bolt (
  String[1] $version = 'installed',
  Stdlib::HTTPSUrl $base_url = $facts['os']['family'] ? { 'Debian' => 'https://apt.puppet.com/', 'RedHat' => 'https://yum.puppet.com/', },
  String[1] $release_package = $facts['os']['family'] ? { 'Debian' => "puppet-release-${fact('os.distro.codename')}.deb", 'RedHat' => "puppet-tools-release-el-${facts['os']['release']['major']}.noarch.rpm", },
  String[1] $gpgkey = $facts['os']['family'] ? { 'Debian' => 'DEB-GPG-KEY-puppet-20250406', 'RedHat' => 'RPM-GPG-KEY-puppet-20250406', },
  Boolean $use_release_package = $facts['os']['family'] ? { 'Debian' => false, 'RedHat' => true, },
  Stdlib::HTTPSUrl $yumrepo_base_url = "${base_url}puppet-tools/el/${facts['os']['release']['major']}/\$basearch",
  Boolean $manage_repo = true,
) {
  unless $facts['os']['family'] in ['RedHat', 'Debian'] {
    fail("class bolt only works on ${facts['os']['family']} OS family")
  }

  $ensure = $version ? {
    'absent' => 'absent',
    default  => 'present',
  }
  if $manage_repo {
    if $use_release_package {
      package { 'puppet-tools-release':
        ensure => $ensure,
        source => "${base_url}${release_package}",
      }
      $require = Package['puppet-tools-release']
    } else {
      if $facts['os']['family'] == 'RedHat' {
        yumrepo { 'puppet-tools':
          ensure   => $ensure,
          baseurl  => $yumrepo_base_url,
          descr    => "Puppet Tools Repository el ${facts['os']['release']['major']} - \$basearch",
          enabled  => '1',
          gpgcheck => '1',
          gpgkey   => "${base_url}${gpgkey}",
        }
        $require = Yumrepo['puppet-tools']
      } else {
        apt::source { 'puppet-tools-release':
          location => $base_url,
          repos    => 'puppet-tools',
          before   => Package['puppet-bolt'],
        }
        # the update class, according to puppetlabs/apt, needs to be called before the package resource
        # https://github.com/puppetlabs/puppetlabs-apt?tab=readme-ov-file#adding-new-sources-or-ppas
        $require = [Class['apt::update'], Apt::Source['puppet-tools-release']]
      }
    }
  } else {
    $require = undef
  }

  package { 'puppet-bolt':
    ensure  => $version,
    require => $require,
  }
}
