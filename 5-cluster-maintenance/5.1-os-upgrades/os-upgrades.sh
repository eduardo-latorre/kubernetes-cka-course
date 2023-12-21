# If a node is down for 5 minutes (default) k8s will consider them as dead and recreate them in other nodes
# When a node is uncordon it will host only new pods
# IF there's no replicaset for PODs, Node can't be drained
# Minikube doesn't allow to multiple nodes, is just one
# This is how is set in the master node the amount of time "eviction time" 
kube-controller-manager --pod-eviction-timeout=5m0s

# To move the pods from a node to others and the node is considered by k8s as unschedulable
kubectl drain <node-name>

# Don't move the pods but marks the node unschedulable with affeccting the POD
kubectl cordon <node-name>

# set it back as schedulable
kubectl uncordon <node-name>

# Lab
# - alias k=kubectl
# - kubectl get pods -o wide
# - kubectl drain node01 --ignore-daemonsets