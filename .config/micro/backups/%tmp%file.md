Lecture 6: Networking Concepts (Part II) 

5.5 Network Topologies:
Two Types of LAN Topologies:

Physical topology is the physical layout of the components on the network.

Logical topology determines how the hosts access the medium to communicate across the network.

Logical Topologies:
 The two most common types of logical topologies are broadcast and token passing. 
  • Broadcast topology: A host broadcasts a message to all hosts on the same network segment. There is no order that hosts must follow to transmit data. Messages are sent on a First In, First Out (FIFO). Ethernet is based on this topology. 
  • Token passing: controls network access by passing an electronic token sequentially to each host. When a host receives the token, it can send data on the network. If the host has no data to send, it passes the token to the next host and the process repeats itself. 

LAN Physical Topologies:
 A physical topology defines the way in which computers, printers, and other devices are connected to a network. 
 Bus 
  • Each computer connects to a common cable The ends of the cable have a terminator installed to prevent signal reflections and network errors. 
  • Only one computer can transmit data at a time or frames will collide and be destroyed. 
 Ring 
  • Hosts are connected in a physical ring or circle. 
  • A special frame, a token, travels around the ring, stopping at each host to allow data transmission. 
  • There are two types of ring topologies: 
    – Single-ring
    - Dual-ring
 Star 
  • Has a central connection point : a hub, switch, or router. 
  • Easy to troubleshoot, since each host is connected to the central device with its own wire. 
 Hierarchical or Extended Star Topology 
  • A star network with an additional networking device connected to the main networking device to increase the size of the network. 
  • Used for larger networks. 
 Mesh Topology 
  • Connects all devices to each other. 
  • Used in WANs that interconnect LANs. The Internet is an example of a mesh topology. 
 Hybrid 
  • A hybrid topology is a combination of two or more basic network topologies, such as a star-bus, or star-ring topology. The advantage of a hybrid topology is that it can be implemented for a number of different network environments. 

Topology | Type | Structure | Reliability | Scalability | Cost | Use Cases |
Bus  | A single central cable (backbone) to which all devices are connected | Low; a break in the main cable disrupts the whole network | Limited; performance decreases with more devicesLow cost; minimal cabling required | Small networks or temporary setups |
Star | All devices connect to a central hub or switch | High; if one device fails., others remain unaffected; however hub failure disrupts the network | Easy to add/ remove devices without impacting performance | Moderate; cost depends on the hub and cables | Common in home and office LANs |
Ring | Devices are connected in a circular sequence; each device connects to two others | Moderate; a break in the ring disrupts the network but adding dual rings improves reliability | Moderate: adding devices requires changes to the ring | Moderate; requires specific connectors and configuration | Older LANs and some token ring networks |
Mesh | Every device is connected to every other device (full mesh) or at least to multiple devices (partial mesh) | Very high; redundancy ensures continuous operation if one path fails | High; suitable for large and scalable networks, but complex with many devices | High cost; requires a lot of cabling and configuration | High-availability networks, e.g. in critical systems (e.g., military hospitals) |

Types of Networks:
 LAN (Local Area Network): is a network that connects computers and devices within a limited geographic area, such as a home, office, or building. LANs are typically used to enable the sharing of resources like files, printers, and internet connections among multiple devices in close proximity.  
 WLAN (Wireless Local Area Network): A group of wireless devices that connect to access points within a specified area. Access points are typically connected to the network using copper cabling. 
 VLAN (Virtual LAN) – is a network configuration that allows you to segment 
a single physical network into multiple, isolated virtual networks. VLANs improve network management, security, and performance by logically grouping devices together, even if they are not physically connected to the same network switch.
 PAN (Personal Area Network): Network that connects devices, such as mice, keyboards, printers, smartphones, and tablets within the range of an individual person. PANs are most often connected with Bluetooth technology. Bluetooth can support up to 7 devices simultaneously. 
 MAN (Metropolitan Area Network): Network that spans across a large campus or a city. Consisting of various buildings interconnected through wireless or fiber optic backbones. A network that spans a city. 
 WAN (Wide Area Network): Connections of multiple smaller networks such as LANs that are in geographically separated locations. The most common example of a WAN is the Internet. A network that spans a large geographical area.

