#! /bin/bash
# Installed http server for test
# sudo apt-get update
# sudo apt-get install -y apache2
# sudo systemctl start apache2
# sudo systemctl enable apache2
# echo "<h1>Webapp - Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html

# Tomcat to deploy webapp
sudo apt update
sudo apt-cache search tomcat
sudo apt install -y tomcat9 tomcat9-admin
ss -ltn
sudo systemctl enable tomcat9
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo sh -c \"iptables-save > /etc/iptables.rules\"
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
sudo apt-get -y install iptables-persistent
# Add tomcat and ubuntu user to webapps group
sudo chgrp -R tomcat /var/lib/tomcat9/webapps
sudo chgrp -R ubuntu /var/lib/tomcat9/webapps
# when you need to deploy new applications, add write permissions for that group
sudo chmod -R g+w /var/lib/tomcat9/webapps
# you remove again after deployment
# sudo chmod -R g-w /var/lib/tomcat9/webapps
sudo ufw allow 8080
