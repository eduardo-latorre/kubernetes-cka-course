# All the components in k8s have different versions
# All the supported versions of only 3 backwards, from the forth and onwards are unsupported
# Upgrade only to one version at a time
# 1.- Upgrade Master Node
# 2.- Upgrade Worker Nodes
# Estrategies for Worker Nodes:
#   2.1.- Upgrade all the Nodes, but they will down for a while
#   2.2.- Upgrade one by one, the workload will be spread other nodes in the meanwhile
#   2.3.- Create new Nodes and decomision the olds ones (best approach for a cloud)

# Commands to upgrade Master Node
# To show the current version in details
# - kubeadm upgrade plan
# First upgrade kubeadm
# - apt-get upgrade -y kubeadm=1.12.0-00
# - kubeadm upgrade apply 1.12.0-00
# Upgrade kubelet then
# - apt-get upgrade -y kubelet=1.12.0-00
# - systemctl restart kubelet
# Check now the new version
# - kubectl get nodes

# Commands to upgrade Worker Nodes 1 by 1
# - kubectl drain node01
# - apt-get upgrade -y kubeadm=1.12.0-00
# - apt-get upgrade -y kubelet=1.12.0-00
# - kubeadm upgrade node config --kubelet-version 1.12.0-00
# - systemctl restart kubelet
# - kubectl uncordon node01

# Lab:
# - kubectl drain controlplane --ignore-daemonsets
# All PODS are now in other nodes
# - kubectl get pods -o wide
# - apt update
# - apt-get install -y kubeadm=1.27.0-00
# - kubeadm upgrade apply v1.27.0
# - apt-get install -y kubelet=1.27.0-00 
# - systemctl daemon-reload
# - systemctl restart kubelet

# - kubectl drain node01 --ignore-daemonsets
# - apt-get install -y kubeadm=1.27.0-00
# - kubeadm upgrade node
# - apt-mark unhold kubelet 
# - apt-get install -y kubelet=1.27.0-00 
# - kubeadm upgrade node config --kubelet-version 1.27.0-00
# - systemctl daemon-reload
# - systemctl restart kubelet