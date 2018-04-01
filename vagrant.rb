Vagrant.configure("2") do |config|
  config.vm.box = "02-win2016-vs"

  config.vm.communicator = "winrm"
  config.vm.guest = "windows"
  config.vm.synced_folder "temp", "C:\\Users\\vagrant\\shared", SharedFoldersEnableSymlinksCreate: false

  config.vm.provision "build",
      type: "shell",
      path: "build-ungoogled-chromium.bat"

  config.vm.provision "download_product",
      type: "shell",
      inline: 'Copy-Item "$home\\ungoogled-chromium\\buildspace\\tree\\ungoogled_packaging\\ungoogled*.zip" $home\\shared'

   config.vm.provider "virtualbox" do |vb|
     vb.memory = 16000
     vb.cpus = 4
   end
end
