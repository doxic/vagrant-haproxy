# Ad Hoc Scripts

Check for new vagrant boxes
```
vagrant box update
```

Install vagrant-hosts plugin for hosts file creation
```
vagrant plugin install vagrant-hosts
```

Start Vagrant
```
vagrant up
```

Run ansible playbook
```
ansible-playbook web-server.yml
```

* Access [web1](http://192.168.50.20/app/)
* Access [web2](http://192.168.50.21/app/)
* Access [web3](http://192.168.50.22/app/)

## Monitoring
https://itnext.io/monitoring-with-prometheus-using-ansible-812bf710ef43
https://galaxy.ansible.com/cloudalchemy/prometheus
https://github.com/cloudalchemy/demo-site
https://github.com/nginxinc/nginx-prometheus-exporter/releases

### Installation
```
# Install jmespath
pip3 install jmespath --user
# Docker dependencies
pip3 install docker --user

# Download roles
ansible-galaxy install -r roles/requirements.yml

# Run playbook
ansible-playbook site.yml
```

### Web
http://10.0.200.10:9090
http://10.0.200.10:3000


## Load Test
https://medium.com/@carlosaugustosouzalima/do-you-need-to-run-load-tests-vegeta-to-the-rescue-7e8818127a65
https://www.digitalocean.com/community/tutorials/an-introduction-to-load-testing
https://github.com/tsenart/vegeta/releases


### Installation
-L Follow links
-C Output directory
```
curl -L https://github.com/tsenart/vegeta/releases/download/cli%2Fv12.2.0/vegeta-12.2.0-linux-amd64.tar.gz | tar xvz -C bin
```

### Attack
```
./bin/vegeta attack -duration=30s -rate=10/s -targets=targets.txt > results.10qps.gob
./bin/vegeta attack -duration=30s -rate=20/s -targets=targets.txt > results.20qps.gob
./bin/vegeta attack -duration=30s -rate=50/s -targets=targets.txt > results.50qps.gob

```

### Report
```
./bin/vegeta report results.*
./bin/vegeta plot results.* > plot.html
```

## Loadbalancer
```
echo "set server backend/serv state drain" | sudo socat stdio /etc/haproxy/haproxysock
```
