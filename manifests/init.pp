# == Class: icinga2
#
# This module installs and configures Icinga 2 monitoring system.
#
# You can enable/disable certain parts of the module via parameters.
#
# Icinga 2 can server different roles like server, satellite or agent. Which
# are only differnt in how you configure the daemon.
#
# Please see the README for details on how to use this module.
#
class icinga2 (
  $default_features             = true,
  $db_type                      = $::icinga2::params::db_type,
  $db_host                      = 'localhost',
  $db_port                      = undef,
  $db_name                      = $::icinga2::params::db_name,
  $db_user                      = $::icinga2::params::db_user,
  $db_pass                      = $::icinga2::params::db_pass,
  $db_schema                    = undef,
  $manage_database              = false,
  $manage_repos                 = $icinga2::params::manage_repos,
  $manage_service               = $icinga2::params::manage_service,
  $use_debmon_repo              = $icinga2::params::use_debmon_repo,
  $package_provider             = $icinga2::params::package_provider,
  $icinga2_package              = $icinga2::params::icinga2_package,
  $install_nagios_plugins       = $icinga2::params::install_nagios_plugins,
  $install_mail_utils_package   = $icinga2::params::install_mail_utils_package,
  $purge_configs                = true,
  $purge_confd                  = false,
) inherits icinga2::params {

  # TODO: temporary parameter until we provide some default templates
  validate_bool($purge_confd)
  if $purge_confd {
    warning('icinga2::purge_confd is a temporary parameter and will be removed again!')
  }

  validate_bool($manage_database)
  validate_bool($manage_service)
  validate_bool($manage_repos)
  validate_bool($use_debmon_repo)
  validate_string($package_provider)
  validate_string($icinga2_package)
  validate_bool($install_nagios_plugins)

  anchor {'icinga2::start':} ->
  class {'::icinga2::install':} ~>
  class {'::icinga2::config':} ~>
  class {'::icinga2::features': } ~>
  anchor {'icinga2::end':}

  if $manage_service == true {
    Class['icinga2::config'] ~>
    class {'::icinga2::service':} ->
    Anchor['icinga2::end']
  }

  if $manage_database == true {
    Class['icinga2::features'] ->
    class {'::icinga2::database':
    } -> Anchor['icinga2::end']

    if $manage_service {
      Class['icinga2::database'] ~> Class['icinga2::service']
    }
  }

}
