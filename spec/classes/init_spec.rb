# frozen_string_literal: true

require 'spec_helper'

describe 'bolt' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts
      end

      context 'with all defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('puppet-bolt') }
        it { is_expected.to contain_package('puppet-tools-release') }
        it { is_expected.not_to contain_yumrepo('puppet-tools') }
      end

      context 'with use_release_package=false' do
        let :params do
          { use_release_package: false }
        end

        it { is_expected.not_to contain_package('puppet-tools-release') }
        it { is_expected.to contain_yumrepo('puppet-tools') }
      end
    end
  end
end
