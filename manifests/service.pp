# This class handles the postgres_exporter service.
#
# @summary This class handles the postgres_exporter service.
#
# @api private
class postgres_exporter::service {

  file {'/etc/systemd/system/postgres_exporter.service':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('postgres_exporter/postgres_exporter.systemd.epp', {
      'bin_dir' => $::postgres_exporter::install::install_dir
    }
    )
  }
  ~>exec { 'systemctl-daemon-reload-postgres_exporter':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
  }
  ->service {'postgres_exporter':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

}
