MongoDB
=========
[![Galaxy](https://img.shields.io/badge/galaxy-samdoran.mongodb-blue.svg?style=flat)](https://galaxy.ansible.com/samdoran/mongodb)
[![Build Status](https://travis-ci.org/samdoran/ansible-role-mongodb.svg?branch=master)](https://travis-ci.org/samdoran/ansible-role-mongodb)

Install and configure [MongoDB](https://www.mongodb.com).

Requirements
------------

For managing SELinux, the following packages are required:

- `policycoreutils-python`
- `libselinux-python`

Role Variables
--------------

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `mongodb_version` | `3.4` | The version of MongoDB to install |
| `mongodb_port` | `27017` | Default port for `mongod` and `mongos` instances |
| `mongodb_shardsvr_port` | `27018` | Default port when running `shardsvr` |
| `mongodb_configsvr_port` | `27019` | Default port when running `configsvr` |
| `mongodb_webstatus_port` | `28017` | Default port for web status page |
| `mongodb_disable_selinux` | `no` | Whether or not to disable SELinux (**not recommended**). The role will properly configure the system to work with SELinux enabled. |
| `mongdb_days_of_logs_to_keep` | `30` | How manys days of logs to keep. |
| `mongodb_bind_all` | `no` | Whether or not to listen on all interfaces. Defaults to only listen on `mongodb_bind_ip`. |
| `mongodb_bind_ip` | `127.0.0.1` | IP address to bind to. Can be a fact, such as `ansible_default_ipv4.address` or `ansible_all_ipv4_addresses[-1]` |


Dependencies
------------

None

Example Playbook
----------------

    - hosts: all
      roles:
         - samdoran.mongodb

License
-------

MIT