Network Architectures:
 Peer-to-Peer Networks
  • No dedicated servers 
  • Each computer decides which resources to share 
  • No central administration or security 
 Client-Server Networks 
  • Server with software installed for client access 
  • Resources controlled by centralized administrator 
  • Secure access to confidential information 
  • A centralized storage 
  • Critical data should be backed up on a regular basis. 

Peer-to-Peer VS. Client-Server:

Feature | Peer-to-Peer | Client-Server |
Architecture | Decentralized; each device acts as both a client and a server. | Centralized; dedicated servers provide services to client devices. |
Control | No centralized control; all peers manage their own resources. | Centralized control by the server, The server manages resources and permissions. |
Cost | Low setup cost no need for expensive servers. | Higher setup cost due to the need for dedicated servers and maintenance. |
Scalability | Limited scalability; performance decreases as peers increase. | Highly scalable; servers can handle large numbers of clients with proper resources. |
Security | Less secure; each device is responsible for its own security. | More secure; centralized security measures can be implemented. |
Reliability | Less reliable; if a peer goes offline, its resources are unavailable. | More reliable; servers provide consistent availability (with redundancies). |
Performance | Slower performance as the network grows; depends on peer resources. | Faster performance; optimized server hardware ensures efficient handling of tasks. |
Use Case | Suitable for small networks (e.g., file sharing, small home or office networks). | Suitable for large networks (e.g., corporate systems, web applications, databases). |
Data Storage | Distributed across peers. | Centralized on the server. Clients access shared data from the server. |
Maintenance | Easier maintenance; no central device to manage. | Requires skilled administrators for server management and troubleshooting. |
Examples | File-sharing networks (e.g. BitTorrent). | Websites, email services, enterprise networks (e.g., Google Drive, Outlook). |

Bandwidth and Latency 
 Bandwidth is the amount of data that can be transmitted within a fixed time period. 
 Bandwidth is measured in bits per second and is usually denoted by the following: 
  • bps - bits per second 
  • Kbps - kilobits per second 
  • Mbps - megabits per second 
  • Gbps - gigabits per second 
 Latency is the amount of time it takes data to travel from source to destination. 
 Data is transmitted in one of three modes: 
  • Simplex (Unidirectional transmission) is a single, one-way transmission. 
  • Half-duplex allows data to flow in one direction at a time. 
  • Full-duplex allows data to flow in both directions at the same time. 

Examples for each data transmission mode:
Simplex (Unidirectional Transmission):  Radio Broadcast - Information is transmitted from the radio station to listeners, but listeners cannot send data back to the station. 
Half-Duplex: Walkie-Talkies - Communication can occur in both directions, but only fone person can speak at a time. One user must release the "push-to-talk" button to allow the other to respond. 
Full-Duplex: Telephone Call - Both parties can speak and listen simultaneously, allowing data to flow in both directions at the same time without interruption. 

5.2 NETWORKING PROTOCOLS, STANDARDS, AND SERVICES 

Reference Models :
 Organizations, such as lEEE, IETF, and ISO, develop open standards for networks so that any client running any operating system can access network resources. 
 The OSI model and the TCP/IP model are both reference models used to describe the data communication process. 
 As application data is passed down through the layers, protocol information is added at each level. This is known as the encapsulation process. 

The TCP/IP Model:
 Frame of reference used to develop the Internet's protocols. 
 Consists of layers that perform functions necessary to prepare data for transmission over a network. 
Layer | Description | Protocols
Application | Provides network services to user applications | HTTP, HTML, Telnet, FTP, TFTP, SMTP, DNS |

Transport | Provides end-to-end management of data and divides data into segments | TCP, UDP |
Internet | Provides connectivity between hosts in the network. IP addressing and routing here. | IP, ICMP, RIP, ARP |
Network Access Where Mac addressing and physical components exist  | (fill it)

