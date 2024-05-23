# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'bolt' do
  describe 'with defaults' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        include bolt
        PUPPET
      end
    end
  end

  shell('yum clean all --verbose; rm -rf /etc/yum.repos.d/puppet-tools-release.repo; yum erase --assumeyes puppet-bolt puppet-tools-release')
  describe 'with manually managed repo' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        class { 'bolt': use_release_package => false }
        PUPPET
      end
    end
  end
end
