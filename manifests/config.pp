# This class handles the configuration file.
#
#
# @summary This class handles the configuration file.
#
#
# @api private
class postgres_exporter::config {

  file {$::postgres_exporter::config_file:
    ensure  => file,
    owner   => 'root',
    group   => $::postgres_exporter::postgres_exporter_group,
    mode    => '0640',
    content => epp('postgres_exporter/postgres_exporter.configfile.epp', {
    })
  }
}
