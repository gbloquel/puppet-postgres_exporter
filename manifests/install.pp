# This class handles postgres_exporter package.
#
# @summary install postgres_exporter
#
# @api private
class postgres_exporter::install {

  include ::archive

  if $postgres_exporter::manage_user {
    ensure_resource('user', [$::postgres_exporter::postgres_exporter_user], {
      ensure => 'present',
      system => true,
    })
  }
  if $postgres_exporter::manage_group {
    ensure_resource('group', [$::postgres_exporter::postgres_exporter_group], {
      ensure => 'present',
      system => true,
    })
    Group[$::postgres_exporter::postgres_exporter_group]->User[$::postgres_exporter::postgres_exporter_user]
  }
  archive { "/tmp/${postgres_exporter::local_archive_name}":
    ensure          => present,
    extract         => true,
    extract_path    => '/opt',
    source          => $postgres_exporter::real_archive_url,
    checksum_verify => false,
    creates         => "${::postgres_exporter::install_dir}/postgres_exporter",
    cleanup         => true,
  }

}
