# frozen_string_literal: true

require 'spec_helper'

describe 'bolt::project' do
  let(:title) { 'peadm' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      context 'with defaults' do
        context 'on FOSS' do
          let :facts do
            os_facts
          end

          it { is_expected.not_to compile }
        end

        context 'on PE' do
          let :facts do
            os_facts.merge({ pe_status_check_role: 'primary', sudoversion: '1.9.5p2' })
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('bolt') }
          it { is_expected.to contain_file('/opt/peadm/bolt-project.yaml').with_ensure('file') }
          it { is_expected.to contain_file('/opt/peadm/inventory.yaml').with_ensure('file') }
          it { is_expected.to contain_file('/opt/peadm').with_ensure('directory') }
          it { is_expected.to contain_user(title) }
          it { is_expected.to contain_group(title) }
          it { is_expected.to contain_package('puppet-bolt') }
          it { is_expected.to contain_package('puppet-tools-release') }
          it { is_expected.not_to contain_yumrepo('puppet-tools') }
          it { is_expected.to contain_sudo__conf(title) }
          it { is_expected.to contain_systemd__unit_file("#{title}@.service") }
        end
      end

      context 'with manage_user=false on PE' do
        let :facts do
          os_facts.merge({ pe_status_check_role: 'primary', sudoversion: '1.9.5p2' })
        end
        let :params do
          { manage_user: false }
        end

        it { is_expected.not_to contain_user(title) }
        it { is_expected.not_to contain_group(title) }
      end
    end
  end
end
