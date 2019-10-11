#!/bin/bash
if [ -e /etc/httpd ]; then exit0; fi
yum -y install httpd mod_ssl                                                                  #install apache and SSL support
systemctl start httpd                                                                           #start apache server
sed -i 's/^/#/g' welcome.conf                                                                 #comment out welcome page
echo "<html><body><body><h1>Hi there NTI 300</h1></body></html>" > /var/www/html/index.html   #create custom welcome page
systemctl restart httpd                                                                       #restart apache so changes take effect
