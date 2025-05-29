def GetUbuntuIPAddress():
    import socket
    import fcntl
    import struct
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,  # SIOCGIFADDR
        struct.pack('256s', 'eth0'[:15])
    )[20:24])

import socket
import fcntl
import struct

def get_ip_address():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,  # SIOCGIFADDR
        struct.pack('256s', 'eth0'[:15])
    )[20:24])




    
# function that says "Hello world," personalized to the user's name
def hello(name):
    print("Hello " + name + "!")
    print("Your IP address is " + GetUbuntuIPAddress() + ".")
    print("Your computer name is " + socket.gethostname() + ".")
    print("Your operating system is " + platform.system() + ".")
    print("Your Python version is " + platform.python_version() + ".")
    print("Your Python executable is " + sys.executable + ".")
    print("Your Python path is " + sys.path[0] + ".")


