require 'spec_helper'

describe 'stunnel' do
  let(:facts) do
    {
      :boxen_home => '/test/boxen',
      :concat_basedir => '/test/concat_basedir'
    }
  end

  it do
    should include_class('stunnel::config')
    should include_class('homebrew')

    should contain_file('/Library/LaunchDaemons/dev.stunnel.plist').with({
      :group  => 'wheel',
      :notify => 'Service[dev.stunnel]',
      :owner  => 'root'
    })

    should contain_file('/test/boxen/config/stunnel').with_ensure('directory')
    should contain_file('/test/boxen/data/stunnel').with_ensure('directory')
    should contain_file('/test/boxen/log/stunnel').with_ensure('directory')

    should contain_concat('/test/boxen/config/stunnel/stunnel.conf').
      with_notify('Service[dev.stunnel]')

    should contain_concat__fragment('stunnel_global_config').with_order('01')

    should contain_file('/test/boxen/homebrew/etc/stunnel').with({
      :ensure  => 'absent',
      :force   => true,
      :recurse => true,
      :require => 'Package[stunnel]'
    })

    should contain_homebrew__formula('stunnel').
      with_before('Package[stunnel]')

    should contain_package('stunnel').with({
      :ensure => '4.56',
      :notify => 'Service[dev.stunnel]'
    })

    should contain_service('dev.stunnel').with({
      :ensure  => 'running',
      :require => 'Package[stunnel]',
    })
  end

end
