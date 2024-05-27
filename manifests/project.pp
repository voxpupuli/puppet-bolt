#
# @summary creates required files for a bolt project. Will create one oneshot service for each plan
#
# @param basepath rootdir where the project will be created into
# @param project the name of the project
# @param owner the user that will own the files and run the service
# @param group the group for all files
# @param manage_user if we should create the user+group or not
# @param plans a list of all plans we want to run
# @param environment the desired code environment we will use
# @param modulepaths an array of directories where code lives
#
# @example create one project and provide plan parameters
#   bolt::project { 'peadmmig': }
#   -> file { '/opt/peadmmig/profiles::convert.json':
#     owner   => 'peadmmig',
#     group   => 'peadmmig',
#     content => { 'primary_host' => $facts['networking']['fqdn'] }.stdlib::to_json_pretty,
#   }
#
# @author Tim Meusel <tim@bastelfreak.de>
#
define bolt::project (
  Stdlib::Absolutepath $basepath = '/opt/',
  String[1] $project = $name,
  String[1] $owner = $project,
  String[1] $group = $project,
  Boolean $manage_user = true,
  Array[String[1]] $plans = [],
  String[1] $environment = 'peadm',
  Array[Stdlib::Absolutepath] $modulepaths = ["/etc/puppetlabs/code/environments/${environment}/modules", "/etc/puppetlabs/code/environments/${environment}/site",],
) {
  unless $facts['pe_status_check_role'] in ['primary', 'legacy_primary', 'pe_compiler', 'legacy_compiler'] {
    fail("bolt::project works only on PE primaries and compilers, not: ${facts['pe_status_check_role']}")
  }
  # installs bolt
  require bolt

  # ensure /tmp is mounted with +exec, otherwise we cannot call bolt later on

  $project_path = "${basepath}${name}"
  if $manage_user {
    user { $project:
      ensure         => 'present',
      managehome     => true,
      purge_ssh_keys => true,
      system         => true,
      home           => $project_path,
      gid            => $project,
      groups         => ['pe-puppet'], # required to read codedir
      shell          => '/sbin/nologin',
      comment        => 'user to run bolt plans',
    }
    group { $project:
      ensure => 'present',
      system => true,
    }
  }
  file { $project_path:
    ensure => 'directory',
    owner  => $owner,
    group  => $group,
  }

  $bolt_project = {
    'analytics' => false,
    'name' => $project,
    'modulepath' => $modulepaths,
    'stream' => true,
    'puppetdb' => { 'server_urls' => ['http://127.0.0.1:8080'] },
  }.stdlib::to_yaml({ 'indentation' => 2 })

  file { "${project_path}/bolt-project.yaml":
    ensure  => 'file',
    owner   => $owner,
    group   => $group,
    content => $bolt_project,
  }

  $inventory = {
    'groups' => [
      {
        'name' => 'primary',
        'targets' => [
          {
            'name' => $facts['networking']['fqdn'],
            'uri' => 'local://localhost',
          },
        ]
      }
    ],
  }.stdlib::to_yaml({ indentation => 2 })

  file { "${project_path}/inventory.yaml":
    ensure  => 'file',
    owner   => $owner,
    group   => $group,
    content => $inventory,
  }

  $data = { 'project' => $project, 'user'=> $owner, 'group' => $group, 'project_path' => $project_path, 'environment' => 'peadm' }

  systemd::unit_file { "${project}@.service":
    content => epp("${module_name}/project.service.epp", $data),
  }

  include sudo
  sudo::conf { $owner:
    priority => 10,
    content  => "${owner} ALL=(ALL) NOPASSWD: ALL",
  }
}
