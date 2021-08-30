ADD)

# create veth pair
ip link add  via 

#Attach veth pair
ip link set

#assign ip address
ip -n <namespace> addr add
ip -n <namespace> route add

#bring up interface
ip -n <namespace> link set

DEL)
ip link del
