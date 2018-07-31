# postgres_exporter
#
# @summary Main class, includes all other classes
#
# @example
#   include postgres_exporter
#
# @version Which version to install
# @manage_user Whether to create the postgres_exporter user. Must be created by other means if set to false
# @manage_group Whether to create the postgres_exporter group. Must be created by other means if set to false
# @postgres_exporter_user whether to create the user. Default is postgres
# @postgres_exporter_group whether to create the group. Default is postgres
# @datasource the url connection to postgres. Default is local "user=postgres host=/var/run/postgresql/ sslmode=disable"
# @config_file the config file to configure the exporter
# @flags the flags can be passed to the command line like web.listen-address, web.telemetry-path,... @see https://github.com/wrouesnel/postgres_exporter for further details.
class postgres_exporter (
  Optional[String] $version = $::postgres_exporter::params::version,
  Optional[Boolean] $manage_user = $::postgres_exporter::params::manage_user,
  Optional[Boolean] $manage_group = $::postgres_exporter::params::manage_group,
  Optional[String] $postgres_exporter_user = $::postgres_exporter::params::postgres_exporter_user,
  Optional[String] $postgres_exporter_group = $::postgres_exporter::params::postgres_exporter_group,
  Optional[String] $datasource = $::postgres_exporter::params::postgres_exporter_datasource,
  Optional[String] $config_file = $::postgres_exporter::params::config_file,
  Optional[Hash[String, String]] $flags = undef,
) inherits postgres_exporter::params {
  class { '::postgres_exporter::install': }
  -> class {'::postgres_exporter::config': }
  ~> class {'::postgres_exporter::service': }
  -> Class['::postgres_exporter']
}
