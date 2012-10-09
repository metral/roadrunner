<!---------------------------------------------------------------------------->

# Roadrunner

<!---------------------------------------------------------------------------->

<h3>Description</h3>
Node.js front-end API that supplies an archived collection of performance 
graphs for a VM instantiated using libvirt.

These graphs are generated using RRDTool on statistics aggregated from collectd 
and the libvirt plugin for a specific VM instance that is, or once was, running 
on an OpenStack compute node.

As the OpenStack compute node is the host to the VM's, each node will need
to have collectd, libvirt and an instance of Roadrunner enabled 
to perform the data collection, graph generation and graph hosting.

<!---------------------------------------------------------------------------->

<h3>Installation</h3>
1. Install collectd & enable libvirt plugin:

    `sudo apt-get update && sudo apt-get install collectd -y`  

    `(cat | sudo tee -a /etc/collectd/collectd.conf) << EOF`  
    `LoadPlugin libvirt`  
    `<Plugin libvirt>`  
    `    Connection "qemu:///system"`  
    `    RefreshInterval 60`  
    `    HostnameFormat name`  
    `</Plugin>`  
    `EOF`  

    `sudo service collectd stop ; sudo service collectd start`  

2. Install node.js from source

    `sudo apt-get update && sudo apt-get install build-essential -y`  
    `wget http://nodejs.org/dist/v0.8.11/node-v0.8.11.tar.gz`  
    `tar xzvf node*.tar.gz`  
    `cd node*`  

    `./configure`  
    `make -j 4`  
    `sudo make install`  

3. Install node.js dependencies

    `cd roadrunner`  
    `npm install`

<!---------------------------------------------------------------------------->

<h3>Run & Interact Server</h3>
1. Run server

    `cd roadrunner`  
    `node server.js` 

2. Pull collectd + libvirt graphs via API

    `wget <SERVER_IP>:1337/instances/instance-<INSTANCE_ID>.tar.gz`

<!---------------------------------------------------------------------------->
