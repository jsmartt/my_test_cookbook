require 'spec_helper'

describe 'my_test::default' do
  describe service('httpd') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/var/www/my_site') do
    it { should be_directory }
    it { should be_mode 755 }
  end

  describe file('/etc/httpd/conf.d/my_site.conf') do
    it { should be_mode 644 }
  end

  describe file('/var/www/my_site/index.html') do
    it { should be_mode 755 }
  end

  describe port(80) do
    it { should be_listening }
  end
end
