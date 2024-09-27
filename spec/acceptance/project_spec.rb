# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'bolt::project' do
  describe 'with defaults' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
        # on PE, this group is provided by PE itself
        group { 'pe-puppet': }
        bolt::project { 'peadmmig': }
        PUPPET
      end
    end
    describe package('puppet-bolt') do
      it { is_expected.to be_installed }
    end

    describe 'file' do
      it { expect(file('/opt/peadmmig/inventory.yaml')).to be_file }
      it { expect(file('/opt/peadmmig/bolt-project.yaml')).to be_file }
      it { expect(file('/etc/systemd/system/peadmmig@.service')).to be_file }
      it { expect(file('/etc/sudoers.d/10_peadmmig')).to be_file }
    end
  end
end
