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

  $real_archive_url = pick(
    $postgres_exporter::archive_url,
    "${postgres_exporter::archive_url_base}/v${postgres_exporter::version}/${postgres_exporter::archive_name}-${postgres_exporter::version}.${postgres_exporter::os}-${postgres_exporter::arch}.tar.gz"
  )
  $local_archive_name = "${postgres_exporter::archive_name}-${postgres_exporter::version}.${postgres_exporter::os}-${postgres_exporter::arch}.tar.gz"
  $install_dir = "/opt/${postgres_exporter::archive_name}-${postgres_exporter::version}.${postgres_exporter::os}-${postgres_exporter::arch}"

  archive { "/tmp/${local_archive_name}":
    ensure          => present,
    extract         => true,
    extract_path    => '/opt',
    source          => $real_archive_url,
    checksum_verify => false,
    creates         => "${install_dir}/postgres_exporter",
    cleanup         => true,
  }

}
