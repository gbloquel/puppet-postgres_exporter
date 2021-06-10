# Params postgres_exporter
#
# @summary params for exporter
#
# @api private
class postgres_exporter::params {
  $version                       = '0.9.0'
  $manage_user                   = true
  $manage_group                  = true
  $archive_url_base              = 'https://github.com/prometheus-community/postgres_exporter/releases/download'
  $archive_name                  = 'postgres_exporter'
  $archive_url                   = undef
  $postgres_exporter_user        = 'postgres'
  $postgres_exporter_group       = 'postgres'
  $postgres_exporter_datasource  = 'user=postgres host=/var/run/postgresql/ sslmode=disable'
  $config_file                   = '/etc/sysconfig/postgres_exporter'

  case $::architecture {
    'x86_64', 'amd64': { $arch = 'amd64' }
    'i386':            { $arch = '386' }
    default: {
      fail("${::architecture} unsuported")
    }
  }
  case $::kernel {
    'Linux': { $os = downcase($::kernel)}
    default: {
      fail("${::kernel} not supported")
    }
  }

}