The OSI Model :
 The OSI model is an industry standard framework that is used to divide network communications into seven layers. 
 Although other models exist, most network vendors today build their products using this framework. 
 A protocol stack is a system that implements protocol behavior using a series of layers. 
  • Protocol stacks can be implemented either in hardware or software, or in a combination of both. 
  • Typically, only the lower layers are implemented in hardware, and the higher layers are implemented in software. 

Real-World Example :
When you send an email: 
Application Layer: The email client (e.g., Outlook) uses SMTP to send the email. 
Presentation Layer: The email data is formatted and encrypted. 
Session Layer: A session is established between the sender and recipient. 
Transport Layer: The data is divided into segments and sent reliably using TCP. 
Network Layer: IP addresses route the data across networks. 
Data Link Layer: Frames the data with MAC addresses for delivery on the local network. 
Physical Layer: Transmits the data as electrical signals over cables or Wi-Fi. 

N.O | Layer         | Description | Protocols |
7   | Application   | Provides network services directly to the user or applications. | HTTP FTP SMTP DNS, POP3, IMAP |
6   | Presentation  | Translates data into a format usable by the Application layer (e.g., encryption, compression). | SSL/TLS, JPEG, MPEG, ASCII, EBCDIC |
5   | Session       | Establishes, manages, and terminates communication sessions between applications. | NetBIOS, RPC, PPTP |
4   | Transport     | Ensures reliable data transfer between systems, managing error correction and flow control. | TCP UDP |
3   | Network       | Handles logical addressing and routing of data packets across networks. | IP ICMP OSPF, RIP, ARP |
2   | Data Link     | Manages physical addressing (MAC), error detection, and frames data for the physical layer. | Ethernet, Wi-Fi (802.11), PPP MAC |
1   | Physical      | Defines the physical transmissioi' edium and data encoding (e.g., cables, signals). | Cables (Cat5e, fiber), hubs, repeaters, voltage levels |

Compare OSI and TCP/IP Models 

Encapsulation:
 Process of placing one message format into another format so that the message can be delivered 
 Receives headers, footers, and other information 
 Five step process: 
  • Data 
  • Segments 
  • Packets 
  • Frames 
  • Bits 

TCP:
 Three basic operations of reliability 
  • Numbering and tracking of data segments 
  • Acknowledgment of received data 
  • Retransmitting any unacknowledged data after a period of time. 
 Required protocol properties: 
  • Reliable 
  • Acknowledges data 
  • Resends lost data 
  • Delivers data in sequenced order 

UDP:
 Very little overhead or data checking 
 Best-effort delivery protocol (unreliable) 
  • No acknowledgment that the data is received by the destination 
 Required protocol properties: 
  • Fast 
  • Low overhead 
  • Does not require acknowledgements 
  • Does not resend lost data 
  • Delivers data as it arrives 

Classify Application Port Numbers:
PCs use the source port number to track the data flow of every application. World Wide Web Protocols.

Port | Transport Protocol  | Application Protocol  | Description |

53 TCP, UDP DNS 
The Domain Name Service (DNS) protocol finds the IP address 
associated with a registered Internet domain for Web, Email, and 
other Internet services. It uses UDP for requests and information 
transfer between DNS servers. TCP will be used for DNS 
responses if required. 

80 TCP HTTP 
Hypertext Transfer Protocol (HTTP) provides a set of rules for 
exchanging text, graphic images, sound, video, and other 
multimedia files on the World Wide Web. 

443 TCP, UDP HTTPS 
The browser uses encryption and authenticates your connection 
with webserver. 

Email and Identity Management Protocols 

Port | Transport Protocol  | Application Protocol  | Description |

25 TCP SMTP 
Simple Mail Transfer Protocol is used to send email from dents to an 
email server. It may also be used to relay email messages from 
source to destination email servers. 

