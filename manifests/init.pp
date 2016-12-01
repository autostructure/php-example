# == Class: profile::apache
#
# Full description of class profile here.
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#

#$default_confd_files = hiera('default_confd_files', undef)
#$default_vhost = hiera('default_vhost', undef)
#$apache_name = hiera('apache_name', undef)
#$apache_version = hiera('apache_version', undef)
#$custom_config = hiera('custom_config', {})
#$vhosts = hiera('vhosts', {})
#$docroot = hiera('docroot', undef)
#$php = hiera('php', undef)
#$php_package_name = hiera('php_package_name', undef)
$private_key = hiera('private_key', undef)
$repos = hiera('repos', {})

# Configure ssh private key for repo
if $private_key != undef {
  # ~/.ssh directory
  file { '/root/.ssh':
    ensure => directory,
    mode   => '0700',
    owner  => 'root',
    group  => 'root',
  }

  # SSH private key
  file { '/root/.ssh/id_rsa':
    ensure  => file,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    content => $private_key,
    require => File['/root/.ssh'],
  }

}

# Source code repositories
create_resources(vcsrepo, $repos)

# Instantiate the apache class.
# Check to see if this is a LAMP/LAP server, or just apache (no PHP).

#class { '::apache':
#  default_confd_files => $default_confd_files,
#  default_mods        => $default_mods,
#  default_vhost       => $default_vhost,
#  apache_name         => $apache_name,
#  apache_version      => $apache_version,
#  docroot             => $docroot,
#  mpm_module          => 'prefork',
#}
#class {'::apache::mod::php':
#  package_name  => $php_package_name,
#}
