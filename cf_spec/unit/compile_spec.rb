$: << 'cf_spec'
require 'spec_helper'

describe 'Compile step of the buildpack' do
  context 'on an unsupported stack' do
    it 'displays a helpful error message' do
      app_dir = Dir.mktmpdir
      cache_dir = Dir.mktmpdir

      output = `env CF_STACK='unsupported' ./bin/compile #{app_dir} #{cache_dir} 2>&1`
      expect(output).to include 'not supported by this buildpack'
    end
  end

  context 'when unix *_proxy environment variables are set' do
    let(:home_dir) { Dir.mktmpdir }

    before(:each) do
      `HOME=#{home_dir} ./cf_spec/assets/run_handle_proxy_vars.sh`
    end

    it 'should set the appropriate npm config values' do
      config_settings = File.read(File.join(home_dir, '.npmrc'))
      expect(config_settings).to include('proxy=http://some.insecure.proxy:3128')
      expect(config_settings).to include('https-proxy=http://some.secure.proxy:3128')
    end
  end
end