110 TCP POP3 
Post Office Protocol 3 is used by email clients to retrieve messages 
from an email server. 

143 TCP IMAP 
Internet Message Access Protocol is used to retrieve email messages 
from a server. It Is more advanced than POPS and offers a number of 
advantages. 

389 TCP, UDP LDAP 
Lightweight Directory Access Protocol is used to maintain user 
identity directory information that can be shared across networks and 
systems. It can be used to manage information about users and 
network resources. It can be used to authenticate users on multiple 
computers. 

Remote Access Protocols:

Port | Transport Protocol  | Application Protocol  | Description |

22 TCP SSH 
Secure Shell or Secure Socket Shell provides a strong authentication 
and encrypted data transport between a client and remote computer. 
Like Telnet, it provides a command line on the remote computer. 

23 TCP 
Telnet Telnet is an insecure remote access protocol that provides a 
command line on a remote computer. SSH is preferred for security 
reasons. 

3389 TCP, UDP RDP 
Remote desktop protocol was developed by Microsoft to provide 
remote access to the graphical desktop of a remote machine. It is 
useful for tech support situations, however it should be used with 
caution because it provides a remote user with complete control of 
the destination computer. 

File Transport and Management Protocols:

Port | Transport Protocol  | Application Protocol  | Description |

20 TCP FTP 
File transfer protocol. Used to transfer files between computers. 
Considered insecure, SSH file transfer protocol (SFTP, TCP port 22) 
should be used. 

21 TCP FTP 
FTP uses TCP port 21 to establish a connection between the client 
and FTP server. In order to start a data transfer session. 

69 UDP TFTP 
Trivial File Transfer Protocol utilizes less overhead than FTR. 

445 TCP SMB/CIFS 
Server Message Block or Common Internet File System allow for 
sharing of files, printers, and other resources between nodes on a 
network. Related to Samba. 

548 TCP, UDP AFP 
Apple Filing Protocol is a proprietary protocol developed by Apple to 
enable file services for macOS and classic Mac OS. 



67/68 UDP DHCP 

 

Dynamic Host Configuration Protocol automatically provides IP 
addresses to network hosts and provides a way to manage those 
addresses. The DHCP server uses UDP port 67 and the client host 
uses UDP port 68. 

 

137-139 UDR TCP NetBIOS 

 

(NetBT) 

NetBIOS over TCP/IP provides a system through which older 
computer applications can communicate over large TCP/IP 
networks. Different NetBT functions use different protocols and 
ports in this range. 
161/162 UDP SNMP Simple Network Management Protocol enables network 
administrators to monitor network operations from centralized 
monitoring stations. 
427 UDP, TCP SLP Service Location Protocol allows computers and other devices to 
locate services on a LAN without previous configuration. Usually 
uses UDP. but can use TCP. 37 

Classify Application Port Numbers 
Network Operations Protocols 

ITE v7.0 


39 

Standards Organizations 

ITE v7.0 39 

Name Type Standards Established 

 

ITU-T 

ITU Telecommunication 
Standardization Sector (formerly 
CCITT) 

one of the three Sectors of the 
International Telecommunication 
Union 

 

Standards covering all fields of 
telecommunications Became ITU-T in 1992 

 

 

IEEE Institute of Electrical and 

 

Electronics Engineers 

 

A non-profit, technical professional 
association 

 

Standards for the computer and 
electronics industry 1884 

 

ISO International Organization for 

Standardization 

A network of the national standards 
institutes of 157 countries 

Promote the development of 
international standards 
agreements 

 

1947 

 

IAB Internet Architecture Board A committee; an advisory body 

 Oversees the technical and 
engineering development of the 
Internet 

 

1979; first named ICCB 

IEC International Electrotechnical 

Commission Global organization 

 Standards for all electrical, 
electronic, and related 
technologies 

 

1906 

ANSI American National Standards 

Institute Private, non-profit organization 

Seeks to establish consensus 
among groups 1918 

 

TIA/EIA 

Telecommunications Industry 
Association / Electronic 
Industries Alliance 

 

