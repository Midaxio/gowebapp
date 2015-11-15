#
# Cookbook Name:: nginx_proxy
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'apt'
include_recipe "nginx"

template '/etc/nginx/conf.d/upstreams.conf' do
    source 'upstreams.conf.erb'
    owner 'root'
    group 'root'
    mode '0640'
    notifies :reload, "service[nginx]", :delayed
end

template '/etc/nginx/sites-available/gosite' do
    source 'gosite.erb'
    owner 'root'
    group 'root'
    mode '0640'
end

nginx_site 'gosite' do
    enable true
end
