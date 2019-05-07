Role Name
=========
Ansible role for installing Xen from source.

Role Variables
--------------
This role requires only one variable `xen.location` which is the location where the xen source will be cloned.

Dependencies
------------

`Python 2` should be installed on the system.

Example Playbook
----------------
    - hosts: xen
      roles:
         - { role: xen }

Example Inventory
-----------------------
```bash
inventory/
├── group_vars
│   └── xen.yml
└── hosts
```
Example `params` file
---------------------------
```yaml---
xen:
  location: "$HOME/xen"
  ```



How to run this playbook
-------------------------------
`$ ansible-playbook -i inventory/ playbook.yml`