Trade associations Standards for voice and data 

 

wiring for LANs 

After the deregulation of the 
U.S. telephone industry in 
1984 


40 

Ethernet Standards 

ITE v7.0 40 

 Ethernet protocols describe the rules that control how communication occurs on 
 an Ethernet network. 
 IEEE 802.3 Ethernet standard specifies that a network implement the Carrier 
 Sense Multiple Access with Collision Detection (CSMA/CD) access control 
 method. 
 In CSMA/CD, all end stations "listen" to the network wire for clearance to send 
 data. When the end station detects that no other host is transmitting, the end 
 station will attempt to send data. Unfortunately collisions might occur. 
 Any device connected to a network is considered a host/node. 


41 

Wired and Wireless Standards  
 When Ethernet operates in half-duplex, the IEEE 802.3 standard specifies that a network 
implement the Carrier Sense Multiple Access with Collision Detection (CSMA/CD) 
access control method. 
 The 802.3 standard also specifies cable types for Ethernet including: 
• 10Base-T 
• 100Base-TX 
• 1000Base-T 
• 10GBase-T 
 The IEEE 802.11 standard specifies that wireless LANs use Carrier Sense Multiple 
Access with Collision Avoidance (CSMA/CA). 
 WLAN standards include 802.11a, 802.11b, 802.11g, 
802.11n, and 802.11ac. 
 When configuring an 802.11 WLAN, use the strongest 
encryption available. 
• Since 2006, the strongest encryption has been WPA2. 
ITE v7.0 41 


42 

Ethernet Technologies 
 10BASE-T 
• The ten (10) represents a maximum bandwidth of 10 Mbps 
• The BASE represents baseband transmission 
• The T represents twisted-pair cabling. 

ITE v7.0 42 

Ethernet Standards
Ethernet 
Standards

Media

10BASE-T 
100BASE-TX

Category 3 
Category 5

1000BASE-T Category 5e, 6

10GBASE-T Category 6a, 7

Transfer Rates

Transfers data at a rate of 10 Mb/s.
At 100 Mb/s, transfer rates of 100BASE-
TX are ten times that of 10BASE-T.
The 1000BASE-T architecture supports 
data transfer rates of 1 Gb/s.
The 10GBASE-T architecture supports 
data transfer rates of 10 Gb/s.


43 

Wireless Ethernet Standards 

ITE v7.0 43 

 IEEE 802.11 is the standard that specifies connectivity for wireless networks. 
 Wi-Fi (wireless fidelity), refers to the 802.11 family 
• 802.11 (the original specification) 
• 802.11a 
• 802.11b 
• 802.11g 
• 802.11n 
• 802.11ac 
• 802.11ad 
• These protocols specify the frequencies, speeds, and other capabilities of the 
different Wi-Fi standards. 


44 

Wireless Ethernet Standards 

ITE v7.0 44 

Bandwidth Frequency Range Interoperability 

 

802.11a Up to 54 Mbps 5 GHz band 100 feet (30 meters) Not interoperable with 802.11b, 

 

802.11g, or 802.11n 

802.11b Up to 11 Mbps 2.4 GHz band 100 feet (30 meters) Interoperable with 802.11g 

 

802.11g Up to 54 Mbps 2.4 GHz band 100 feet (30 meters) Interoperable with 802.11b 

 

802.11n Up to 540 Mbps 5 GHz and 2.4 GHz 

 

bands 164 feet (50 meters) 

 

Interoperable with 802.11b and 
802.11g 
802.11ac Up to 1.3 Gbps 5 GHz band 115 feet (35 meters) Interoperable with 802.11a and 

 

802.11n 

802.15.1 
Bluetooth Up to 2 Mbps 2.4 GHz band or 5 

 

GHz band 30 feet (10 meters) 

 

Not interoperable with any other 
802.11 


45 

Bluetooth, NFC, and RFID 
 Bluetooth 
• Up to 7 devices to create a PAN 
• 802.15.1 
• 2.4 to 2.485 GHz radio frequency range 
 RFID 
