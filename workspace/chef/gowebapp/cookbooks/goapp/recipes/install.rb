#
# Cookbook Name:: goapp
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

gobin_path = node[:goapp][:gobin]
app_path = node[:goapp][:app_path]
app_user = node[:goapp][:app_user]
app_group = node[:goapp][:app_group]
gitrepo = node[:goapp][:gitrepo]

['git','golang-go'].each do |p|
    package p do
        action :install
    end
end

git "#{app_path}/src" do
    repository gitrepo
    action :sync
end

execute 'build_app' do
    command "go build -o #{app_path}/app app.go"
    cwd "#{app_path}/src"
    creates #{app_path}/app"
    notifies :restart, "service[goapp]", :immediately
end

