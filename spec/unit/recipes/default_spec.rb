#
# Cookbook Name:: my_test
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'my_test::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_search(:strings, 'id:my_site_string').and_return([{ 'data' => 'Stubbed String' }])
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs httpd package' do
      expect(chef_run).to install_package('httpd')
    end

    it 'deletes the default apache config file' do
      expect(chef_run).to delete_file('/etc/httpd/conf.d/welcome.conf')
    end

    it 'renders our apache config file' do
      expect(chef_run).to render_file('/etc/httpd/conf.d/my_site.conf')
        .with_content('DocumentRoot /var/www/my_site')
    end

    it 'renders our web page content' do
      expect(chef_run).to render_file('/var/www/my_site/index.html').with_content('Works!')
    end

    it 'renders our web page content with search data' do
      expect(chef_run).to render_file('/var/www/my_site/index.html').with_content('Stubbed String')
    end
  end
end
