require 'spec_helper'

describe 'stunnel::config' do
  let(:facts) do
    {
      :boxen_home => '/test/boxen',
      :concat_basedir => '/test/concat_basedir'
    }
  end

  it do
    should include_class('boxen::config')
  end
end
