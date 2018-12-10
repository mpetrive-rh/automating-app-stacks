# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
required_plugins = %w( vagrant-libvirt vagrant-registration )
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end

current_dir    = File.dirname(File.expand_path(__FILE__))
inventory_data        = YAML.load_file("#{current_dir}/inventory/node-base.yml")

# https://github.com/projectatomic/adb-vagrant-registration/issues/126
module SubscriptionManagerMonkeyPatches
    def self.subscription_manager_registered?(machine)
      true if machine.communicate.sudo("/usr/sbin/subscription-manager list --consumed --pool-only | grep -E '^[a-f0-9]{32}$'")
    rescue
      false
    end
end
VagrantPlugins::Registration::Plugin.guest_capability 'redhat', 'subscription_manager_registered?' do
    SubscriptionManagerMonkeyPatches
end

hosts = inventory_data['all']['hosts'].keys

Vagrant.configure("2") do |config|
  hosts.each do |node|
    config.vm.define node do |nodeconfig|
      config.vm.box = "centos/7"
      #config.vm.box = "rhel7"

      if Vagrant.has_plugin?('vagrant-registration')
        config.registration.username = ENV["RHSM_USERNAME"]
        config.registration.password =  ENV["RHSM_PASSWORD"]
      end

      config.vm.hostname = node

      nodeconfig.vm.provider :libvirt do |libvirt|
        libvirt.memory = 1024
      end
      # nodeconfig.vm.network :forwarded_port,
      #   guest: 3000,
      #   host: 3001,
      #   host_ip: "192.168.1.100"
    end

    # config.vm.define "mongodb" do |nodeconfig|
    #   config.vm.box = "rhel7"
    #
    #   if Vagrant.has_plugin?('vagrant-registration')
    #     config.registration.username = ENV["RHSM_USERNAME"]
    #     config.registration.password =  ENV["RHSM_PASSWORD"]
    #   end
    #
    #   config.vm.hostname = "mongodb"
    # end
  end
end
