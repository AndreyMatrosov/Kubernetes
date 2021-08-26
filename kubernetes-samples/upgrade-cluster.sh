#!/usr/env/bin bash
apt update
apt-cache madison kubeadm

apt-mark unhold kubeadm 
apt-get update && apt-get install -y kubeadm=1.20.0-00 
kubeadm upgrade apply v1.20.0 -y
apt-mark hold kubeadm

kubectl drain controlplane --ignore-daemonsets

apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.20.0-00 kubectl=1.20.0-0 && \
apt-mark hold kubelet kubectl

sudo systemctl daemon-reload
sudo systemctl restart kubelet

# on the worker node

apt update
apt install kubeadm=1.20.0-00
kubeadm upgrade node
apt install kubelet=1.20.0-00 This will update the kubelet with the version 1.20.
systemctl restart kubelet

#take a snapshot of etcd
etcdctl snapshot save -h
Since our ETCD database is TLS-Enabled, the following options are mandatory:

--cacert                                                verify certificates of TLS-enabled secure servers using this CA bundle

--cert                                                    identify secure client using this TLS certificate file

--endpoints=[127.0.0.1:2379]          This is the default as ETCD is running on master node and exposed on localhost 2379.

--key                                                      identify secure client using this TLS key file

etcdctl snapshot restore -h

# snapshot example

ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
snapshot save /opt/snapshot-pre-boot.db


# Here's a quick tip.
# In the exam, you won't know if what you did is correct or not as in the practice tests in this course. 
# You must verify your work yourself. 
# For example, if the question is to create a pod with a specific image, 
# you must run the the #
kubectl describe pod
# command to verify the pod is created with the correct name and correct image.
