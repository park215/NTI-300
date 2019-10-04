#!/bin/bash                 
time=$(date)                #sets variable time
echo "<html><body><h1>hi there, it is $time, how are you?</h1></body></html>" > /var/www/html/index.html  #create html page with time var
