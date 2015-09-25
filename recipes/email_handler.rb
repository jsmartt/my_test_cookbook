#
# Cookbook Name:: my_test
# Recipe:: email_handler
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'sendmail'

chef_gem 'chef-handler-mail'
require 'chef/handler/mail'

chef_handler 'MailHandler' do
  source 'chef/handler/mail'
  supports exception: true
  arguments to_address: 'root' # TODO: Insert your email here
  action :enable
end
