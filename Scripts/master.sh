
#Commands for nodes

   # convert user to root user
	 Sudo -i
    #update nsg ports
	#Update NSG for ports
    #update and upgrade to get new updates installed on image
	3- sudo apt-get update
	4- sudo apt-get upgrade
	# Add Docker and docker's official GPG key:
	sudo apt-get update
	sudo apt-get install ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc
	
	# Add the repository to Apt sources:
	echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
	  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
    #install docker packages and pluins
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    #change the acess to docker from user to root user to apply change restart required
	Sudo usermod -aG docker <username>
    #update the image with new changes
	sudo apt-get update
	sudo apt-get install -y apt-transport-https ca-certificates curl gpg
	sudo mkdir -p -m 755 /etc/apt/keyrings
	curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
	echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
    # install kubeadm, kubectl, kubelet
	sudo apt-get install -y kubelet kubeadm kubectl
    #hold the services
	sudo apt-mark hold kubelet kubeadm kubectl
    #enable kubelet
	sudo systemctl enable --now kubelet
    #create the containerd configuration file using the following commands
	sudo mkdir -p /etc/containerd
	sudo containerd config default | sudo tee /etc/containerd/config.toml
    #Edit the containerd configuration file to set SystemdCgroup to true. Use the following command to open the file
	sudo nano /etc/containerd/config.toml
	#SystemdCgroup = true
	sudo systemctl restart containerd
	#kubectl label node node01 node-role.kubernetes.io/worker=worker
	
	#From <https://devopscube.com/setup-kubernetes-cluster-kubeadm/>
