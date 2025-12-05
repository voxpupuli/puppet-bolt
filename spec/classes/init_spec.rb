# frozen_string_literal: true

require 'spec_helper'

describe 'bolt' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let :facts do
        os_facts
      end

      context 'with all defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('puppet-bolt') }
        it { is_expected.not_to contain_yumrepo('puppet-tools') }

        if os_facts['os']['family'] == 'RedHat'
          it { is_expected.to contain_package('puppet-tools-release') }
          it { is_expected.not_to contain_apt__source('puppet-tools-release') }
        else
          it { is_expected.not_to contain_package('puppet-tools-release') }
          it { is_expected.to contain_apt__source('puppet-tools-release') }
        end
      end

      context 'with use_release_package=false' do
        let :params do
          { use_release_package: false }
        end

        it { is_expected.not_to contain_package('puppet-tools-release') }

        if os_facts['os']['family'] == 'RedHat'
          it { is_expected.to contain_yumrepo('puppet-tools') }
        else
          it { is_expected.to contain_apt__source('puppet-tools-release') }
        end
      end

      context 'with use_release_package=false and odd mirrors', if: os_facts['os']['family'] == 'RedHat' do
        let :params do
          {
            use_release_package: false,
            base_url: 'https://foo.com/',
            yumrepo_base_url: 'https://bar.com/'
          }
        end

        it { is_expected.not_to contain_package('puppet-tools-release') }
        it { is_expected.to contain_yumrepo('puppet-tools').with_baseurl(%r{^https://bar.com}).with_gpgkey('https://foo.com/RPM-GPG-KEY-puppet') }
      end

      context 'with manage_repo=false' do
        let :params do
          { manage_repo: false }
        end

        it { is_expected.not_to contain_package('puppet-tools-release') }
        it { is_expected.not_to contain_yumrepo('puppet-tools') }
        it { is_expected.not_to contain_apt__source('puppet-tools-release') }
      end
    end
  end
end
