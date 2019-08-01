Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.provision "shell", path: "./scripts/provision-testing.sh"
  config.vm.provision "shell", path: "./scripts/django.sh", privileged: false
 # config.vm.network :forwarded_port, host: 8500, guest: 8500
  # config.vm.synced_folder "./", "/vagrant", id: "vagrant-root",
  #   owner: "vagrant",
  #   group: "vagrant",
  #   mount_options: ["dmode=775,fmode=664"]



  config.vm.define "web-counter" do |c1|
    c1.vm.hostname = "consul-server-1"
    c1.vm.network :forwarded_port, host: 8500, guest: 80
    c1.vm.network :forwarded_port, host: 8000, guest: 8000
  end
end