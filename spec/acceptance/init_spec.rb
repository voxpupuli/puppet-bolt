# frozen_string_literal: true

require 'spec_helper_acceptance'
RSpec::Matchers.define_negated_matcher :be_missing, :be_file
describe 'bolt' do
  describe 'with use_release_package=false' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        class { 'bolt': use_release_package => false }
        PUPPET
      end
    end

    describe 'packages' do
      it { expect(package('puppet-bolt')).to be_installed }
      it { expect(package('puppet-tools-release')).not_to be_installed }
    end
  end

  describe 'with use_release_package=false & ensure=absent' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        class { 'bolt':
          use_release_package => false,
          version => 'absent',
        }
        PUPPET
      end
    end

    describe 'packages' do
      it { expect(package('puppet-bolt')).not_to be_installed }
      it { expect(package('puppet-tools-release')).not_to be_installed }
    end

    # puppet 7 and below remove repos from the file, puppet 8 deletes the file
    describe 'file' do
      it { expect(file('/etc/yum.repos.d/puppet-tools.repo')).to be_missing.or(have_attributes(size: 0)) }
    end
  end

  describe 'with defaults' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        include bolt
        PUPPET
      end
    end

    describe 'packages' do
      it { expect(package('puppet-bolt')).to be_installed }
    end
  end

  describe 'with ensure=absent' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        class { 'bolt':
          version => 'absent',
        }
        PUPPET
      end
    end
    describe 'packages' do
      it { expect(package('puppet-bolt')).not_to be_installed }
      it { expect(package('puppet-tools-release')).not_to be_installed }
    end

    describe 'yum file', if: fact('os.family') == 'RedHat' do
      it { expect(file('/etc/yum.repos.d/puppet-tools.repo')).to be_missing.or(have_attributes(size: 0)) }
      it { expect(file('/etc/apt/sources.list.d/puppet-tools-release.list')).to be_missing.or(have_attributes(size: 0)) }
    end

    describe 'apt file', if: fact('os.family') != 'RedHat' do
      it { expect(file('/etc/yum.repos.d/puppet-tools.repo')).to be_missing.or(have_attributes(size: 0)) }
      it { expect(file('/etc/apt/sources.list.d/puppet-tools-release.list')).to be_file }
    end
  end
end
