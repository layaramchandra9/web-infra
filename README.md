# web-infra

## We can use this configuration file to create a simple infrastructure for Java Application.

### need to add permission and ownership updation of webapps directory for ubuntu / respective user to deploy webapp in tomcat server

#### Terraform Version 0.14

For Deployment purpose Add tomcat and ubuntu user to webapps group
sudo chgrp -R tomcat /var/lib/tomcat9/webapps
sudo chgrp -R ubuntu /var/lib/tomcat9/webapps

and when you need to deploy new applications, add write permissions for that group:
sudo chmod -R g+w /var/lib/tomcat9/webapps

which you remove again after deployment:
sudo chmod -R g-w /var/lib/tomcat9/webapps
