# frozen_string_literal: true

require 'spec_helper'

describe 'bolt::project' do
  let(:title) { 'peadm' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      context 'on FOSS' do
        let :facts do
          os_facts
        end

        it { is_expected.to compile.and_raise_error(%r{pe_status_check_role fact is missing from module puppetlabs/pe_status_check}) }
      end

      context 'on PE' do
        let :facts do
          os_facts.merge({ pe_status_check_role: 'primary', sudoversion: '1.9.5p2' })
        end

        context 'with defaults' do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('bolt') }
          it { is_expected.to contain_file('/opt/peadm/bolt-project.yaml').with_ensure('file') }
          it { is_expected.to contain_file('/opt/peadm/inventory.yaml').with_ensure('file').without_content(%r{tmpdir}) }
          it { is_expected.to contain_file('/opt/peadm').with_ensure('directory') }
          it { is_expected.to contain_user(title) }
          it { is_expected.to contain_group(title) }
          it { is_expected.to contain_package('puppet-bolt') }
          it { is_expected.not_to contain_yumrepo('puppet-tools') }
          it { is_expected.to contain_sudo__conf(title) }
          it { is_expected.to contain_systemd__unit_file("#{title}@.service") }

          if os_facts['os']['family'] == 'RedHat'
            it { is_expected.to contain_package('puppet-tools-release') }
            it { is_expected.not_to contain_apt__source('puppet-tools-release') }
          else
            it { is_expected.not_to contain_package('puppet-tools-release') }
            it { is_expected.to contain_apt__source('puppet-tools-release') }
          end
        end

        context 'with manage_user=false on PE' do
          let :params do
            { manage_user: false }
          end

          it { is_expected.not_to contain_user(title) }
          it { is_expected.not_to contain_group(title) }
        end

        context 'with local_transport_tmpdir' do
          let :params do
            { local_transport_tmpdir: '/foooo' }
          end

          it { is_expected.to contain_file('/opt/peadm/inventory.yaml').with_ensure('file').with_content(%r{tmpdir: "/foooo"}) }
        end
      end
    end
  end
end
