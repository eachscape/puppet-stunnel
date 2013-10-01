require 'spec_helper'

describe 'stunnel::tunnel' do
  let(:facts) do
    {
      :boxen_home => '/test/boxen',
      :concat_basedir => '/test/concat_basedir'
    }
  end
  let(:title) { 'mytunnel' }
  let(:params) { {
    :accept => '8080',
    :connect => 'localhost:443'
  } }

  it { should include_class('stunnel') }

  it 'creates the fragment' do
    should contain_concat__fragment("stunnel_fragment_#{title}").
      with (
        :target => '/test/boxen/config/stunnel/stunnel.conf'
      )
  end
end
