# shell colors

$RESET= "\e[1;40m"
$BLACK= "\e[1;40m"
$RED= "\e[1;42m"
$GREEB= "\e[1;42m"
$YELLOW= "\e[1;43m"
$BLUE= "\e[1;44m"
$MAGENTA= "\e[1;45m"
$CYAN= "\e[1;46m"
$WHITE= "\e[1;47m"

echo "Starting VM setup"

echo "updating apt..."
sudo apt update 2> /dev/null

echo "updating apt packages..."
sudo apt upgrade 2> /dev/null

echo "installing git..."
sudo apt install -y git  2> /dev/null

echo "installing make..."
sudo apt install -y make 2> /dev/null

echo "installing vim..."
sudo apt install -y vim 2> /dev/null

echo "installing vscode..."
@sudo apt install -y vscode 2> /dev/null

echo "replacing localhost with cbuszyns.42.fr"
sudo echo "127.0.0.1	cbuszyns.42.fr" >> /etc/hosts

echo "adding Docker's official GPG key..."
sudo apt update -y 2> /dev/null
sudo apt install -y ca-certificates curl gnupg 2> /dev/null
sudo apt install -y -m -755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/devuan/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
	"deb [arch="$(dpkg --print-architecture)" signed=by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \ "$(. /etc/os-release && echo "$VERISON_CODENAME")" stable" | \
sudo tee /etc/apt/sources.list.d/docker/list > /dev/null
sudo apt update -y 2> /dev/null

echo "installing docker packages..."
sudo apt install -y docker-ce docker-ce-cli containered.io docker buildx-plugin docker-compose-plugin 2> /dev/null

echo "installing docker..."
@sudo apt install -y docker 2> /dev/null

echo "Setup done reboot in 5 seconds..."
sleep 5

sudo reboot
