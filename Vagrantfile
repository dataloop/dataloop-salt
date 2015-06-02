Vagrant.configure("2") do |c|
  # c.berkshelf.enabled = true if Vagrant.has_plugin?("vagrant-berkshelf")
  # c.berkshelf.berksfile_path = "Berksfile"

  c.vm.define "opscode-centos-6.6" do |cent66|
    cent66.vm.box = "opscode-centos-6.6"
    cent66.vm.hostname = "default-centos-66"
  end

  c.vm.define "opscode-ubuntu-12.04" do |ub1204|
    ub1204.vm.box = "opscode-ubuntu-12.04"
    ub1204.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box"
    ub1204.vm.hostname = "default-ubuntu-1204"
  end

  c.vm.synced_folder ".", "/vagrant", disabled: false

  ## For masterless, mount your salt file root
  c.vm.synced_folder "salt/", "/srv/salt/"

  ## Use all the defaults:
  c.vm.provision :salt do |salt|

    salt.minion_config = "salt/minion"
    salt.run_highstate = true
  end

end
