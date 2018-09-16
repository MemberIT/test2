# -*- mode: ruby -*-
# vi: set ft=ruby :

boxes = [
  {
    :name => "epl",
    :eth0 => "10.11.11.10",
    :mem  => "512",
    :cpu  => "1"
  }
]

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/xenial64"

  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]

      config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--name", opts[:name]]
        v.customize ["modifyvm", :id, "--memory", opts[:mem]]
        v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
      end

      config.vm.network :private_network, ip: opts[:eth0]

      config.vm.provision "shell", inline: <<-SHELL
        wget -q https://apt.puppetlabs.com/puppet5-release-xenia`l.deb
        dpkg -i puppet5-release-xenial.deb
        apt-get update
        apt-get upgrade -y
        apt-get install -y rubygems
        gem install --no-rdoc --no-ri r10k
        apt-get install puppet-agent && systemctl stop puppet.service && systemctl stop mcollective.service && \
          systemctl disable puppet.service && systemctl disable mcollective.service
        wget -q https://raw.githubusercontent.com/MemberIT/test2/production/r10k.yaml -O /tmp/r10k.yaml
        r10k deploy -c /tmp/r10k.yaml environment production -p --color -t -v debug
        echo -e "linuxpassword\nlinuxpassword" | passwd vagrant
      SHELL
    
      config.vm.provision "shell", inline: '/bin/bash /etc/puppetlabs/code/environments/production/scripts/puppet_apply.sh'
    end
  end
end
