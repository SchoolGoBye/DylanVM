git clone https://github.com/SchoolGoBye/DylanVM/
cd DylanVM
pip install textual
sleep 2
python3 installer.py
docker build -t dylanvm . --no-cache
cd ..

sudo apt update
sudo apt install -y jq

mkdir Save
cp -r DylanVM/root/config/* Save

json_file="DylanVM/options.json"
if jq ".enablekvm" "$json_file" | grep -q true; then
    docker run -d --name=DylanVM -e PUID=1000 -e PGID=1000 --device=/dev/kvm --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=DylanVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped dylanvm
else
    docker run -d --name=DylanVM -e PUID=1000 -e PGID=1000 --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=DylanVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped dylanvm
fi
clear
echo "DYLANVM WAS INSTALLED SUCCESSFULLY! Check Port Tab tp see if this GameFlow Invention works!"