• Passive or active tags used to identify items 
– Passive – rely on RFID reader to activate and read 
– Active – have a battery to broadcast the ID up to 100 meters 
• 125 MHz to 960 MHz radio frequency range 
 NFC (Near Field Communication) 
• Devices must be in close proximity to exchange data 
• Used for payments, printing, public parking, etc. 
ITE v7.0 45 


46 

Zigbee and Z-Wave 
 Zigbee 
• Requires a ZigBee Coordinator to manage client devices connected in a 
wireless mesh network. 
• Devices commonly managed from a cell phone app 
• IEEE 802.15.4 standard 
• 868 MHz to 2.4 GHz range up to 20 meters, 65,000 
devices, and data speeds up to 250 kb/s 
 Z-Wave 
• Proprietary standard, but public version available 
• 232 devices can connect to a wireless mesh network 
with data speeds up to 100 kb/s. 

ITE v7.0 46 


47 

Cellular Generations 

ITE v7.0 47 

 1G/2G – First generation was analog calls only. 2G introduced digital voice, 
 conference calls, and caller ID with speeds less than 9.6 Kb/s 
 2.5G – supports web browsing, short audio and video clips with speeds up to 237 
 Kb/s. 
 3G – full motion video and streaming music at speeds up to 2 Mb/s 
 4G - IPv6, IP-based voice, gaming services, high quality multimedia at speeds up 
 to 672 Mb/s 
 LTE (Long Term Evolution) – means it meets the 4G speed standards and 
 improves connectivity while in motion. Speeds up to 100 Mb/s when mobile and 
 up to 1 Gb/s when stationary. 
 5G – supports augmented reality (AR), virtual reality (VR), smart homes, smart 
 cars, and data transfer between devices. Download speeds up to 3 Gb/s; upload 
 speeds up to 1.5 Gb/s. 


48 

Client – Server Roles 
 File Client and Server 
 Web Client and Server 
 Email Client and Server 

ITE v7.0 48 


49 

DHCP Server 
 A DCHP server provides IP addressing information. 

ITE v7.0 49 


50 

DNS Server 
 A DNS server translates domain names such as cisco.com to an IP address. 

ITE v7.0 50 


51 

Print Server 

ITE v7.0 51 

 A print server 
• Can control multiple printers 
• Provides client access to print resources 
• Allows centralized print job administration 
• Provides feedback to network clients 


52 

File Server 
 A file server allows clients to access files using a specific protocol 
• FTP (File Transfer Protocol) 
• FTPS (File Transfer Protocol Secure) 
• SFTP (Secure Shell File Transfer Protocol) 
• SCP (Secure Copy) 

ITE v7.0 52 


53 

Web Server 
 A web server provides web resources using these protocols 
• Hypertext Transfer Protocol (HTTP) 
 – TCP port 80 
• Secure HTTP (HTTPS) 
– Secure Sockets Layer (SSL) 
– Transport Layer Security (TLS) 
– TCP port 443 

ITE v7.0 53 


54 

Mail Server 
 Email messages are stored in databases on mail servers 
• Client communicates with server in order to reach a different client 
• Protocol used to send email 
– Simple Mail Transfer Protocol (SMTP) 
• Protocols used to retrieve email 
– Post Office Protocol (POP) 
– Internet Message Access Protocol (IMAP) 

ITE v7.0 54 


55 

Proxy Server 
 Proxy servers act on behalf of a client, thus hiding the real internal host 
 Used to cache frequently accessed web pages 

ITE v7.0 55 


56 

Authentication Server 
 Authentication, Authorization, and Accounting (AAA) - Allows access to a network 
 device or a particular network 

ITE v7.0 56 


57 

Syslog Server 
 Syslog stores network messages sent by networking devices. 
 Keeps a historical record of messages from monitored network devices. 

ITE v7.0 57 


58 

 

5.5 CHAPTER SUMMARY 

ITE v7.0 58 

