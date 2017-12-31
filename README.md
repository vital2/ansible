# Anisble Playbooks for Vital 

These playbooks are used to automate the configuration of VM's for Network Security and Computer Networks Lab on Vital at NYU.
All the VM's are configured using Ubuntu 16.04.03 LTS Server as base image.

## Modules Used
We have used several modules in ansible for the creation of these playbooks.

### Pkg Module
It is used for the installation of the packages in all the VM's.
  
 ```yaml
name: Install Packaged
apt:
    name: apache-httpd:
    state: present
 ``` 
### Copy Module
It is used for copying the exiting configuration files to the configured VM.

```yaml
name: Copy Files
copy:
    src: /path/to/files/on/local/machine
    dest: /path/to/copy/files/on destionation
```

### Shell Module
Some packages comes with TUI (Textbase User Interface) and we need to provide some information to them manually. 
`apt` modules can't handle the installation of these modules.
In order to use the default options and skip the TUI we need to used an Environment Variable called `DEBIAN_FRONTEND=noninteractive` to proceed. 
The Shell modules gives us the accessiblity to use the Shell to run any shell command.

```yaml
name: Run some shell commands
shell: DEBIAN_FRONTEND=noninteractive apt-get install -y <pkg>
```

# How to run the playbooks

There are 8 playbooks in total, 4 for Net-Sec and 4 for Computer-Networks.
```bash
├── Computer-Networks                               
│   ├── CN_R1                                       
│   │   ├── ansible.cfg                             
│   │   ├── configuration-files                     
│   │   ├── hosts                                   
│   │   ├── lightdm                                 
│   │   │   └── lightdm.conf                        
│   │   └── playbook.yml                            
│   ├── CN_R2                                       
│   │   ├── ansible.cfg                             
│   │   ├── configuration-files                     
│   │   ├── hosts                                   
│   │   ├── lightdm                                 
│   │   │   └── lightdm.conf                        
│   │   └── playbook.yml                            
│   ├── CN_R3                                       
│   │   ├── ansible.cfg                             
│   │   ├── configuration-files                     
│   │   ├── hosts                                   
│   │   ├── lightdm                                 
│   │   │   └── lightdm.conf                        
│   │   └── playbook.yml                            
│   └── CN_R4                                       
│       ├── ansible.cfg                             
│       ├── configuration-files                     
│       ├── hosts                                   
│       ├── lightdm                                 
│       │   └── lightdm.conf                        
│       └── playbook.yml                            
└── Network-Security                                
    ├── Ext-router                                  
    │   ├── ansible.cfg                             
    │   ├── configuration-files                     
    │   ├── ext-router.yml                          
    │   ├── hosts                                   
    │   └── lightdm                                 
    │       └── lightdm.conf                        
    ├── Int-linux                                   
    │   ├── ansible.cfg                             
    │   ├── configuration-files                     
    │   ├── int-linux.yml                          
    │   ├── hosts                                   
    │   └── lightdm                                 
    │       └── lightdm.conf                        
    ├── Int-router                                  
    │   ├── ansible.cfg                             
    │   ├── configuration-files                     
    │   ├── int-router.yml                          
    │   ├── hosts                                   
    │   └── lightdm                                 
    │       └── lightdm.conf                        
    └── Ubuntu                                      
        ├── ansible.cfg                             
        ├── configuration-files                     
        ├── Ubuntu.yml                          
        ├── hosts                                   
        └── lightdm                                 
            └── lightdm.conf
```

Each playbook contains a `host` file, which contains the IP address of the VM to the plybook against.

```yaml
[Computer-Networks]
root@192.168.1.14
```
Replace the IP address with the IP address your VM.

Place the Playbooks in `/home/` as the location of the files are configured in that way.

```yaml
name: Copy Configuration files
  copy:
    src: ~/ansible/ComputerNetworks/CN_R1/configuration-files/
    dest: /etc/
```

## Running the Playbook
Remember Ansible use SSH to login into the VM, I have used SSH-Keys to login without password as this is the recommended method.
Copy the SSH-Keys from local machine to the remote host, so that we can login without a password.

`$ ssh-copy-id <user>@<ip>`

Now check if you are able to ping the remote host.

`$ ansible all -m ping`

output 

```ansible -m ping prod
Computer-Netwroks | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

`all` ping all the hosts for that playbook.
`-m ping` use ping module

Run the playbook.

`$ ansible-playbook playbook.yml`

If everything works fine the remote VM will be configured.
