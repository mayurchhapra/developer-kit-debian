
echo "============== Fira Code font =============="
sudo apt install -y fonts-firacode

echo "============== VS Code IDE =============="

echo "Update the packages index and install the dependencies"
sudo apt update
sudo apt install -y software-properties-common apt-transport-https wget

echo "Import the Microsoft GPG key"
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

echo "enable the Visual Studio Code repository"
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

echo "Install VS code"
sudo apt install -y code

echo "============== Docker =============="

echo "Update the apt package index and install packages to allow apt to use a repository over HTTPS:"
sudo apt-get update

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "Add Docker’s official GPG key:"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Docker Engine installation"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

echo "==== Post installation of Docker ===="

echo "Create the docker group."
sudo groupadd docker

echo "Add your user to the docker group."
sudo usermod -aG docker $USER

newgrp docker

echo "=========== POSTGRESQL on Docker ==============="
mkdir ${HOME}/postgres-data/
sudo docker run --restart=always -d --network net0 --name postgres -e POSTGRES_PASSWORD=toortoor -v ${HOME}/postgres-data/:/var/lib/postgresql/data -p 5432:5432 postgres

echo "=========== MySQL on Docker ==============="
mkdir ${HOME}/mysql-data/
sudo docker run -p 3306:3306 --name mysql --restart=always -e MYSQL_ROOT_PASSWORD=root -v ${HOME}/mysql-data/:/var/lib/mysql/  -d mysql:8 mysqld --default-authentication-plugin=mysql_native_password

echo "============== NodeJS ==============="

echo "NVM [Node Versoin Manager]"
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile

echo "NodeJs"
nvm install 14

echo "============ PGAdmin =================="
curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

sudo apt install -y pgadmin4

