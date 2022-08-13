$linuxCount=ENV.fetch("linuxCount").to_i
$windowsCount=ENV.fetch("windowsCount").to_i

Vagrant.configure("2") do |config|
  (1..$linuxCount).each do |i|
 config.vm.define "linux_box#{i}", autostart: true do |linux_box|
   linux_box.vm.provision "shell", path: ENV['linuxScript'], :args => ENV['linuxIPs']+"#{i}"
   linux_box.vm.box = ENV['linuxBox']
   linux_box.vm.hostname = ENV['linuxVMname']+"#{i}"
   linux_box.vm.network "public_network", bridge: ENV['ExtSwitchName']
   linux_box.vm.provider "hyperv" do |linux_box|
      linux_box.vmname = ENV['linuxVMname']+"#{i}"
      linux_box.cpus = ENV['ExtSwitchName']
      linux_box.memory = ENV['memorySize']
      linux_box.maxmemory = ENV['memorySize']
    end
  end
end

  (1..$windowsCount).each do |i|
 config.vm.define "windows_box#{i}", autostart: true do |windows_box|
  windows_box.vm.provision "shell", path: ENV['windowsScript'], :args => ENV['windowsIPs']+"#{i}"
  windows_box.vm.box = ENV['windowsBox']
  windows_box.vm.provider "hyperv"
  windows_box.vm.synced_folder ".", "/vagrant", disabled: true
  windows_box.vm.hostname = ENV['windowsVMname']+"#{i}"
  windows_box.vm.network "public_network", bridge: ENV['ExtSwitchName']
  windows_box.vm.provider "hyperv" do |windows_box|
     windows_box.vmname = ENV['windowsVMname']+"#{i}"
     windows_box.cpus = ENV['cpuCount']
     windows_box.memory = ENV['memorySize']
     windows_box.maxmemory = ENV['memorySize']
   end
 end
end
end