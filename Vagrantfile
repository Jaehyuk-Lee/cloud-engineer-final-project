# Vagrantfile

Vagrant_API_Version ="2"

Vagrant.configure(Vagrant_API_Version) do |config|

  # WAS-server
  config.vm.define:"WAS-01" do |cfg|
    cfg.vm.box = "centos/7"
	  cfg.vm.provider:virtualbox do |vb|
      vb.name="WAS-01"
      vb.customize ["modifyvm", :id, "--cpus",1]
      vb.customize ["modifyvm", :id, "--memory",1024]
    end
    cfg.vm.host_name="WAS-01"
    cfg.vm.synced_folder ".", "/vagrant", disabled: true
    cfg.vm.network "private_network", ip: "192.168.111.21"
    cfg.vm.network "forwarded_port", guest: 22, host: 19211, auto_correct: false, id: "ssh"
    cfg.vm.provision "shell", path: "scripts/bash_ssh_conf_CentOS.sh"
    cfg.vm.provision "file", source: "docker/WAS/", destination: "~/docker"
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
    cfg.vm.network "public_network", ip: "192.168.111.31"
    cfg.vm.network "forwarded_port", guest: 22, host: 19211, auto_correct: false, id: "ssh"
    cfg.vm.network "forwarded_port", guest: 3306, host: 13306, auto_correct: true, id: "mysql"
    cfg.vm.provision "shell", path: "C:/Users/Swordbill/Downloads/f_project/cloud-engineer-final-project/scripts/bash_ssh_conf_CentOS.sh"
    cfg.vm.provision "file", source: "C:/Users/Swordbill/Downloads/f_project/cloud-engineer-final-project/ansible/DB/DB_data/data.sql", destination: "data.sql"
  # end
  # Monitering-Server
  config.vm.define:"MS-01" do |cfg|
    cfg.vm.box = "centos/7"
	  cfg.vm.provider:virtualbox do |vb|
      vb.name="MS-01"
      vb.customize ["modifyvm", :id, "--cpus",2]
      vb.customize ["modifyvm", :id, "--memory",2048]
    end
    cfg.vm.host_name="MS-01"
    cfg.vm.synced_folder ".", "/vagrant", disabled: true
    cfg.vm.network "public_network", ip: "192.168.111.41"
    cfg.vm.network "forwarded_port", guest: 22, host: 19211, auto_correct: false, id: "ssh"
    cfg.vm.network "forwarded_port", guest: 9093, host: 9093
    cfg.vm.network "forwarded_port", guest: 9090, host: 9090
    cfg.vm.provision "shell", path: "/scripts/bash_ssh_conf_CentOS.sh"
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
    cfg.vm.network "forwarded_port", guest: 22, host: 19210, auto_correct: false, id: "ssh"
    # env
    cfg.vm.provision "shell", path: "scripts/bootstrap.sh"
    cfg.vm.provision "file", source: "ansible/env/ready_ansible_env.yaml", destination: "ready_ansible_env.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook ready_ansible_env.yaml"
    cfg.vm.provision "file", source: "C:/Users/Swordbill/Downloads/f_project/cloud-engineer-final-project/ansible/env/auto_known_host.yaml", destination: "auto_known_host.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook auto_known_host.yaml", privileged: false
    cfg.vm.provision "file", source: "C:/Users/Swordbill/Downloads/f_project/cloud-engineer-final-project/ansible/env/auto_authorized_keys.yaml", destination: "auto_authorized_keys.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook auto_authorized_keys.yaml --extra-vars 'ansible_ssh_pass=vagrant'", privileged: false
    # common
    cfg.vm.provision "file", source: "ansible/common/install_docker.yaml", destination: "install_docker.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook install_docker.yaml", privileged: false
    # WAS
    cfg.vm.provision "file", source: "ansible/WAS/run_tomcat_container.yaml", destination: "run_tomcat_co
    #DB-server
    # cfg.vm.provision "file", source: "C:/Users/Swordbill/Downloads/f_project/cloud-engineer-final-project/ansible/DB/maria_db.yaml", destination: "maria_db.yaml"
    # cfg.vm.provision "file", source: "C:/Users/Swordbill/Downloads/f_project/cloud-engineer-final-project/ansible/DB/vars/main.yaml", destination: "main.yaml"
    # cfg.vm.provision "file", source: "C:/Users/Swordbill/Downloads/f_project/cloud-engineer-final-project/ansible/DB/tasks/install.yaml", destination: "install.yaml"
    # cfg.vm.provision "file", source: "C:/Users/Swordbill/Downloads/f_project/cloud-engineer-final-project/ansible/DB/templates/my.cnf.j2", destination: "my.cnf"
    # cfg.vm.provision "file", source: "C:/Users/Swordbill/Downloads/f_project/cloud-engineer-final-project/ansible/DB/DB_data/data.sql", destination: "data.sql"
    # cfg.vm.provision "shell", inline: "ansible-playbook maria_db.yaml", privileged: falsentainer.yaml"
    cfg.vm.provision "shell", inline: "ansible-playbook run_tomcat_container.yaml", privileged: false
  end
end
