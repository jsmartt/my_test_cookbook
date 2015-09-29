#
# Cookbook Name:: my_test
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'httpd'

file '/etc/httpd/conf.d/welcome.conf' do
  action :delete
  notifies :restart, 'service[httpd]', :delayed
end

document_root = '/var/www/my_site'
template '/etc/httpd/conf.d/my_site.conf' do
  source 'my_site.config.erb'
  mode '0644'
  variables(
    root: document_root,
    port: node['my_test']['port']
  )
end

directory document_root do
  mode '0755'
  recursive true
end

my_string = search(:strings, 'id:my_site_string').first['data'] rescue 'EMPTY'

template "#{document_root}/index.html" do
  mode '0755'
  source 'index.html.erb'
  notifies :restart, 'service[httpd]', :delayed
  variables(
    my_string: my_string
  )
end

service 'httpd' do
  action [:enable, :start]
end

include_recipe 'ohai'
ohai 'reload_Crontab' do
  plugin 'cron'
  action :nothing
end

cookbook_file '/etc/chef/ohai_plugins/cron.rb' do
  source 'plugins/cron.rb'
  action :create
  owner 'root'
  group 'root'
  mode 0644
  notifies :reload, 'ohai[reload_Crontab]', :immediately
end
