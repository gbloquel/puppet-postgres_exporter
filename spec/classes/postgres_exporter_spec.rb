require 'spec_helper'

describe 'postgres_exporter' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'postgres_exporter class without any parameters' do
        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('postgres_exporter::params') }
        it { is_expected.to contain_class('postgres_exporter::install').that_comes_before('Class[postgres_exporter::config]') }
        it { is_expected.to contain_class('postgres_exporter::config') }
        it { is_expected.to contain_class('postgres_exporter::service').that_subscribes_to('Class[postgres_exporter::config]') }

        it { is_expected.to contain_user('postgres') }
        it { is_expected.to contain_group('postgres') }
        it do
          is_expected.to contain_archive('/tmp/postgres_exporter_v0.4.6_linux-amd64.tar.gz')
            .with(
              'source'  => 'https://github.com/wrouesnel/postgres_exporter/releases/download/v0.4.6/postgres_exporter_v0.4.6_linux-amd64.tar.gz',
              'creates' => '/opt/postgres_exporter_v0.4.6_linux-amd64/postgres_exporter',
            )
        end
        it do
          is_expected.to contain_file('/etc/sysconfig/postgres_exporter')
            .with(
              'content' => %r{DATA_SOURCE_NAME="user=postgres host=\/var\/run\/postgresql\/ sslmode=disable"},
              'group'   => 'postgres',
            )
        end

        it { is_expected.to contain_service('postgres_exporter') }
      end
      context 'postgres_exporter class with parameters' do
        let(:params) do
          {
            flags: {
              'web.telemetry-path' => '/metrics2',
              'log.level'          => 'debug',
            },
            version: '0.8.0',          
          }
        end

        it do
          is_expected.to contain_file('/etc/sysconfig/postgres_exporter')
            .with(
              'content' => %r{FLAGS="--web.telemetry-path=\/metrics2 --log.level=debug"},
              'group'   => 'postgres',
            )
        end

        it do
          is_expected.to contain_archive('/tmp/postgres_exporter_v0.8.0_linux-amd64.tar.gz')
            .with(
              'source'  => 'https://github.com/wrouesnel/postgres_exporter/releases/download/v0.8.0/postgres_exporter_v0.8.0_linux-amd64.tar.gz',
              'creates' => '/opt/postgres_exporter_v0.8.0_linux-amd64/postgres_exporter',
            )
        end
      end
    end
  end
end
