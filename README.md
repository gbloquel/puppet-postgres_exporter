[![Build Status](https://travis-ci.org/gbloquel/puppet-postgres_exporter.svg?branch=master)](https://travis-ci.org/gbloquel/puppet-postgres_exporter)
# postgres_exporter


#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with postgres_exporter](#setup)
    * [What postgres_exporter affects](#what-postgres_exporter-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with postgres_exporter](#beginning-with-postgres_exporter)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

Installs the Prometheus Postgres Exporter.


## Setup

### Beginning with postgres_exporter

To configure a basic default postgres_exporter, declare the postgres_exporter class.
```puppet
class { 'postgres_exporter':
}
```

## Usage
All parameters for the postgres_exporter module are contained within main `postgres_exporter`, so for any function of the module set the options you want. See the main usage below for examples.

**Install and enable postgres_exporter**
```puppet
include postgres_exporter
```

**Configure the datasource**
```puppet
class { 'postgres_exporter':
  datasource => 'postgresql://postgres:password@localhost:5432/?sslmode=disable',
}
```

**Use the flags**
```puppet
class { 'postgres_exporter':
  flags => {
      'web.listen-address' => ':9999',
      'web.telemetry-path' => '/apis',
  },
}
```

**Add custom queries**
```puppet
class { 'postgres_exporter':
  flags => {
      'extend.query-path' => '/opt/postgres_exporter/query.yaml',
  },
}
```

You need provided the file `query.yaml` before. A example of format is available [`queries.yaml`](examples/queries.yaml)

Others parameters can be used see [`postgres_exporter`](https://github.com/wrouesnel/postgres_exporter)



## Limitations

Tested on Centos 7, but should be fine on any Linux that uses Systemd.

## Development

In the Development section, tell other users the ground rules for contributing to your project and how they should submit their work.
