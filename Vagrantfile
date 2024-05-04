# Vagrantfile

Vagrant_API_Version ="2"

require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
configs        = YAML.load_file("#{current_dir}/config.yaml")
vagrant_config = configs["configs"]
web_end = vagrant_config["web"]["web_end"].to_i
was_end = vagrant_config["was"]["was_end"].to_i

unless web_end > 0 && web_end <= 10 && was_end > 0 && was_end <= 10
  abort("web_end값과 was_end 값은 1부터 10 사이의 숫자를 입력해주세요")
end

Vagrant.configure(Vagrant_API_Version) do |config|

  config.vm.define "#{vagrant_config["vm_prefix"]}-haproxy-server" do |cfg|
    cfg.vm.box = "centos/7"
    cfg.vm.provider :virtualbox do |vb|
      vb.name = "#{vagrant_config["vm_prefix"]}-haproxy-server"
      vb.customize ["modifyvm", :id, "--cpus", 1]
      vb.customize ["modifyvm", :id, "--memory", 1024]
    end
    cfg.vm.hostname = "#{vagrant_config["vm_prefix"]}-haproxy-server"
    cfg.vm.synced_folder ".", "/vagrant", disabled: true
    cfg.vm.network "public_network"
    cfg.vm.network "private_network", ip: "#{vagrant_config["ip_band"]}.100"
    cfg.vm.network "forwarded_port", guest: 22, host: 19300, auto_correct: false, id: "ssh"
    cfg.vm.provision "shell", path: "scripts/bash_ssh_conf_CentOS.sh"
  end

  # web-server
  (1..web_end).each do |i|
    config.vm.define "#{vagrant_config["vm_prefix"]}-web-#{format("%02d", i)}" do |cfg|
      cfg.vm.box = "centos/7"
      cfg.vm.provider :virtualbox do |vb|
        vb.name = "#{vagrant_config["vm_prefix"]}-web-#{format("%02d", i)}"
        vb.customize ["modifyvm", :id, "--cpus", 1]
        vb.customize ["modifyvm", :id, "--memory", 1024]
      end
      cfg.vm.hostname = "#{vagrant_config["vm_prefix"]}-web-#{format("%02d", i)}"
      cfg.vm.synced_folder ".", "/vagrant", disabled: true
      cfg.vm.network "private_network", ip: "#{vagrant_config["ip_band"]}.#{i+10}"
      cfg.vm.network "forwarded_port", guest: 22, host: 19210 + i, auto_correct: false, id: "ssh"
      cfg.vm.provision "shell", path: "scripts/bash_ssh_conf_CentOS.sh"
    end
  end

  # WAS-server
  (1..was_end).each do |i|
    config.vm.define:"#{vagrant_config["vm_prefix"]}-WAS-#{format("%02d", i)}" do |cfg|
      cfg.vm.box = "centos/7"
      cfg.vm.provider:virtualbox do |vb|
        vb.name="#{vagrant_config["vm_prefix"]}-WAS-#{format("%02d", i)}"
        vb.customize ["modifyvm", :id, "--cpus",1]
        vb.customize ["modifyvm", :id, "--memory",1024]
      end
      cfg.vm.host_name="#{vagrant_config["vm_prefix"]}-WAS-#{format("%02d", i)}"
      cfg.vm.synced_folder ".", "/vagrant", disabled: true
      cfg.vm.network "private_network", ip: "#{vagrant_config["ip_band"]}.#{i+20}"
      cfg.vm.network "forwarded_port", guest: 22, host: 19220 + i, auto_correct: false, id: "ssh"
      cfg.vm.provision "shell", path: "scripts/bash_ssh_conf_CentOS.sh"
    end
  end

  # DB-server
  config.vm.define:"#{vagrant_config["vm_prefix"]}-DB-01" do |cfg|
    cfg.vm.box = "centos/7"
    cfg.vm.provider:virtualbox do |vb|
      vb.name="#{vagrant_config["vm_prefix"]}-DB-01"
      vb.customize ["modifyvm", :id, "--cpus",2]
      vb.customize ["modifyvm", :id, "--memory",2048]
    end
    cfg.vm.host_name="#{vagrant_config["vm_prefix"]}-DB-01"
    cfg.vm.synced_folder ".", "/vagrant", disabled: true
    cfg.vm.network "private_network", ip: "#{vagrant_config["ip_band"]}.31"
    cfg.vm.network "forwarded_port", guest: 22, host: 19231, auto_correct: false, id: "ssh"
    cfg.vm.network "forwarded_port", guest: 3306, host: 13306, auto_correct: false, id: "mysql"
    cfg.vm.provision "shell", path: "scripts/bash_ssh_conf_CentOS.sh"

    cfg.vm.provision "shell", inline: <<-SHELL
      sudo iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
    SHELL
  end

  # Ansible-Server
  config.vm.define:"#{vagrant_config["vm_prefix"]}-ansible-server" do |cfg|
    cfg.vm.box = "centos/7"
    cfg.vm.provider:virtualbox do |vb|
      vb.name="#{vagrant_config["vm_prefix"]}-Ansible-Server"
    end
    cfg.vm.host_name="#{vagrant_config["vm_prefix"]}-ansible-server"
    cfg.vm.synced_folder ".", "/vagrant", disabled: true
    cfg.vm.network "private_network", ip: "#{vagrant_config["ip_band"]}.2"
    cfg.vm.network "forwarded_port", guest: 22, host: 19202, auto_correct: false, id: "ssh"
    cfg.vm.provision "file", source: "ansible/", destination: "/home/vagrant/ansible"
    # env
    cfg.vm.provision "shell", path: "scripts/bootstrap.sh"
    cfg.vm.provision "shell", path: "scripts/change_number_of_server.sh", args: "#{web_end} #{was_end}", privileged: false
    cfg.vm.provision "shell", path: "scripts/change_ip.sh", args: "#{vagrant_config["ip_band"]}", privileged: false
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
    # DB
    cfg.vm.provision "shell", inline: "ansible-playbook ansible/DB/maria_db.yaml", privileged: false
  end
end
