#
# Cookbook Name:: devbox
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
group 'dev' do
  gid 500
  members ['vagrant']
end

include_recipe 'java'

# cookbook_file '/tmp/idea.tar.gz' do
#   source 'ideaIU-2016.1.1.tar.gz'
#   owner 'root'
#   group 'root'
#   mode '0555'
#   action :create
# end

remote_file '/tmp/chrome.deb' do
  source 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
  owner 'root'
  group 'root'
  mode '0555'
  action :create
end

# ark 'intellij' do
#   url 'file:///tmp/idea.tar.gz'
#   owner 'vagrant'
# end

package 'git'
package 'jq'

execute 'install desktop-base' do
  command 'aptitude -q --without-recommends -o APT::Install-Recommends=no -y install ~t^desktop$ ~t^cinnamon-desktop$'
  only_if { Mixlib::ShellOut.new("aptitude search desktop-base | grep -E '^i' |wc -l").run_command.stdout.to_i == 0 }
end

package 'lightdm'
package 'shutter'
package 'cinnamon'

include_recipe 'maven'
include_recipe 'et_gradle'

directory '/home/vagrant/.chef' do
  owner 'vagrant'
  group 'vagrant'
end

basedir = '/home/vagrant'

['.ssh/id_rsa', '.ssh/config', '.chef/knife.rb', '.chef/chef.pem', '.chef/chef-validator.pem', '.chef/charms.pem'].each do |copyfile|
  remote_file "#{basedir}/#{copyfile}" do
    source "file://#{basedir}/hosthome/#{copyfile}"
    action :create_if_missing
    only_if { File.exist?("#{basedir}/hosthome/#{copyfile}") }
  end

end
