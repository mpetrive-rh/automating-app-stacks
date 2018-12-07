# -*- mode: ruby -*-
# vi: set ft=ruby :

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


Vagrant.configure("2") do |config|

    config.vm.define "nodejs" do |nodeconfig|
      config.vm.box = "rhel7"

      if Vagrant.has_plugin?('vagrant-registration')
        config.registration.username = ENV["RHSM_USERNAME"]
        config.registration.password =  ENV["RHSM_PASSWORD"]
      end

      config.vm.hostname = "nodejs"

      nodeconfig.vm.network :forwarded_port,
        guest: 3000,
        host: 3001,
        host_ip: "192.168.1.100"
    end

    config.vm.define "mongodb" do |nodeconfig|
      config.vm.box = "rhel7"

      if Vagrant.has_plugin?('vagrant-registration')
        config.registration.username = ENV["RHSM_USERNAME"]
        config.registration.password =  ENV["RHSM_PASSWORD"]
      end

      config.vm.hostname = "mongodb"
    end
end
