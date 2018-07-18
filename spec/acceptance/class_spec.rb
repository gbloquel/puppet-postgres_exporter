require 'spec_helper_acceptance'

describe 'postgres_exporter class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { '::postgresql::globals': 
        version => '10',
        manage_package_repo => true,
      } ->
      class { '::postgresql::server': } ->  
      class { 'postgres_exporter': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe service('postgres_exporter') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(9187) do
      it { is_expected.to be_listening.with('tcp6') }
    end
  end
end