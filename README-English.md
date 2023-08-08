# 🔭 NetRadar 🔭

[Español](https://github.com/XDeadHackerX/NetRadar/blob/main/README.md) | [English](https://github.com/XDeadHackerX/NetRadar/blob/main/README-English.md)

> Tool created by XDeadHacker

<p align="center"><img width="120px" alt="Version" src="https://img.shields.io/badge/version-1.0-white.svg?style=for-the-badge"/></p>

[![Net-Radar-1-0-en.png](https://i.postimg.cc/ZKFHJDBn/Net-Radar-1-0-en.png)](https://postimg.cc/2VyhwGxN)

---

<p align="justify"><i>Good afternoon, I'm <strong>XDeadHackerX</strong> and I want to introduce you to my new tool called <strong>NetRadar.</strong> This tool is focused on <strong>Networking</strong>, specifically on the <strong>Mapping</strong> of <strong>Local Networks and Wifi Networks.</strong> At the <strong>Local Network</strong> level, it is capable of analyzing all connected devices (MAC, MAC Vendor, Operating System, Name, Device Type), all open ports of each IP (Port, Service, Service Version, State, Banner), and finding Servers (Name, Operating System, Service Version, Domain, Ports, etc.). At the <strong>Wifi Network</strong> level, we have 4 types of fully automated and powerful scans (Aircrack-ng, Bettercap, NmCli, and Wash). After finishing the scan, it will generate a <strong>Graph</strong> *that shows a <strong>schema</strong> of the <strong>detected Wifi Networks</strong> (MAC, Distance from our Wifi Network Card, Beacons, Channel, Router Speed, Encryption, AUTH, and Wifi Network Name) and the <strong>Devices connected</strong> to each Network, showing you (MAC, MAC Manufacturer, Device Type, and time connected to the Network).</i></p>

<p align="justify"><i>As an extra, <strong>NetRadar</strong> comes with a <strong>Kit</strong> that is capable of summarizing and presenting very interesting information about the Computer, the Network Card, and the Wifi Network Card [Options 1 and 2]</i> <strong>[I AM NOT RESPONSIBLE FOR THE MISUSE OF THIS TOOL]</strong></p>

<p align="center"><img src=https://i.postimg.cc/D0Vbpjfg/wifi1.gif width="350px"/></p>

---

## 💡 Features 💡

:ballot_box_with_check: **Network Card + Equipment Information** --> [*Public IP, Local IP, DNS, MAC, Operating System, Internet Speed Test*] [[Graphical Example]](#punto1)

:ballot_box_with_check: **Information Wifi Network Card + Utilities** --> [**Info Network Card** *(Technical Data, Interface, Drivers, Chipset, MACs, Supported Modes for the Network Card (Monitor Mode, AP, P2P-client, etc), In which Mode is the Network Card (Monitor or Managed), Data Transfer Rate, Supported Frequencies*) **Enable Monitor Mode** *(Enable Monitor Mode and Change MAC, NO NEED TO USE TOOL),* **Reset Network Card** *(Disable Monitor Mode, Set Default MAC and Restart NetworkManager)*] [[Graphical Example]](#punto2)

:ballot_box_with_check: **Local Network Scan (One Device)** --> [**Quick Scan Ports** *(No. Ports, Status, Service of each Port, Mac, Mac Vendor), **Advanced Scan Ports** (No. Ports, Status, Service of each Port, Version of each Service, Content Information of each Port, Mac, Mac Vendor, Operating System, if it has Host Information on it), **Windows + Samba Scan** (Advanced Scan of all 65535 Ports, Enumeration of Users = In case of Power, Domain Acknowledgement = Name, SMB Acknowledgement = Permissions, Access, Class, Windows Assigned Device Name), **NetBios Scan** (Advanced Scan of all 65535 Ports, NetBios Name, Server Type/Name, Users = In case of Power)*] [[Graphical Example]](#punto3)

:ballot_box_with_check: **Local Network Scan (Multiple Devices)** --> [**Quick Scan IPs** *(IPs, MAC, Mac Vendor), **Quick Scan IPs + Ports** (IPs, No. Ports, Service of each Port, Mac, Mac Vendor Mac),**Continuous Scan IPs** (IPs, MAC, Mac Vendor, Name, KB Sent and Received), **Advanced Scan IPs Ports** (No. Ports, Status, Service of each Port, Version of each Service, Content Information of each Port, Mac, Mac Vendor, Operating System, if it has Host Information about it), **Scanning for a Specific Service** (HTTP/HTTPS, SMB, FTP, SSH, Telnet, Windows, NetBIOS)*] [[Graphical Example]](#punto4)

:ballot_box_with_check: **Scan Wifi Networks** --> [*Option to scan with* **Aircrack-ng, Bettercap, NmCli and Wash**. *In the case of using Aircrack-ng when the scan is finished it creates a **Chart** in which it shows you a **schema** of the **Wifi Networks Detected** (MAC, Distance from our Wifi Network Card, Beacons, Channel, Router Speed, Encryption, AUTH and the Name of the Wifi Network) and the **Devices connected** to each Network, showing you (Mac, Mac Manufacturer, Device Type and time connected to the Network)*]. [[Graphical Example]](#punto5)

:ballot_box_with_check: **Scan Devices Connected to a Wifi Network** --> [*Displays the Wifi devices connected to a Wifi Network, when the scan is finished it creates a Graph showing you a scheme of the connected devices showing the MAC of the devices, the amount of Traffic, the distance between each device and our Network Card, the lost packets, Notes and Probes.*] [[Graphical Example]](#punto5)

## 🛠 Install Tool 🛠

**0)** Install and use the Tool with **Root**

**1)** sudo apt update && apt -y full-upgrade

**2)** sudo apt-get install git

**3)** git clone https://github.com/XDeadHackerX/NetRadar

**4)** cd NetRadar

**5)** chmod 777 netradar.sh

**6)** chmod 777 installer.sh

**7)** bash netradar.sh

**8)** Choose a language

