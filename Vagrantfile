# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    box_url = "http://ppcmoddev2:9028/js/squeeze_x64.box"

    mongos_external_port = ENV[ "MONGODB_EXTERNAL_PORT" ]
    testMDB1ip = ENV[ "MONGODB_VM_IP" ]

    hostsfile_attrs = [
        {
            "ip" => testMDB1ip,
            "host" => "testMDB1"
        }
    ]

    config.vm.define "mongo" do |config|

        config.vm.box = "debian6"
        config.vm.hostname = "testMDB1"
        config.vm.box_url = box_url

        config.vm.network "private_network", ip: testMDB1ip
        config.vm.network "forwarded_port", guest: 27017, host: mongos_external_port

        config.vm.provision :chef_solo do |chef|

            chef.cookbooks_path = "cookbooks"
            chef.data_bags_path = "data_bags"
            chef.roles_path = "roles"

            chef.node_name = config.vm.hostname

            chef.add_role "mongodb"
            chef.add_recipe "mongodb::default"

            chef.json = {
                "hostsfile-attrs" => hostsfile_attrs
            }
        end

        config.vm.provision :shell, inline: "/vagrant/create_unsharded_collections.sh"
    end

end
