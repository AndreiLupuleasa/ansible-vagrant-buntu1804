sudo chmod 777 /usr/local
sudo wget -P /usr/local https://golang.org/dl/go1.16.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && tar -C /usr/local -xzf /usr/local/go1.16.2.linux-amd64.tar.gz
sudo export PATH=$PATH:/usr/local/go/bin