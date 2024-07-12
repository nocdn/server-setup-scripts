coreCount=$(nproc)
echo "$coreCount"

sudo apt update
sudo apt upgrade -y
sudo apt install -y wget build-essential libssl-dev zlib1g-dev libbz2-dev liblzma-dev libffi-dev tcl-dev libgdbm-dev libsqlite3-dev libreadline-dev tk tk-dev libncurses5-dev libnss3-dev

wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz

tar -xvf Python-3.11.9.tgz

cd Python-3.11.9/

./configure --enable-optimizations

sudo make altinstall -j "$coreCount"