#!/bin/bash
sudo apt-get install httpd
sudo apt-get install php
cd /var/www/html
cat > index.php <<- "EOF"
<?php
echo "Hello World!";
?>
EOF

service httpd start
