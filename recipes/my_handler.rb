#
# Cookbook Name:: my_test
# Recipe:: my_handler
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'chef_handler'

cookbook_file "#{node['chef_handler']['handler_path']}/my_handler.rb" do
  source 'my_handler.rb'
  owner 'root'
  group 'root'
  mode '0644'
end

chef_handler 'Chef::Handler::MyHandler' do
  source "#{node['chef_handler']['handler_path']}/my_handler.rb"
  arguments var1: 'blah' # TODO: Insert your email here
  action :enable
end