# Vagrantfile

Vagrant_API_Version ="2"

Vagrant.configure(Vagrant_API_Version) do |config|

  # Web-server
  config.vm.define:"web-01" do |cfg|
    cfg.vm.box = "centos/7"
    cfg.vm.provider:virtualbox do |vb|
      vb.name="web-01"
      vb.customize ["modifyvm", :id, "--cpus",1]
      vb.customize ["modifyvm", :id, "--memory",1024]
    end
    cfg.vm.host_name="web-01.mma.com"
    cfg.vm.synced_folder ".", "/vagrant", disabled: true
    cfg.vm.network "private_network", ip: "192.168.111.11"
    cfg.vm.network "forwarded_port", guest: 22, host: 19211, auto_correct: false, id: "ssh"
    cfg.vm.provision "shell", path: "Scripts/bash_ssh_conf_CentOS.sh"
  end

  # # WAS-server
  # config.vm.define:"WAS-01" do |cfg|
  #   cfg.vm.box = "centos/7"
	#   cfg.vm.provider:virtualbox do |vb|
  #     vb.name="WAS-01"
  #     vb.customize ["modifyvm", :id, "--cpus",1]
  #     vb.customize ["modifyvm", :id, "--memory",1024]
  #   end
  #   cfg.vm.host_name="WAS-01"
  #   cfg.vm.synced_folder ".", "/vagrant", disabled: true
  #   cfg.vm.network "public_network", ip: "192.168.111.21"
  #   cfg.vm.network "forwarded_port", guest: 22, host: 19211, auto_correct: false, id: "ssh"
  #   cfg.vm.provision "shell", path: "scripts/bash_ssh_conf_CentOS.sh"
  # end

  # Ansible-Server
  config.vm.define:"ansible-server" do |cfg|
    cfg.vm.box = "centos/7"
    cfg.vm.provider:virtualbox do |vb|
      vb.name="Ansible-Server"
    end
    cfg.vm.host_name="ansible-server"
    cfg.vm.synced_folder ".", "/vagrant", disabled: true
    cfg.vm.network "private_network", ip: "192.168.111.2"
    cfg.vm.network "forwarded_port", guest: 22, host: 19210, auto_correct: false, id: "ssh"
    # env
    cfg.vm.provision "shell", path: "scripts/bootstrap.sh" 
    cfg.vm.provision "file", source: "ansible/env/ready_ansible_env.yaml", destination: "ready_ansible_env.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook ready_ansible_env.yaml"
    cfg.vm.provision "file", source: "ansible/env/auto_known_host.yaml", destination: "auto_known_host.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook auto_known_host.yaml", privileged: false
    cfg.vm.provision "file", source: "ansible/env/auto_authorized_keys.yaml", destination: "auto_authorized_keys.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook auto_authorized_keys.yaml --extra-vars 'ansible_ssh_pass=vagrant'", privileged: false
    # common
    cfg.vm.provision "file", source: "ansible/common/install_docker.yaml", destination: "install_docker.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook install_docker.yaml", privileged: false
    # web
    cfg.vm.provision "file", source: "ansible/web/install_web_nginx.yaml", destination: "install_web_nginx.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook install_web_nginx.yaml", privileged: false
    cfg.vm.provision "file", source: "ansible/web/install_docker_nginx.yaml", destination: "install_docker_nginx.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook install_docker_nginx.yaml", privileged: false
    cfg.vm.provision "file", source: "ansible/web/install_https_web.yaml", destination: "install_https_web.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook install_https_web.yaml", privileged: false
    # WAS
    # cfg.vm.provision "file", source: "ansible/WAS/run_tomcat_container.yaml", destination: "run_tomcat_container.yaml"
    # cfg.vm.provision "shell", inline: "ansible-playbook run_tomcat_container.yaml", privileged: false
  end
end