**9)** We can now enjoy the tool

## 🎲 Keep in mind 🎲

<p align="justify"><strong>[1]</strong> In case you use the Tool to scan IP addresses it will work perfect except you have a VPN enabled, with the use of VPN most servers give wrong answers about their ports.</p>

<p align="justify"><strong>[2]</strong> In case you have downloaded an older version, I advise you to delete it and reinstall the tool (+requirements) to fix bugs and get improvements, which make the tool much better than previous versions.</p>

<p align="justify"><strong>[3]</strong> If inside the option ([4] Scan All Local Network Devices) in the section ([6] Search Services [HTTP, SMB, FTP, SSH,.]) you get stuck, just wait 3 minutes, this happens because of an error with one of the tools and it is dumping the wrong output to the background and the correct Information is launching it by terminal.</p>

## 🔎 Versions 🔎

<details>
  <summary>[ v1.0 ]</summary>
  <p align="justify">[#] Original Version.</p>
</details>

## 📷 Screenshots 📷

### Network Card + Equipment Information <a name="punto1"></a>
<p align="center"><img src=https://i.postimg.cc/XYGCX8nM/Net-Radar-1-0-es-Ejem-1.png width="auto"/></p>

### Information Wifi Network Card + Utilities <a name="punto2"></a>
<p align="center"><img src=https://i.postimg.cc/5ts7VzWk/Net-Radar-1-0-es-Ejem-2-1.png width="auto"/></p>
<p align="center"><img src=https://i.postimg.cc/ZqBQjPRm/Net-Radar-1-0-es-Ejem-2-2.png width="auto"/></p>

### Local Network Scan (One Device) <a name="punto3"></a>
<p align="center"><img src=https://i.postimg.cc/fRLTKb9s/Net-Radar-1-0-es-Ejem-3-1.png width="auto"/></p>
<p align="center"><img src=https://i.postimg.cc/wxyrhYvr/Net-Radar-1-0-es-Ejem-3-2.png width="auto"/></p>

### Local Network Scan (Multiple Devices) <a name="punto4"></a>
<p align="center"><img src=https://i.postimg.cc/L59nF3nY/Net-Radar-1-0-es-Ejem-4-1.png width="auto"/></p>
<p align="center"><img src=https://i.postimg.cc/VkKyKBcZ/Net-Radar-1-0-es-Ejem-4-2.png width="auto"/></p>

### Scan Wifi Networks <a name="punto5"></a>
<p align="center"><img src=https://i.postimg.cc/sDVGSsfP/Net-Radar-1-0-es-Ejem-5-1.png width="auto"/></p>
<p align="center"><img src=https://i.postimg.cc/65fWrvbT/Net-Radar-1-0-es-Ejem-5-2.png width="auto"/></p>

## ⭐☕ Created by XDeadHackerX ☕⭐

**If you think this project has been useful, I would appreciate your support by giving this repository a star or inviting me for a coffee.**

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/XDeadHackerX)

Copyright © 2023, XDeadHackerX
