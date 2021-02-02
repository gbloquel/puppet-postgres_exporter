require 'spec_helper_acceptance'

describe 'postgres_exporter class' do
  it 'applies successfully' do
    pp = <<-EOS
    class { '::postgresql::globals':
    version => '10',
    manage_package_repo => true,
    } ->
    class { '::postgresql::server': } ->
    class { 'postgres_exporter': }
    EOS

    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to match(%r{error}i)
    end
  end

  describe 'flags' do
    it 'sets the web.listen-address' do
      pp = <<-EOS
      class { '::postgresql::globals':
      version => '10',
      manage_package_repo => true,
      } ->
      class { '::postgresql::server': } ->
      class { 'postgres_exporter':
        version => '0.7.0',
        flags => {
          'web.listen-address' => ':9999',
        }
      }
      EOS
      apply_manifest(pp, catch_failures: true)
      expect(port(9999)).to be_listening.with('tcp6')
      expect(file('/opt/postgres_exporter_v0.7.0_linux-amd64/postgres_exporter')).to be_file
    end
  end
end
