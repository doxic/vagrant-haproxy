# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"

  config.vm.provider :virtualbox do |v|
    v.memory = 512
    v.cpus = 1
    v.linked_clone = true
  end

  # Disable the new default behavior introduced in Vagrant 1.7, to
  # ensure that all Vagrant machines will use the same SSH key pair.
  # See https://github.com/hashicorp/vagrant/issues/5005
  config.ssh.insert_key = false

  boxes = [
    { :name => "lb1", :ip => "10.0.0.10" },
    { :name => "lb2", :ip => "10.0.0.20" },
    { :name => "web1", :ip => "10.0.100.10" },
    { :name => "web2", :ip => "10.0.100.20" },
    { :name => "mon1", :ip => "10.0.200.10" }

  ]

  ansible_groups = {
  "lb" => [
    "lb1","lb2"
  ],
  "web" => [
    "web1","web2"
  ],
  "prometheus" => [
    "mon1"
  ],
  "grafana" => [
    "mon1"
  ]
}

  # Provision each of the VMs.
  boxes.each_with_index do |opts, index|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]
      config.vm.network :private_network, ip: opts[:ip]
      # Autodetect internal network addresses and autoconfigure hosts
      config.vm.provision :hosts, :sync_hosts => true

      # Provision all the VMs in parallel using Ansible after last VM is up.
      if index == boxes.size-1
        config.vm.provision "ansible" do |ansible|
          ansible.compatibility_mode = "2.0"
          ansible.playbook = "provision.yml"
          ansible.limit = "all"
          ansible.become = true
          ansible.groups = ansible_groups
        end
      end
    end
  end

end
