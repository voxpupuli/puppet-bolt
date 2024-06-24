# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'bolt' do
  describe 'with manually managed repo' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        class { 'bolt': use_release_package => false }
        PUPPET
      end
    end
    describe package('puppet-bolt') do
      it { is_expected.to be_installed }
    end

    describe package('puppet-tools-release') do
      it { is_expected.not_to be_installed }
    end
  end

  describe command('yum clean all --verbose; rm -rf /etc/yum.repos.d/puppet-tools-release.repo; yum erase --assumeyes puppet-bolt puppet-tools-release') do
    its(:exit_status) { is_expected.to eq 0 }
  end

  describe 'with defaults' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        include bolt
        PUPPET
      end
    end
    # rubocop:disable RSpec/RepeatedExampleGroupBody
    describe package('puppet-bolt') do
      it { is_expected.to be_installed }
    end

    describe package('puppet-tools-release') do
      it { is_expected.to be_installed }
    end
    # rubocop:enable RSpec/RepeatedExampleGroupBody
  end
end
