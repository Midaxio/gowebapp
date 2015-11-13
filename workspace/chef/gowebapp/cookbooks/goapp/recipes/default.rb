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

template "/etc/init/goapp.conf" do
    source "goapp.upstart.conf.erb"
    mode "0644"
end

user app_user do
    action :create
    home app_path
end

ssh_authorize_key "deploy_user" do
    key 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDXOcynwb1RAE/wVp9BQtOudZ5ZVsxAGmEs4/C5HgAWrxeinUyVrjVYd40A3iP/qQzOZ0h9pXdJT/p2dIRlwF8PE+J3OC5N/wgGj5tR3QkCrIsq2+d6bxdoqn1la9bmMXmUDkf2z01M0EnI2/4l4P1mZCgHEMa6RA7/O4LwVpGZjcGqPlg+iNBTCiiLJvgyjDXBWVfFxbrpDVtYQ+b1AxQ/ADVh/5hGFp798yi56GvqdLmgQDt2zwqtg1ITl3UsWiegSnkiKDEKUaLsRhk2nc0woG3KezkPZx0WKeDztjIzftwdR0g69ePM/Hr6qfL/wh1HIj7mbAbJ/HLC/ULF7nsT'
    user app_user
    home app_path
end

sudo "#{app_user}_sudo" do
  user  app_user
  commands  ['/sbin/restart goapp','/sbin/start goapp', '/sbin/stop goapp' ]
  nopasswd true
end

directory app_path do
    action :create
    owner app_user
    group app_group
    recursive true
end



execute 'compile_app' do
    command "GOBIN=#{gobin_path} golang-go install /home/ubuntu/app.go"
    creates "#{gobin_path}/app"
end

service 'goapp' do
    action :start
end
