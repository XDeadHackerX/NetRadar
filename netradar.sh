#!bin/bash

source installer.sh

if ! [ -d requisitos ]
		then
			mkdir requisitos
			sudo chmod 777 installer.sh
			sudo bash installer.sh
			Title
			echo
			echo "###############"
			echo "[1] Español"
			echo "[2] English"
			echo "###############"
			echo
			read -p "Elige una Opcion / Choose an Option: " opc1
				case $opc1 in
						1 )	mkdir requisitos/es
						;;
						2 ) mkdir requisitos/en
						;;
						* )	echo
							echo "$RRPLY No es una opcion valida"
							sleep 2
							bash netradar.sh
				esac
fi

if [ -d requisitos/es ]
		then
			Title
			echo "                           ========================================================"
			echo "                                           Informacion & Utilidades"
			echo "                           ========================================================"
			echo "                           [1] Informacion Tarjeta de Red + Equipo"
			echo "                           [2] Informacion Tarjeta de Red Wifi + Utilidades"
			echo "                           ========================================================"
			echo "                                                  Red  Local"
			echo "                           ========================================================"
			echo "                           [3] Escaneo de un Dispositivo de la Red Local"
			echo "                           [4] Escaneo de Todos los Dispositivos de la Red Local"
			echo "                           ========================================================"
			echo "                                                  Redes Wifi"
			echo "                           ========================================================"
			echo "                           [5] Escaneres Avanzados Redes Wifi + [Grafico]"
			echo "                           [6] Escanear Dispositivos de una Red Wifi + [Gráfico]"
			echo "                                                  -----------"
			echo "                           [99] ==================""|""☢ Salir ☢""|""======================"
			echo "                                                  -----------"
			echo
			echo
			read -p " [*] Elige una opcion: " opc1
				case $opc1 in
						1 )	Title
							logo3
							sleep 1
								echo -e "$white"
							echo
							echo "================================================================================================================================"
							echo "[#] Tu IP Publica es la: " `curl -s http:/ifconfig.me`
							echo "--------------------------------------------------------------------------------------------------------------------------------"
							echo "[#] Tu IP Local es la: " `hostname -I`
							echo "--------------------------------------------------------------------------------------------------------------------------------"
							echo "[#] Tu DNS: " `cat /etc/resolv.conf`
							echo "--------------------------------------------------------------------------------------------------------------------------------"
							echo "[#] Tu MAC es la: " `sudo ifconfig -a | awk '/^[a-z]/ { iface=$1; } /inet addr:/ { next; } /^[[:space:]]*ether/ { print iface,$2; }'`
							echo "--------------------------------------------------------------------------------------------------------------------------------"
							echo "[#] Tu Sistema Operativo: " `uname -a`
							echo "================================================================================================================================"
							echo
							echo
							read -p "[*] Quieres hacer una prueba de velocidad precisa? (si/no): " opc1
							echo
								if [ $opc1 = si ]
									then
										speedtest --simple
									else
										bash netradar.sh
								fi
							echo
							;;
						2 )	Title
							echo "[1] Tarjeta de Red"
							echo
							echo "==============================="
							echo "[1] Info de la Tarjeta de Red"" |"
							echo "[2] Activar modo Monitor""      |"
							echo "[3] Restablecer Tarjeta de Red""|"
							echo "[4] Volver al Menu""            |"
							echo "==============================="
							echo 
							echo
							read -p "[*] Elige una opcion: " opc1
								case $opc1 in
										1 )	Title
											logo2
											sleep 1
												echo -e "$white"
											echo
											echo "#########################################################################"
											echo "[##] Datos técnicos: "
											echo "#########################################################################"
											echo
											sudo iwconfig 
											echo
											echo "#########################################################################"
											echo "[##] Interfaz, Drivers, Chipset: "
											echo "#########################################################################"
											sudo airmon-ng
											echo "#########################################################################"
											echo "[##] Interzaces + MAC: "
											echo "#########################################################################"
											echo
											sudo ifconfig -a | awk '/^[a-z]/ { iface=$1; } /inet addr:/ { next; } /^[[:space:]]*ether/ { print iface,$2; }'
											echo
											echo "#########################################################################"
											echo "[##] Modos compatibles con la Tarjeta de Red: "
											echo "#########################################################################"
											echo
											sudo iw list | awk '/Supported interface modes/,/Band/{if(NR>1)print}' | head -n -1
											echo
											echo "#########################################################################"
											echo "[##] Modo Tajeta de Red (Monitor/Manager): "
											echo "#########################################################################"
											echo
											sudo iwconfig | grep -oP '^\S+' | xargs -n1 sh -c 'echo -n $0" Mode:"; iwconfig $0 | awk -F "\"" "/Mode/ {print $2}"'
											echo
											echo "#########################################################################"
											echo "[##] Tasa de Transferencia de Datos: "
											echo "#########################################################################"
											echo
											sudo iw list | grep -oP "VHT TX highest supported:\s*\K\d+" | awk '{print "Tasa de transferencia: " $1 " Mbps"}'
											echo
											echo "#########################################################################"
											echo "[##] Frecuencias soportadas: "
											echo "#########################################################################"
											echo
											sudo iw list > requisitos/frecuencias.txt
											sleep 2
											cut -f2- requisitos/frecuencias.txt | grep -E 'Band 1|Band 2|\*[[:space:]][[:digit:]]{4} MHz'
											echo
											;;
										2 )	echo
											read -p "Para usar esta herramienta no es necesario pulsar esta opcion, ya que cada apartadoa activa el Modo monitor cuando lo necesita (ENTER = OK): " exit
											clear
											ActMonitor
											;;
										3 )	echo
											clear
											DesaMonitor2
											;;
										4 )	echo
											sleep 1
											bash netradar.sh
											;;
										* )	echo
											echo "$RRPLY No es una opcion valida"
											sleep 2
											bash netradar.sh
								esac
							;;
						3 )	Title
							echo "[3] Escaneo de un Dispositivo de la Red Local"
							echo
							echo "==============================================="
							echo "[1] Escaneo Rapido Puertos""                    |"
							echo "[2] Escaneo Avanzado Puertos (SO, Versiones,.)""|"
							echo "[3] Escaneo Windows + Samba""                   |"
							echo "[4] Escaneo NetBios""                           |"
							echo "[5] Todo (Puertos, Windows, Samba, NetBios)""   |"
							echo "[6] Volver al Menu""                            |"
							echo "==============================================="
							echo
							read -p "[*] Elige una opcion: " opc5
								case $opc5 in
										1 )	Title
											echo "[1] Escaneo Rapido Puertos"
											echo
											read -p "[*] Escribe la Ip que desea escanear (Ej: 192.168.1.43): " Ip
											read -p "[*] Escanear los 1000 puertos mas usados (y) o los 65535 (n)? (y/n): " opc2
											echo
											echo "###############################" 
											echo "[#] Escaneando:" $Ip
											echo "###############################"
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											if [ $opc2 = y ]
												then
													sudo nmap -Pn $Ip > requisitos/resultados/$filename
													cat requisitos/resultados/$filename
												else
													sudo nmap -Pn -p- $Ip > requisitos/resultados/$filename
													cat requisitos/resultados/$filename
											fi
											echo
											echo
											echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
											;;
										2 )	Title
											echo "[2] Escaneo Avanzado Puertos (SO, Versiones,.)"
											echo
											read -p "[*] Escribe la Ip que desea escanear (Ej: 192.168.1.43): " Ip
											read -p "[*] Escanear los 1000 puertos mas usados (y) o los 65535 (n)? (y/n): " opc2
											echo
											echo "###############################"
											echo "[#] Escaneando:" $Ip
											echo "###############################"
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											if [ $opc2 = y ]
												then
													sudo nmap -Pn -sV -sC -O $Ip > requisitos/resultados/$filename
													cat requisitos/resultados/$filename
												else
													sudo nmap -Pn -sV -sC -O -p- $Ip > requisitos/resultados/$filename
													cat requisitos/resultados/$filename
											fi
											echo
											echo
											echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
											;;
										3 )	Title
											echo "[3] Escaneo Windows + Samba"
											echo
											read -p "[*] Escribe la Ip que desea escanear (Ej: 192.168.1.43): " Ip
											echo
											echo "###############################" 
											echo "[#] Escaneando:" $Ip
											echo "###############################"
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											sudo nmap -Pn -sV -O -p- $Ip > requisitos/resultados/$filename
											echo >> requisitos/resultados/$filename
											echo >> requisitos/resultados/$filename
											sudo enum4linux -a $Ip >> requisitos/resultados/$filename
											cat requisitos/resultados/$filename
											echo
											echo
											echo "[#] Los Usuarios Obtenidos pueden ser erroneos"
											echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
											;;
										4 )	Title
											echo "[4] Escaneo NetBios"
											echo
											read -p "[*] Escribe la Ip que desea escanear (Ej: 192.168.1.43): " Ip
											echo
											echo "###############################" 
											echo "[#] Escaneando:" $Ip
											echo "###############################"
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											sudo nmap -Pn -sV -O -p- $Ip > requisitos/resultados/$filename
											echo >> requisitos/resultados/$filename
											echo >> requisitos/resultados/$filename
											echo "IP address       NetBIOS Name     Server    User             MAC address" >> requisitos/resultados/$filename
											echo "------------------------------------------------------------------------------" >> requisitos/resultados/$filename
											sudo nbtscan -q $Ip >> requisitos/resultados/$filename
											cat requisitos/resultados/$filename
											echo
											echo
											echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
											;;
										5 )	Title
											echo "[5] Todo (Puertos, Windows, Samba, NetBios)"
											echo
											read -p "[*] Escribe la Ip que desea escanear (Ej: 192.168.1.43): " Ip
											read -p "[*] Escanear los 1000 puertos mas usados (y) o los 65535 (n)? (y/n): " opc2
											echo
											echo
											if [ $opc2 = y ]
												then
													scan_count=1
													filename="scan_$scan_count.txt"
													while [[ -e "requisitos/resultados/$filename" ]]; do
													((scan_count++))
													filename="scan_$scan_count.txt"
													done
													echo "###############################" > requisitos/resultados/$filename
													echo "[#] Puertos: "$Ip >> requisitos/resultados/$filename
													echo "###############################" >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													sudo nmap -Pn -sV -sC -O $Ip >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo "############################################" >> requisitos/resultados/$filename
													echo "[#] Info Windows + Samba: "$Ip >> requisitos/resultados/$filename
													echo "############################################" >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													sudo enum4linux -a $Ip >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo "###############################" >> requisitos/resultados/$filename
													echo "[#] NetBios: "$Ip >> requisitos/resultados/$filename
													echo "###############################" >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo "IP address       NetBIOS Name     Server    User             MAC address" >> requisitos/resultados/$filename
													echo "------------------------------------------------------------------------------" >> requisitos/resultados/$filename
													sudo nbtscan -q $Ip >> requisitos/resultados/$filename
													cat requisitos/resultados/$filename
													echo
													echo
													echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
												else
													scan_count=1
													filename="scan_$scan_count.txt"
													while [[ -e "requisitos/resultados/$filename" ]]; do
													((scan_count++))
													filename="scan_$scan_count.txt"
													done
													echo "###############################" > requisitos/resultados/$filename
													echo "[#] Puertos: "$Ip >> requisitos/resultados/$filename
													echo "###############################" >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													sudo nmap -Pn -sV -sC -O  -p- $Ip >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo "############################################" >> requisitos/resultados/$filename
													echo "[#] Info Windows + Samba: "$Ip >> requisitos/resultados/$filename
													echo "############################################" >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													sudo enum4linux -a $Ip >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo "###############################" >> requisitos/resultados/$filename
													echo "[#] NetBios: "$Ip >> requisitos/resultados/$filename
													echo "###############################" >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo >> requisitos/resultados/$filename
													echo "IP address       NetBIOS Name     Server    User             MAC address" >> requisitos/resultados/$filename
													echo "------------------------------------------------------------------------------" >> requisitos/resultados/$filename
													sudo nbtscan -q $Ip >> requisitos/resultados/$filename
													cat requisitos/resultados/$filename
													echo
													echo
													echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
											fi
											;;
										6 )	bash netradar.sh
											;;
										* )	echo
											echo "$RRPLY No es una opcion valida"
											sleep 2
											bash netradar.sh
								esac
							;;
						4 )	Title
							echo "[4] Escaneo de Todos los Dispositivos de la Red Local"
							echo
							echo "============================================="
							echo "[1] Escaneo  Rapido  IPs [NetDiscover]""      |"
							echo "[2] Escaneo  Rapido  IPs + Puertos [Nmap]""   |"
							echo "[3] Escaneo Continuo IPs [NetDiscover]""      |"
							echo "[4] Escaneo Continuo IPs [Bettercap]""        |"
							echo "[5] Escaneo Avanzado IPs + Puertos [Nmap]""   |"
							echo "[6] Buscar Servicios [HTTP, SMB, FTP, SSH,.]""|"
							echo "[7] Volver al Menu""                          |"
							echo "============================================="
							echo
							read -p "[*] Elige una opcion: " opc5
								case $opc5 in
										1 )	Title
											echo "[1] Escaneo Rapido IPs [NetDiscover]"
											echo
											read -p "[*] Escribe la Ip de Red + la Mascara (Ej: 192.168.1.0/24 o 128.0.0.0/16): " IpRed
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											sudo netdiscover -r $IpRed/24 -P > requisitos/resultados/$filename
											cat requisitos/resultados/$filename
											echo
											echo 
											echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
											;;
										2 )	Title
											echo "[2] Escaneo Rapido IPs + Puertos [Nmap]"
											echo
											read -p "[*] Escribe la Ip de Red + la Mascara (Ej: 192.168.1.0/24 o 128.0.0.0/16): " IpRed
											read -p "[*] Escanear los 1000 puertos mas usados (y) o los 65535 (n)? (y/n): " opc2
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											if [ $opc2 = y ]
												then
													echo
													echo "[#] Escaneando Dispositivos y Puertos de la red" $IpRed
													echo
													sudo nmap -Pn $IpRed > requisitos/resultados/$filename
													awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
												else
													sudo nmap -Pn -p- $IpRed > requisitos/resultados/$filename
													awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
											fi
											echo
											echo 
											echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
											;;
										3 )	read -p "[*] Escribe la Ip de Red + la Mascara (Ej: 192.168.1.0/24 o 128.0.0.0/16): " IpRed
											sudo netdiscover -r $IpRed/24
											;;
										4 )	Title
											echo "[#] Pulse Ctrl + c (Para detener el Escaneo una vez haya comenzado)"
											echo
											sleep 3
											sudo bettercap -eval 'set ticker.commands "clear; net.show"; net.probe on; ticker on'
											;;
										5 )	Title
											echo "[5] Escaneo Avanzado IPs + Puertos [Nmap]"
											echo
											read -p "[*] Escribe la Ip de Red + la Mascara (Ej: 192.168.1.0/24 o 128.0.0.0/16): " IpRed
											read -p "[*] Escanear los 1000 puertos mas usados (y) o los 65535 (n)? (y/n): " opc2
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											if [ $opc2 = y ]
												then
													echo
													echo "[#] Escaneando Dispositivos y Puertos de la red" $IpRed
													echo
													sudo nmap -Pn -sV -O $IpRed > requisitos/resultados/$filename
													awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
												else
													sudo nmap -Pn -sV -O -p- $IpRed > requisitos/resultados/$filename
													awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
											fi
											echo
											echo 
											echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
											;;
										6 )	Title
											echo "[6] Buscar Servicios [HTTP, SMB, FTP, SSH,.]"
											echo
											echo "++++++++++++++++++"
											echo "[1] HTTP/HTTPS   +"
											echo "[2] SMB          +"
											echo "[3] FTP          +"
											echo "[4] SSH          +"
											echo "[5] Telnet       +"
											echo "[6] Windows      +"
											echo "[7] NetBIOS      +"
											echo "[8] Salir        +"
											echo "++++++++++++++++++"
											echo
											read -p "[*] Elige una opcion: " opc5
											echo
												case $opc5 in
														1 )	read -p "[*] Escribe la Ip de Red + la Mascara (Ej: 192.168.1.0/24 o 128.0.0.0/16): " IpRed
															echo
															echo "##############################" 
															echo "[#] Escaneando:" $IpRed
															echo "##############################"
															echo "[#] Servicio: HTTP/HTTPS"
															echo "##############################"
															scan_count=1
															filename="scan_$scan_count.txt"
															while [[ -e "requisitos/resultados/$filename" ]]; do
															((scan_count++))
															filename="scan_$scan_count.txt"
															done
															echo
															echo
															sudo nmap -Pn -sV -T4 -p 80,443 --open $IpRed > requisitos/resultados/$filename
															awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
															echo
															echo
															echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
															echo "[#] Recomiendo hacer un Escaneo Avanzado y Especifico a la Ip que nos interesa usando la Opcion 3 en el Menu Principal"
															;;
														2 )	read -p "[*] Escribe la Ip de Red + la Mascara (Ej: 192.168.1.0/24 o 128.0.0.0/16): " IpRed
															echo
															echo "##############################" 
															echo "[#] Escaneando:" $IpRed
															echo "##############################"
															echo "[#] Servicio: SMB"
															echo "##############################"
															scan_count=1
															filename="scan_$scan_count.txt"
															while [[ -e "requisitos/resultados/$filename" ]]; do
															((scan_count++))
															filename="scan_$scan_count.txt"
															done
															echo
															echo
															sudo nmap -Pn -sV -T4 -p 445 --open $IpRed > requisitos/resultados/$filename
															awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
															echo
															echo
															sudo crackmapexec smb $IpRed 2>/dev/null
															echo
															echo
															echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
															echo "[#] Recomiendo hacer un Escaneo Avanzado y Especifico a la Ip que nos interesa usando la Opcion 3 en el Menu Principal"
															;;
														3 )	read -p "[*] Escribe la Ip de Red + la Mascara (Ej: 192.168.1.0/24 o 128.0.0.0/16): " IpRed
															echo
															echo "##############################" 
															echo "[#] Escaneando:" $IpRed
															echo "##############################"
															echo "[#] Servicio: FTP"
															echo "##############################"
															scan_count=1
															filename="scan_$scan_count.txt"
															while [[ -e "requisitos/resultados/$filename" ]]; do
															((scan_count++))
															filename="scan_$scan_count.txt"
															done
															echo
															echo
															sudo nmap -Pn -sV -T4 -p 21 --open $IpRed > requisitos/resultados/$filename
															awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
															echo
															echo
															sudo crackmapexec ftp $IpRed 2>/dev/null 
															echo
															echo
															echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
															echo "[#] Recomiendo hacer un Escaneo Avanzado y Especifico a la Ip que nos interesa usando la Opcion 3 en el Menu Principal"
															;;
														4 )	read -p "[*] Escribe la Ip de Red + la Mascara (Ej: 192.168.1.0/24 o 128.0.0.0/16): " IpRed
															echo
															echo "##############################" 
															echo "[#] Escaneando:" $IpRed
															echo "##############################"
															echo "[#] Servicio: SSH"
															echo "##############################"
															scan_count=1
															filename="scan_$scan_count.txt"
															while [[ -e "requisitos/resultados/$filename" ]]; do
															((scan_count++))
															filename="scan_$scan_count.txt"
															done
															echo
															echo
															sudo nmap -Pn -sV -T4 -p 22 --open $IpRed > requisitos/resultados/$filename
															awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
															echo
															echo 
															sudo crackmapexec ssh $IpRed 2>/dev/null
															echo
															echo
															echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
															echo "[#] Recomiendo hacer un Escaneo Avanzado y Especifico a la Ip que nos interesa usando la Opcion 3 en el Menu Principal"
															;;
														5 )	read -p "[*] Escribe la Ip de Red + la Mascara (Ej: 192.168.1.0/24 o 128.0.0.0/16): " IpRed
															echo
															echo "##############################" 
															echo "[#] Escaneando:" $IpRed
															echo "##############################"
															echo "[#] Servicio: Telnet"
															echo "##############################"
															scan_count=1
															filename="scan_$scan_count.txt"
															while [[ -e "requisitos/resultados/$filename" ]]; do
															((scan_count++))
															filename="scan_$scan_count.txt"
															done
															echo
															echo
															sudo nmap -Pn -sV -T4 -p 23 --open $IpRed > requisitos/resultados/$filename
															awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
															echo
															echo
															echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
															echo "[#] Recomiendo hacer un Escaneo Avanzado y Especifico a la Ip que nos interesa usando la Opcion 3 en el Menu Principal"
															;;
														6 )	read -p "[*] Escribe la Ip de Red + la Mascara (Ej: 192.168.1.0/24 o 128.0.0.0/16): " IpRed
															echo
															echo "##############################" 
															echo "[#] Escaneando:" $IpRed
															echo "##############################"
															echo "[#] Servicio: Windows"
															echo "##############################"
															scan_count=1
															filename="scan_$scan_count.txt"
															while [[ -e "requisitos/resultados/$filename" ]]; do
															((scan_count++))
															filename="scan_$scan_count.txt"
															done
															echo
															echo
															sudo nmap -Pn -sV -T4 -p 135,139,445 --open $IpRed > requisitos/resultados/$filename
															awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
															echo
															echo
															echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
															echo "[#] Recomiendo hacer un Escaneo Avanzado y Especifico a la Ip que nos interesa usando la Opcion 3 en el Menu Principal"
															;;
														7 )	read -p "[*] Escribe la Ip de Red + la Mascara (Ej: 192.168.1.0/24 o 128.0.0.0/16): " IpRed
															echo
															echo "##############################" 
															echo "[#] Escaneando:" $IpRed
															echo "##############################"
															echo "[#] Servicio: NetBIOS"
															echo "##############################"
															scan_count=1
															filename="scan_$scan_count.txt"
															while [[ -e "requisitos/resultados/$filename" ]]; do
															((scan_count++))
															filename="scan_$scan_count.txt"
															done
															echo
															echo
															sudo nmap -Pn -sV -T4 -p 137,138,139 --open $IpRed > requisitos/resultados/$filename
															echo >> requisitos/resultados/$filename
															echo >> requisitos/resultados/$filename
															echo "IP address       NetBIOS Name     Server    User             MAC address" >> requisitos/resultados/$filename
															echo "------------------------------------------------------------------------------" >> requisitos/resultados/$filename
															sudo nbtscan -q $IpRed >> requisitos/resultados/$filename
															awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
															echo
															echo
															echo "[#] Ruta del Fichero del Escaneo: [NetRadar/requisitos/resultados/$filename]"
															echo "[#] Recomiendo hacer un Escaneo Avanzado y Especifico a la Ip que nos interesa usando la Opcion 3 en el Menu Principal"
															;;
														8 )	exit
															;;
														* )	echo
															echo "$RRPLY No es una opcion valida"
															bash netradar.sh
												esac
											;;
										7 )	bash netradar.sh
											;;
										* )	echo
											echo "$RRPLY No es una opcion valida"
											sleep 2
											bash netradar.sh
								esac
							;;
						5 )	Title
							echo
							echo "========================================"
							echo "[1] Escaner con Aircrack-ng + [Grafico]"
							echo "[2] Escaner con Bettercap"
							echo "[3] Escaner con NmCli [Sin Modo Monitor]"
							echo "[4] Escaner con Wash"
							echo "[5] Volver al Menu"
							echo "========================================"
							read -p "[*] Elige una opcion: " opc4
								case $opc4 in
									1 )	echo
										#Comprobacion de que la Tarjeta de Red tenga puesto el Modo Managed y si no lo cambia + rellenar contendor $interfaz#
										card
										echo
										read -p "[*] Escribe la Interfaz de la Tarjeta de Red (Ej: wlan0): " interfaz
										check_wifi_mode $interfaz
										check_managed $mode
										#Activar Modo Monitor
										ActMonitor
										#Fin#
										Title
										echo "[#] Pulse Ctrl + c (Para detener el Escaneo una vez haya comenzado)"
										echo
										if ! [ -d requisitos/resultados ]
											then
												mkdir requisitos/resultados
										fi
										if ! [ -d requisitos/resultados/grafico_global ]
											then
												sudo rm -r requisitos/resultados/grafico_global
												sudo rm -r requisitos/resultados/captura_global-01.csv
										fi
										sudo airodump-ng $interfaz2 --band abg -w requisitos/resultados/captura_global
										echo
										sudo rm -r requisitos/resultados/captura_global-01.cap
										sudo rm -r requisitos/resultados/captura_global-01.kismet.csv
										sudo rm -r requisitos/resultados/captura_global-01.kismet.netxml
										sudo rm -r requisitos/resultados/captura_global-01.log.csv
										echo
										sudo airgraph-ng -i requisitos/resultados/captura_global-01.csv -o requisitos/resultados/grafico_global -g CAPR >/dev/null
										echo
										echo "=============================="
										echo "      Generando Grafico"
										echo " De las Redes Wifi Escaneadas"
										echo "=============================="
										echo "-------->""                    |"
										sleep 1
										echo "--------------->""             |"
										sleep 1
										echo "---------------------->""      |"
										sleep 1
										echo "---------------------------->""|"
										echo "=============================="
										echo
										echo
										echo "[*] Ruta del Grafico: [NetRadar/requisitos/resultados/grafico_global]"
										echo "[*] Guarda la Imagen en otro directorio o con otro nombre para que no sea remplazada al volver a ejecutar esta opcion"
										echo
										read -p "[*] Quieres abrir el Grafico? (y/n): " open
										echo
										if [ $open = y ]
											then
												sudo open requisitos/resultados/grafico_global
										fi
										#Desactivar Modo Monitor
										DesaMonitor
										#Fin#
										;;
									2 )	echo
										#Comprobacion de que la Tarjeta de Red tenga puesto el Modo Managed y si no lo cambia + rellenar contendor $interfaz#
										card
										echo
										read -p "[*] Escribe la Interfaz de la Tarjeta de Red (Ej: wlan0): " interfaz
										check_wifi_mode $interfaz
										check_managed $mode
										#Activar Modo Monitor
										ActMonitor
										#Fin#
										Title
										echo "[#] Pulse Ctrl + c (Para detener el Escaneo una vez haya comenzado)"
										echo
										sudo bettercap -iface $interfaz2 -eval 'set ticker.commands "clear; wifi.show"; wifi.recon on; ticker on'
										#Desactivar Modo Monitor
										DesaMonitor
										#Fin#
										;;
									3 )	echo
										Title
										echo "[#] Escaneo Realizado (Puede tardar hasta 1 minuto en aparecer la Red Objetivo"
										echo
										sudo nmcli dev wifi list
										;;
									4 )	echo
										#Comprobacion de que la Tarjeta de Red tenga puesto el Modo Managed y si no lo cambia + rellenar contendor $interfaz#
										card
										echo
										read -p "[*] Escribe la Interfaz de la Tarjeta de Red (Ej: wlan0): " interfaz
										check_wifi_mode $interfaz
										check_managed $mode
										#Activar Modo Monitor
										ActMonitor
										#Fin#
										Title
										echo "[#] Pulse Ctrl + c (Para detener el Escaneo una vez haya comenzado)"
										echo
										sudo wash -2 -5 -a -i $interfaz2
										#Desactivar Modo Monitor
										DesaMonitor
										#Fin#
										;;
									5 )	bash netradar.sh
										;;
									* )	echo
										echo "$RRPLY No es una opcion valida"
										sleep 2
										bash netradar.sh
								esac
							;;
						6 )	#Comprobacion de que la Tarjeta de Red tenga puesto el Modo Managed y si no lo cambia + rellenar contendor $interfaz#
							card
							echo
							read -p "[*] Escribe la Interfaz de la Tarjeta de Red (Ej: wlan0): " interfaz
							check_wifi_mode $interfaz
							check_managed $mode
							#Fin#
							Title
							echo "[#] Copia el BSSID y CHAN del Wifi objetivo, puede tardar hasta 1 minuto en aparecer la Red Objetivo"
							echo
							nmcli dev wifi list
							echo
							read -p "[*] Copia el BSSID del Wifi Objetivo y pegelo a continuacion: " bssid
							read -p "[*] Copia el Canal (CHAN) del Wifi Objetivo y pegelo a continuacion: " ch
							#Activar Modo Monitor
							ActMonitor
							#Fin#
							Title
							echo "[#] Pulse Ctrl + c (Para detener el Escaneo una vez haya comenzado)"
							sleep 3
							sleep 3
							if ! [ -d requisitos/resultados ]
								then
									mkdir requisitos/resultados
							fi
							if [ -d requisitos/resultados/$bssid ]
								then
									sudo rm -r requisitos/resultados/$bssid
							fi
							if [ -d requisitos/resultados/Hash* ]
								then
									sudo rm -r requisitos/resultados/Hash*
							fi
							if ! [ -d requisitos/resultados/$bssid ]
								then
									mkdir requisitos/resultados/$bssid
							fi
							sudo airodump-ng -c $ch --bssid $bssid $interfaz2 --band abg  -w requisitos/resultados/$bssid/captura_$bssid
							echo
							sudo rm -r requisitos/resultados/$bssid/captura_$bssid-01.kismet.csv
							sudo rm -r requisitos/resultados/$bssid/captura_$bssid-01.kismet.netxml
							sudo rm -r requisitos/resultados/$bssid/captura_$bssid-01.log.csv
							echo
							sudo airgraph-ng -i requisitos/resultados/$bssid/captura_$bssid-01.csv -o requisitos/resultados/$bssid/grafico_$bssid -g CAPR >/dev/null
							echo
							echo "=============================="
							echo "      Generando Grafico"
							echo " De las Redes Wifi Escaneadas"
							echo "=============================="
							echo "-------->""                    |"
							sleep 1
							echo "--------------->""             |"
							sleep 1
							echo "---------------------->""      |"
							sleep 1
							echo "---------------------------->""|"
							echo "=============================="
							Title
							echo "------------------------------------------------------------"
							echo "↓ Resultados--> $bssid | "`sudo aircrack-ng -J requisitos/resultados/$bssid/captura_$bssid-02 requisitos/resultados/$bssid/captura_$bssid-01.cap | awk 'NF==6{print $3}'`" ↓"
							echo "------------------------------------------------------------"
							echo
							sudo aircrack-ng -J requisitos/resultados/$bssid/captura_$bssid-02 requisitos/resultados/$bssid/captura_$bssid-01.cap | awk 'FNR>= 5{print}' | awk 'FNR<= 3{print}'
							sudo aircrack-ng -J requisitos/resultados/$bssid/captura_$bssid-02 requisitos/resultados/$bssid/captura_$bssid-01.cap | awk 'FNR>= 20{print}'
							sudo hccap2john requisitos/resultados/$bssid/captura_$bssid-02.hccap > requisitos/resultados/$bssid/Hash_$bssid-03
							echo
							echo "[*] Ruta del Grafico: [NetRadar/requisitos/resultados/$bssid/grafico_$bssid]"
							echo "[*] Guarda la carpeta en otro directorio o con otro nombre para que no se remplace al volver a ejecutar esta opcion"
							echo
							read -p "[*] Quieres abrir el Grafico? (y/n): " open
							echo
							if [ $open = y ]
								then
									sudo open requisitos/resultados/$bssid/grafico_$bssid
							fi
							#Desactivar Modo Monitor
							DesaMonitor
							#Fin#
							;;
						99 ) exit
							;;
						* )	echo
							echo "$RRPLY No es una opcion valida"
							sleep 3
							bash netradar.sh
				esac
			echo
			echo
			echo "#####################"
			echo "[1] Volver al Menu"
			echo "[2] Salir"
			echo "#####################"
			echo
			read -p "[*] Elige una opcion: " opc5
				case $opc5 in
						1 )	bash netradar.sh
							;;
						2 )	exit
							;;
						* )	echo
							echo "$RRPLY No es una opcion valida"
							sleep 3
							bash netradar.sh
				esac
		else
			TitleEn
			echo "                           ========================================================"
			echo "                                           Informacion & Utilidades"
			echo "                           ========================================================"
			echo "                           [1] Information Network Card + Equipment"
			echo "                           [2] Information Wifi Network Card + Utilities"
			echo "                           ========================================================"
			echo "                                                 Local Network"
			echo "                           ========================================================"
			echo "                           [3] Scanning a Local Network Device"
			echo "                           [4] Scanning of All Local Network Devices"
			echo "                           ========================================================"
			echo "                                                 Wifi Networks"
			echo "                           ========================================================"
			echo "                           [5] Advanced Scanners Wifi Networks + [Graphic]"
			echo "                           [6] Scanning Devices from a Wifi Network + [Graphic]"
			echo "                                                   ----------"
			echo "                           [99] ===================""|""☢ Exit ☢""|""======================"
			echo "                                                   ----------"
			echo
			echo
			read -p " [*] Choose an option: " opc1
			case $opc1 in
					1 )	TitleEn
						logo3En
						sleep 1
						echo -e "$white"
						echo
						echo "================================================================================================================================"
						echo "[#] Your Public IP address is: " `curl -s http://ifconfig.me`
						echo "--------------------------------------------------------------------------------------------------------------------------------"
						echo "[#] Your Local IP address is: " `hostname -I`
						echo "--------------------------------------------------------------------------------------------------------------------------------"
						echo "[#] Your DNS: " `cat /etc/resolv.conf`
						echo "--------------------------------------------------------------------------------------------------------------------------------"
						echo "[#] Your MAC address is: " `sudo ifconfig -a | awk '/^[a-z]/ { iface=$1; } /inet addr:/ { next; } /^[[:space:]]*ether/ { print iface,$2; }'`
						echo "--------------------------------------------------------------------------------------------------------------------------------"
						echo "[#] Your Operating System: " `uname -a`
						echo "================================================================================================================================"
						echo
						echo
						read -p "[*] Do you want to perform a precise speed test? (yes/no): " opc1
						echo
						if [ $opc1 = yes ]
						then
							speedtest --simple
						else
							bash netradar.sh
						fi
						echo
						;;
					2 )	TitleEn
						echo "[1] Network Card"
						echo
						echo "==============================="
						echo "[1] Network Card Info""         |"
						echo "[2] Activate Monitor Mode""     |"
						echo "[3] Reset Network Card""        |"
						echo "[4] Return to Menu""            |"
						echo "==============================="
						echo 
						echo
						read -p "[*] Choose an option: " opc1
						case $opc1 in
							1 )	TitleEn
								logo2En
								sleep 1
								echo -e "$white"
								echo
								echo "#########################################################################"
								echo "[##] Technical Data: "
								echo "#########################################################################"
								echo
								sudo iwconfig 
								echo
								echo "#########################################################################"
								echo "[##] Interface, Drivers, Chipset: "
								echo "#########################################################################"
								sudo airmon-ng
								echo "#########################################################################"
								echo "[##] Interfaces + MAC: "
								echo "#########################################################################"
								echo
								sudo ifconfig -a | awk '/^[a-z]/ { iface=$1; } /inet addr:/ { next; } /^[[:space:]]*ether/ { print iface,$2; }'
								echo
								echo "#########################################################################"
								echo "[##] Compatible Modes with Network Card: "
								echo "#########################################################################"
								echo
								sudo iw list | awk '/Supported interface modes/,/Band/{if(NR>1)print}' | head -n -1
								echo
								echo "#########################################################################"
								echo "[##] Network Card Mode (Monitor/Manager): "
								echo "#########################################################################"
								echo
								sudo iwconfig | grep -oP '^\S+' | xargs -n1 sh -c 'echo -n $0" Mode:"; iwconfig $0 | awk -F "\"" "/Mode/ {print $2}"'
								echo
								echo "#########################################################################"
								echo "[##] Data Transfer Rate: "
								echo "#########################################################################"
								echo
								sudo iw list | grep -oP "VHT TX highest supported:\s*\K\d+" | awk '{print "Transfer rate: " $1 " Mbps"}'
								echo
								echo "#########################################################################"
								echo "[##] Supported Frequencies: "
								echo "#########################################################################"
								echo
								sudo iw list > requisitos/frequencies.txt
								sleep 2
								cut -f2- requisitos/frequencies.txt | grep -E 'Band 1|Band 2|\*[[:space:]][[:digit:]]{4} MHz'
								echo
								;;
							2 )	echo
								read -p "To use this feature, it's not necessary to choose this option as each section activates Monitor Mode when needed (Press ENTER to continue): " exit
								clear
								echo $interface2
								ActMonitorEn
								;;
							3 )	echo
								clear
								DesaMonitor2En
								;;
							4 )	echo
								sleep 1
								bash netradar.sh
								;;
							* )	echo
								echo "$RRPLY Not a valid option"
								sleep 2
								bash netradar.sh
						esac
						;;
						3 )	TitleEn
						echo "[3] Local Network Device Scanning"
						echo
						echo "==============================================="
						echo "[1] Quick Port Scan""                           |"
						echo "[2] Advanced Port Scan (OS, Versions, etc.)""   |"
						echo "[3] Windows + Samba Scan""                      |"
						echo "[4] NetBios Scan""                              |"
						echo "[5] All (Ports, Windows, Samba, NetBios)""      |"
						echo "[6] Return to Menu""                            |"
						echo "==============================================="
						echo
						read -p "[*] Choose an option: " opc5
						case $opc5 in
							1 )	TitleEn
								echo "[1] Quick Port Scan"
								echo
								read -p "[*] Enter the IP you want to scan (E.g.: 192.168.1.43): " Ip
								read -p "[*] Scan the 1000 most common ports (y) or all 65535 (n)? (y/n): " opc2
								echo
								echo "###############################" 
								echo "[#] Scanning:" $Ip
								echo "###############################"
								scan_count=1
								filename="scan_$scan_count.txt"
								while [[ -e "requisitos/resultados/$filename" ]]; do
								((scan_count++))
								filename="scan_$scan_count.txt"
								done
								echo
								if [ $opc2 = y ]
								then
									sudo nmap -Pn $Ip > requisitos/resultados/$filename
									cat requisitos/resultados/$filename
								else
									sudo nmap -Pn -p- $Ip > requisitos/resultados/$filename
									cat requisitos/resultados/$filename
								fi
								echo
								echo
								echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
								;;
							2 )	TitleEn
								echo "[2] Advanced Port Scan (OS, Versions, etc.)"
								echo
								read -p "[*] Enter the IP you want to scan (E.g.: 192.168.1.43): " Ip
								read -p "[*] Scan the 1000 most common ports (y) or all 65535 (n)? (y/n): " opc2
								echo
								echo "###############################" 
								echo "[#] Scanning:" $Ip
								echo "###############################"
								scan_count=1
								filename="scan_$scan_count.txt"
								while [[ -e "requisitos/resultados/$filename" ]]; do
								((scan_count++))
								filename="scan_$scan_count.txt"
								done
								echo
								if [ $opc2 = y ]
								then
									sudo nmap -Pn -sV -sC -O $Ip > requisitos/resultados/$filename
									cat requisitos/resultados/$filename
								else
									sudo nmap -Pn -sV -sC -O -p- $Ip > requisitos/resultados/$filename
									cat requisitos/resultados/$filename
								fi
								echo
								echo
								echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
								;;
							3 )	TitleEn
								echo "[3] Windows + Samba Scan"
								echo
								read -p "[*] Enter the IP you want to scan (E.g.: 192.168.1.43): " Ip
								echo
								echo "###############################" 
								echo "[#] Scanning:" $Ip
								echo "###############################"
								scan_count=1
								filename="scan_$scan_count.txt"
								while [[ -e "requisitos/resultados/$filename" ]]; do
								((scan_count++))
								filename="scan_$scan_count.txt"
								done
								echo
								sudo nmap -Pn -sV -O -p- $Ip > requisitos/resultados/$filename
								echo >> requisitos/resultados/$filename
								echo >> requisitos/resultados/$filename
								sudo enum4linux -a $Ip >> requisitos/resultados/$filename
								cat requisitos/resultados/$filename
								echo
								echo
								echo "[#] The Obtained Users may be incorrect"
								echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
								;;
							4 )	TitleEn
								echo "[4] NetBios Scan"
								echo
								read -p "[*] Enter the IP you want to scan (E.g.: 192.168.1.43): " Ip
								echo
								echo "###############################" 
								echo "[#] Scanning:" $Ip
								echo "###############################"
								scan_count=1
								filename="scan_$scan_count.txt"
								while [[ -e "requisitos/resultados/$filename" ]]; do
								((scan_count++))
								filename="scan_$scan_count.txt"
								done
								echo
								sudo nmap -Pn -sV -O -p- $Ip > requisitos/resultados/$filename
								echo >> requisitos/resultados/$filename
								echo >> requisitos/resultados/$filename
								echo "IP address       NetBIOS Name     Server    User             MAC address" >> requisitos/resultados/$filename
								echo "------------------------------------------------------------------------------" >> requisitos/resultados/$filename
								sudo nbtscan -q $Ip >> requisitos/resultados/$filename
								cat requisitos/resultados/$filename
								echo
								echo
								echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
								;;
							5 )	TitleEn
								echo "[5] All (Ports, Windows, Samba, NetBios)"
								echo
								read -p "[*] Enter the IP you want to scan (E.g.: 192.168.1.43): " Ip
								read -p "[*] Scan the 1000 most common ports (y) or all 65535 (n)? (y/n): " opc2
								echo
								echo
								if [ $opc2 = y ]
								then
									scan_count=1
									filename="scan_$scan_count.txt"
									while [[ -e "requisitos/resultados/$filename" ]]; do
									((scan_count++))
									filename="scan_$scan_count.txt"
									done
									echo "###############################" > requisitos/resultados/$filename
									echo "[#] Ports: "$Ip >> requisitos/resultados/$filename
									echo "###############################" >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									sudo nmap -Pn -sV -sC -O $Ip >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo "############################################" >> requisitos/resultados/$filename
									echo "[#] Windows + Samba Info: "$Ip >> requisitos/resultados/$filename
									echo "############################################" >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									sudo enum4linux -a $Ip >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo "###############################" >> requisitos/resultados/$filename
									echo "[#] NetBios: "$Ip >> requisitos/resultados/$filename
									echo "###############################" >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo "IP address       NetBIOS Name     Server    User             MAC address" >> requisitos/resultados/$filename
									echo "------------------------------------------------------------------------------" >> requisitos/resultados/$filename
									sudo nbtscan -q $Ip >> requisitos/resultados/$filename
									cat requisitos/resultados/$filename
									echo
									echo
									echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
								else
									scan_count=1
									filename="scan_$scan_count.txt"
									while [[ -e "requisitos/resultados/$filename" ]]; do
									((scan_count++))
									filename="scan_$scan_count.txt"
									done
									echo "###############################" > requisitos/resultados/$filename
									echo "[#] Ports: "$Ip >> requisitos/resultados/$filename
									echo "###############################" >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									sudo nmap -Pn -sV -sC -O -p- $Ip >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo "############################################" >> requisitos/resultados/$filename
									echo "[#] Windows + Samba Info: "$Ip >> requisitos/resultados/$filename
									echo "############################################" >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									sudo enum4linux -a $Ip >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo "###############################" >> requisitos/resultados/$filename
									echo "[#] NetBios: "$Ip >> requisitos/resultados/$filename
									echo "###############################" >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo >> requisitos/resultados/$filename
									echo "IP address       NetBIOS Name     Server    User             MAC address" >> requisitos/resultados/$filename
									echo "------------------------------------------------------------------------------" >> requisitos/resultados/$filename
									sudo nbtscan -q $Ip >> requisitos/resultados/$filename
									echo
									echo
									echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
								fi
								;;
							6 )	bash netradar.sh
								;;
							* )	echo
								echo "$RRPLY Not a valid option"
								sleep 2
								bash netradar.sh
						esac
						;;
						4 )	TitleEn
						echo "[4] Scanning All Devices on the Local Network"
						echo
						echo "=============================================="
						echo "[1] Quick IP Scan [NetDiscover]""               |"
						echo "[2] Quick IP + Port Scan [Nmap]""               |"
						echo "[3] Continuous IP Scan [NetDiscover]""          |"
						echo "[4] Continuous IP Scan [Bettercap]""            |"
						echo "[5] Advanced IP + Port Scan [Nmap]""            |"
						echo "[6] Search for Services [HTTP, SMB, FTP, SSH,]|"
						echo "[7] Return to Menu""                            |"
						echo "=============================================="
						echo
						read -p "[*] Choose an option: " opc5
						case $opc5 in
							1 )	TitleEn
								echo "[1] Quick IP Scan [NetDiscover]"
								echo
								read -p "[*] Enter the Network IP + Mask (E.g.: 192.168.1.0/24 or 128.0.0.0/16): " IpRed
								scan_count=1
								filename="scan_$scan_count.txt"
								while [[ -e "requisitos/resultados/$filename" ]]; do
								((scan_count++))
								filename="scan_$scan_count.txt"
								done
								sudo netdiscover -r $IpRed/24 -P > requisitos/resultados/$filename
								cat requisitos/resultados/$filename
								echo
								echo
								echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
								;;
							2 )	TitleEn
								echo "[2] Quick IP + Port Scan [Nmap]"
								echo
								read -p "[*] Enter the Network IP + Mask (E.g.: 192.168.1.0/24 or 128.0.0.0/16): " IpRed
								read -p "[*] Scan the 1000 most common ports (y) or all 65535 (n)? (y/n): " opc2
								scan_count=1
								filename="scan_$scan_count.txt"
								while [[ -e "requisitos/resultados/$filename" ]]; do
								((scan_count++))
								filename="scan_$scan_count.txt"
								done
								echo
								if [ $opc2 = y ]
									then
										echo
										echo "[#] Scanning Network Devices and Ports" $IpRed
										echo
										sudo nmap -Pn $IpRed > requisitos/resultados/$filename
										awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
									else
										sudo nmap -Pn -p- $IpRed > requisitos/resultados/$filename
										awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
								fi
								echo
								echo 
								echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
								;;
							3 )	read -p "[*] Enter the Network IP + Mask (E.g.: 192.168.1.0/24 or 128.0.0.0/16): " IpRed
								sudo netdiscover -r $IpRed/24
								;;
							4 )	TitleEn
								echo "[#] Press Ctrl + c (To stop the scan once it has started)"
								echo
								sleep 3
								sudo bettercap -eval 'set ticker.commands "clear; net.show"; net.probe on; ticker on'
								;;
							5 )	TitleEn
								echo "[5] Advanced IP + Port Scan [Nmap]"
								echo
								read -p "[*] Enter the Network IP + Mask (E.g.: 192.168.1.0/24 or 128.0.0.0/16): " IpRed
								read -p "[*] Scan the 1000 most common ports (y) or all 65535 (n)? (y/n): " opc2
								scan_count=1
								filename="scan_$scan_count.txt"
								while [[ -e "requisitos/resultados/$filename" ]]; do
								((scan_count++))
								filename="scan_$scan_count.txt"
								done
								echo
								if [ $opc2 = y ]
									then
										echo
										echo "[#] Scanning Network Devices and Ports" $IpRed
										echo
										sudo nmap -Pn -sV -O $IpRed > requisitos/resultados/$filename
										awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
									else
										sudo nmap -Pn -sV -O -p- $IpRed > requisitos/resultados/$filename
										awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
								fi
								echo
								echo 
								echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
								;;
							6 )	TitleEn
								echo "[6] Search for Services [HTTP, SMB, FTP, SSH,.]"
								echo
								echo "++++++++++++++++++"
								echo "[1] HTTP/HTTPS   +"
								echo "[2] SMB          +"
								echo "[3] FTP          +"
								echo "[4] SSH          +"
								echo "[5] Telnet       +"
								echo "[6] Windows      +"
								echo "[7] NetBIOS      +"
								echo "[8] Exit         +"
								echo "++++++++++++++++++"
								echo
								read -p "[*] Choose an option: " opc5
								echo
									case $opc5 in
										1 )	read -p "[*] Enter the Network IP + Mask (E.g.: 192.168.1.0/24 or 128.0.0.0/16): " IpRed
											echo
											echo "##############################" 
											echo "[#] Scanning:" $IpRed
											echo "##############################"
											echo "[#] Service: HTTP/HTTPS"
											echo "##############################"
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											echo
											sudo nmap -Pn -sV -T4 -p 80,443 --open $IpRed > requisitos/resultados/$filename
											awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
											echo
											echo
											echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
											echo "[#] I recommend performing an Advanced and Specific Scan for the IP of interest using Option 3 in the Main Menu"
											echo
											;;
										2 )	read -p "[*] Enter the Network IP + Mask (E.g.: 192.168.1.0/24 or 128.0.0.0/16): " IpRed
											echo
											echo "##############################" 
											echo "[#] Scanning:" $IpRed
											echo "##############################"
											echo "[#] Service: SMB"
											echo "##############################"
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											echo
											sudo nmap -Pn -sV -T4 -p 445 --open $IpRed > requisitos/resultados/$filename
											awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
											echo
											echo
											sudo crackmapexec smb $IpRed 2>/dev/null
											echo
											echo
											echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
											echo "[#] I recommend performing an Advanced and Specific Scan for the IP of interest using Option 3 in the Main Menu"
											echo
											;;
										3 )	read -p "[*] Enter the Network IP + Mask (E.g.: 192.168.1.0/24 or 128.0.0.0/16): " IpRed
											echo
											echo "##############################" 
											echo "[#] Scanning:" $IpRed
											echo "##############################"
											echo "[#] Service: FTP"
											echo "##############################"
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											echo
											sudo nmap -Pn -sV -T4 -p 21 --open $IpRed > requisitos/resultados/$filename
											awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
											echo
											echo
											sudo crackmapexec ftp $IpRed 2>/dev/null
											echo
											echo
											echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
											echo "[#] I recommend performing an Advanced and Specific Scan for the IP of interest using Option 3 in the Main Menu"
											echo
											;;
										4 )	read -p "[*] Enter the Network IP + Mask (E.g.: 192.168.1.0/24 or 128.0.0/24): " IpRed
											echo
											echo "##############################" 
											echo "[#] Scanning:" $IpRed
											echo "##############################"
											echo "[#] Service: SSH"
											echo "##############################"
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											echo
											sudo nmap -Pn -sV -T4 -p 22 --open $IpRed > requisitos/resultados/$filename
											awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
											echo
											echo
											sudo crackmapexec ssh $IpRed 2>/dev/null
											echo
											echo
											echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
											echo "[#] I recommend performing an Advanced and Specific Scan for the IP of interest using Option 3 in the Main Menu"
											echo
											;;
										5 )	read -p "[*] Enter the Network IP + Mask (E.g.: 192.168.1.0/24 or 128.0.0.0/16): " IpRed
											echo
											echo "##############################" 
											echo "[#] Scanning:" $IpRed
											echo "##############################"
											echo "[#] Service: Telnet"
											echo "##############################"
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											echo
											sudo nmap -Pn -sV -T4 -p 23 --open $IpRed > requisitos/resultados/$filename
											awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
											echo
											echo
											echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
											echo "[#] I recommend performing an Advanced and Specific Scan for the IP of interest using Option 3 in the Main Menu"
											echo
											;;
										6 )	read -p "[*] Enter the Network IP + Mask (E.g.: 192.168.1.0/24 or 128.0.0.0/16): " IpRed
											echo
											echo "##############################" 
											echo "[#] Scanning:" $IpRed
											echo "##############################"
											echo "[#] Service: Windows"
											echo "##############################"
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											echo
											sudo nmap -Pn -sV -T4 -p 135,139,445 --open $IpRed > requisitos/resultados/$filename
											awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
											echo
											echo
											echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
											echo "[#] I recommend performing an Advanced and Specific Scan for the IP of interest using Option 3 in the Main Menu"
											echo
											;;
										7 )	read -p "[*] Enter the Network IP + Mask (E.g.: 192.168.1.0/24 or 128.0.0.0/16): " IpRed
											echo
											echo "##############################" 
											echo "[#] Scanning:" $IpRed
											echo "##############################"
											echo "[#] Service: NetBIOS"
											echo "##############################"
											scan_count=1
											filename="scan_$scan_count.txt"
											while [[ -e "requisitos/resultados/$filename" ]]; do
											((scan_count++))
											filename="scan_$scan_count.txt"
											done
											echo
											echo
											sudo nmap -Pn -sV -T4 -p 137,138,139 --open $IpRed > requisitos/resultados/$filename
											echo >> requisitos/resultados/$filename
											echo >> requisitos/resultados/$filename
											echo "IP address       NetBIOS Name     Server    User             MAC address" >> requisitos/resultados/$filename
											echo "------------------------------------------------------------------------------" >> requisitos/resultados/$filename
											sudo nbtscan -q $IpRed >> requisitos/resultados/$filename
											awk '/^Nmap scan report/{printf "* %s\n", $NF; next} 1' requisitos/resultados/$filename
											echo
											echo
											echo "[#] Scan File Path: [NetRadar/requisitos/resultados/$filename]"
											echo "[#] I recommend performing an Advanced and Specific Scan for the IP of interest using Option 3 in the Main Menu"
											echo
											;;
										8 )	exit
											;;
										* )	echo
											echo "$RRPLY Not a valid option"
											bash netradar.sh
									esac
									;;
								7 )	bash netradar.sh
									;;
								* )	echo
									echo "$RRPLY Not a valid option"
									sleep 2
									bash netradar.sh
							esac
							;;
						    5 )	TitleEn
							echo
							echo "========================================"
							echo "[1] Aircrack-ng Scanner + [Graphical]"
							echo "[2] Bettercap Scanner"
							echo "[3] NmCli Scanner [No Monitor Mode]"
							echo "[4] Wash Scanner"
							echo "[5] Back to Menu"
							echo "========================================"
							read -p "[*] Choose an option: " opc4
								case $opc4 in
									1 )	echo
										# Check if the Network Interface Card is in Managed Mode and change it if not + fill the $interfaz variable
										cardEn
										echo
										read -p "[*] Enter the Network Interface Card (E.g.: wlan0): " interfaz
										check_wifi_mode $interfaz
										check_managedEn $mode
										# Activate Monitor Mode
										ActMonitorEn
										# Finish #
										TitleEn
										echo "[#] Press Ctrl + c (To stop the Scan once it has started)"
										echo
										if ! [ -d requisitos/resultados ]
											then
												mkdir requisitos/resultados
										fi
										if ! [ -d requisitos/resultados/grafico_global ]
											then
												sudo rm -r requisitos/resultados/grafico_global
												sudo rm -r requisitos/resultados/captura_global-01.csv
										fi
										sudo airodump-ng $interfaz2 --band abg -w requisitos/resultados/captura_global
										echo
										sudo rm -r requisitos/resultados/captura_global-01.cap
										sudo rm -r requisitos/resultados/captura_global-01.kismet.csv
										sudo rm -r requisitos/resultados/captura_global-01.kismet.netxml
										sudo rm -r requisitos/resultados/captura_global-01.log.csv
										echo
										sudo airgraph-ng -i requisitos/resultados/captura_global-01.csv -o requisitos/resultados/grafico_global -g CAPR >/dev/null
										echo
										echo "=============================="
										echo "      Generating Graph"
										echo " Of the Scanned Wifi Networks"
										echo "=============================="
										echo "-------->""                    |"
										sleep 1
										echo "--------------->""             |"
										sleep 1
										echo "---------------------->""      |"
										sleep 1
										echo "---------------------------->""|"
										echo "=============================="
										echo
										echo
										echo "[*] Graph Path: [NetRadar/requisitos/resultados/grafico_global]"
										echo "[*] Save the Image in another directory or with another name to avoid overwriting when running this option again"
										echo
										read -p "[*] Do you want to open the Graph? (y/n): " open
										echo
										if [ $open = y ]
											then
												sudo open requisitos/resultados/grafico_global
										fi
										# Deactivate Monitor Mode
										DesaMonitorEn
										# Finish #
										;;
									2 )	echo
										# Check if the Network Interface Card is in Managed Mode and change it if not + fill the $interfaz variable
										cardEn
										echo
										read -p "[*] Enter the Network Interface Card (E.g.: wlan0): " interfaz
										check_wifi_mode $interfaz
										check_managedEn $mode
										# Activate Monitor Mode
										ActMonitorEn
										# Finish #
										TitleEn
										echo "[#] Press Ctrl + c (To stop the Scan once it has started)"
										echo
										sudo bettercap -iface $interfaz2 -eval 'set ticker.commands "clear; wifi.show"; wifi.recon on; ticker on'
										# Deactivate Monitor Mode
										DesaMonitorEn
										# Finish #
										;;
									3 )	echo
										TitleEn
										echo "[#] Scan Completed (The Target Network may take up to 1 minute to appear)"
										echo
										sudo nmcli dev wifi list
										;;
									4 )	echo
										# Check if the Network Interface Card is in Managed Mode and change it if not + fill the $interfaz variable
										cardEn
										echo
										read -p "[*] Enter the Network Interface Card (E.g.: wlan0): " interfaz
										check_wifi_mode $interfaz
										check_managedEn $mode
										# Activate Monitor Mode
										ActMonitorEn
										# Finish #
										TitleEn
										echo "[#] Press Ctrl + c (To stop the Scan once it has started)"
										echo
										sudo wash -2 -5 -a -i $interfaz2
										# Deactivate Monitor Mode
										DesaMonitorEn
										# Finish #
										;;
									5 )	bash netradar.sh
										;;
									* )	echo
										echo "$RRPLY Not a valid option"
										sleep 2
										bash netradar.sh
								esac
							;;
							6 )	# Check if the Network Interface Card is in Managed Mode and change it if not + fill the $interfaz variable
								cardEn
								echo
								read -p "[*] Enter the Network Interface Card (E.g.: wlan0): " interfaz
								check_wifi_mode $interfaz
								check_managedEn $mode
								# Finish #
								TitleEn
								echo "[#] Copy the BSSID and CHAN of the target Wifi, it may take up to 1 minute for the Target Network to appear"
								echo
								nmcli dev wifi list
								echo
								read -p "[*] Copy the BSSID of the Target Wifi and paste it below: " bssid
								read -p "[*] Copy the Channel (CHAN) of the Target Wifi and paste it below: " ch
								# Activate Monitor Mode
								ActMonitorEn
								# Finish #
								TitleEn
								echo "[#] Press Ctrl + c (To stop the Scan once it has started)"
								sleep 3
								sleep 3
								if ! [ -d requisitos/resultados ]
									then
										mkdir requisitos/resultados
								fi
								if [ -d requisitos/resultados/$bssid ]
									then
										sudo rm -r requisitos/resultados/$bssid
								fi
								if [ -d requisitos/resultados/Hash* ]
									then
										sudo rm -r requisitos/resultados/Hash*
								fi
								if ! [ -d requisitos/resultados/$bssid ]
									then
										mkdir requisitos/resultados/$bssid
								fi
								sudo airodump-ng -c $ch --bssid $bssid $interfaz2 --band abg  -w requisitos/resultados/$bssid/captura_$bssid
								echo
								sudo rm -r requisitos/resultados/$bssid/captura_$bssid-01.kismet.csv
								sudo rm -r requisitos/resultados/$bssid/captura_$bssid-01.kismet.netxml
								sudo rm -r requisitos/resultados/$bssid/captura_$bssid-01.log.csv
								echo
								sudo airgraph-ng -i requisitos/resultados/$bssid/captura_$bssid-01.csv -o requisitos/resultados/$bssid/grafico_$bssid -g CAPR >/dev/null
								echo
								echo "=============================="
								echo "      Generating Graph"
								echo " Of the Scanned Wifi Networks"
								echo "=============================="
								echo "-------->""                    |"
								sleep 1
								echo "--------------->""             |"
								sleep 1
								echo "---------------------->""      |"
								sleep 1
								echo "---------------------------->""|"
								echo "=============================="
								TitleEn
								echo "------------------------------------------------------------"
								echo "↓ Results--> $bssid | "`sudo aircrack-ng -J requisitos/resultados/$bssid/captura_$bssid-02 requisitos/resultados/$bssid/captura_$bssid-01.cap | awk 'NF==6{print $3}'`" ↓"
								echo "------------------------------------------------------------"
								echo
								sudo aircrack-ng -J requisitos/resultados/$bssid/captura_$bssid-02 requisitos/resultados/$bssid/captura_$bssid-01.cap | awk 'FNR>= 5{print}' | awk 'FNR<= 3{print}'
								sudo aircrack-ng -J requisitos/resultados/$bssid/captura_$bssid-02 requisitos/resultados/$bssid/captura_$bssid-01.cap | awk 'FNR>= 20{print}'
								sudo hccap2john requisitos/resultados/$bssid/captura_$bssid-02.hccap > requisitos/resultados/$bssid/Hash_$bssid-03
								echo
								echo "[*] Graph Path: [NetRadar/requisitos/resultados/$bssid/grafico_$bssid]"
								echo "[*] Save the folder in another directory or with another name to avoid overwriting when running this option again"
								echo
								read -p "[*] Do you want to open the Graph? (y/n): " open
								echo
								if [ $open = y ]
									then
										sudo open requisitos/resultados/$bssid/grafico_$bssid
								fi
								# Deactivate Monitor Mode
								DesaMonitorEn
								# Finish #
							;;
							99 ) exit
								;;
							* )	echo
								echo "$RRPLY Not a valid option"
								sleep 3
								bash netradar.sh
					esac
			echo
			echo
			echo "#####################"
			echo "[1] Back to Menu"
			echo "[2] Exit"
			echo "#####################"
			echo
			read -p "[*] Elige una opción: " opc5
				case $opc5 in
						1)  bash netradar.sh
						;;
						2)  exit
						;;
						*)  echo
							echo "$opc5 No es una opción válida"
							sleep 3
							bash netradar.sh
				esac
fi
