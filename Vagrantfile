# Vagrantfile

Vagrant_API_Version ="2"

Vagrant.configure(Vagrant_API_Version) do |config|

  config.vm.define "haproxy-server" do |cfg|
    cfg.vm.box = "centos/7"
    cfg.vm.provider :virtualbox do |vb|
      vb.name = "haproxy-server"
      vb.customize ["modifyvm", :id, "--cpus", 1]
      vb.customize ["modifyvm", :id, "--memory", 1024]
    end
    cfg.vm.hostname = "haproxy-server"
    cfg.vm.network "private_network", ip: "192.168.111.100"
    cfg.vm.network "forwarded_port", guest: 22, host: 19300, auto_correct: false, id: "ssh"
    cfg.vm.provision "shell", path: "scripts/bash_ssh_conf_CentOS.sh"
  end

  # web-server
  (1..2).each do |i|
    config.vm.define "web-#{format("%02d", i)}" do |cfg|
      cfg.vm.box = "centos/7"
      cfg.vm.provider :virtualbox do |vb|
        vb.name = "web-#{format("%02d", i)}"
        vb.customize ["modifyvm", :id, "--cpus", 1]
        vb.customize ["modifyvm", :id, "--memory", 1024]
      end
      cfg.vm.hostname = "web-#{format("%02d", i)}"
      cfg.vm.synced_folder ".", "/vagrant", disabled: true
      cfg.vm.network "private_network", ip: "192.168.111.#{i+10}"
      cfg.vm.network "forwarded_port", guest: 22, host: 19210 + i, auto_correct: false, id: "ssh"
      cfg.vm.provision "shell", path: "scripts/bash_ssh_conf_CentOS.sh"
    end
  end

  # WAS-server
  (1..2).each do |i|
    config.vm.define:"WAS-#{format("%02d", i)}" do |cfg|
      cfg.vm.box = "centos/7"
      cfg.vm.provider:virtualbox do |vb|
        vb.name="WAS-#{format("%02d", i)}"
        vb.customize ["modifyvm", :id, "--cpus",1]
        vb.customize ["modifyvm", :id, "--memory",1024]
      end
      cfg.vm.host_name="WAS-#{format("%02d", i)}"
      cfg.vm.synced_folder ".", "/vagrant", disabled: true
      cfg.vm.network "private_network", ip: "192.168.111.#{i+20}"
      cfg.vm.network "forwarded_port", guest: 22, host: 19221 + i, auto_correct: false, id: "ssh"
      cfg.vm.provision "shell", path: "scripts/bash_ssh_conf_CentOS.sh"
    end
  end

  # DB-server
  config.vm.define:"DB-01" do |cfg|
    cfg.vm.box = "centos/7"
	  cfg.vm.provider:virtualbox do |vb|
      vb.name="DB-01"
      vb.customize ["modifyvm", :id, "--cpus",2]
      vb.customize ["modifyvm", :id, "--memory",2048]
    end
    cfg.vm.host_name="DB-01"
    cfg.vm.synced_folder ".", "/vagrant", disabled: true
    cfg.vm.network "private_network", ip: "192.168.111.31"
    cfg.vm.network "forwarded_port", guest: 22, host: 19231, auto_correct: false, id: "ssh"
    cfg.vm.network "forwarded_port", guest: 3306, host: 13306, auto_correct: false, id: "mysql"
    cfg.vm.provision "shell", path: "scripts/bash_ssh_conf_CentOS.sh"
    cfg.vm.provision "file", source: "ansible/DB/DB_data/data.sql", destination: "data.sql"

    cfg.vm.provision "shell", inline: <<-SHELL
      sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
    SHELL
  end

  # Ansible-Server
  config.vm.define:"ansible-server" do |cfg|
    cfg.vm.box = "centos/7"
    cfg.vm.provider:virtualbox do |vb|
      vb.name="Ansible-Server"
    end
    cfg.vm.host_name="ansible-server"
    cfg.vm.synced_folder ".", "/vagrant", disabled: true
    cfg.vm.network "private_network", ip: "192.168.111.2"
    cfg.vm.network "forwarded_port", guest: 22, host: 19202, auto_correct: false, id: "ssh"
    cfg.vm.provision "file", source: "ansible/", destination: "~/ansible"
    # env
    cfg.vm.provision "shell", path: "scripts/bootstrap.sh"
    cfg.vm.provision "shell", inline: "ansible-playbook ansible/env/update_inventory_hosts.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook ansible/env/auto_known_host.yaml", privileged: false
    cfg.vm.provision "shell", inline: "ansible-playbook ansible/env/auto_authorized_keys.yaml --extra-vars 'ansible_ssh_pass=vagrant'", privileged: false
    # common
    cfg.vm.provision "shell", inline: "ansible-playbook ansible/common/install_docker.yaml", privileged: false
    # web
    cfg.vm.provision "shell", inline: "ansible-playbook ansible/web/install_docker_nginx.yaml", privileged: false
    cfg.vm.provision "shell", inline: "ansible-playbook ansible/web/install_haproxy.yaml", privileged: false
    # WAS
    cfg.vm.provision "shell", inline: "ansible-playbook ansible/WAS/run_nodejs_container.yaml", privileged: false
    # DB-server
    cfg.vm.provision "shell", inline: "ansible-playbook ansible/DB/maria_db.yaml", privileged: false
  end
end
