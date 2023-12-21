# There's a technology that allows to back up the cluster Velero
# ETCD has a storage location defined in --data-dir
# ETCD has a snapshot by default
# ETCD can be local (stacked) in the controlplane node or external
# To check whether it's local or external, describe the apiserver static POD and check if the etcd endpoint is 127.0.0.1, which means is local
# How to know if it's external, there won't be a etcd pod running, if so, do the same as above and check the endpoint, should be different than local
# To create a snapshot:

# To create new backup location
service kube-apiserver stop
etcdctl snapshot restore snapshot.db --data-dir /var/lib/etcd-from-backup
systemctl daemon-reload
service etcd restart
service kube-apiserver start


# To perform al etcd commands always use certs
etcdctl --endpoints=127.0.0.1:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
snapshot save /opt/snapshot-pre-boot.db

# To make use of etcdctl for tasks such as back up and restore, make sure that you set the ETCDCTL_API to 3.
export ETCDCTL_API=3

# Lab
kubectl describe pod etcd-minikube -n kube-system | grep Image
kubectl describe pod etcd-controlplane -n kube-system | grep Image
export ETCDCTL_API=3
etcdctl --endpoints=127.0.0.1:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
snapshot save /opt/snapshot-pre-boot.db
# Restoring the backup, doesn't need certs because it's not intereacting with the etcd service
etcdctl --data-dir /var/lib/etcd-from-backup \
snapshot restore /opt/snapshot-pre-boot.db
vim /etc/kubernetes/manifests/etcd.yaml
# Changed this in the file, etcd is a static POD so once this it's updated, it wil be updated
#   volumes:
#   - hostPath:
#       path: /var/lib/etcd-from-backup
#       type: DirectoryOrCreate
#     name: etcd-data

# Lab 2
# To get the information of the cluster configures
kubectl config view
# Get number of clusters
kubectl config get-clusters
kubectl config use-context cluster1
kubectl config use-context cluster2
ssh cluster1-controlplane && logout
# To identify external etcd server
ssh cluster2-controlplane ps aux | grep etcd
ssh etcd-server
# To see the list of node (members) using the external cluster
etcdctl --endpoints=127.0.0.1:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
member list
# To findout information about etcd server, need to take a look at the running services
ps -ef | grep etcd
# Create the backup
etcdctl --endpoints=192.26.102.9:2379 \
--cacert=/etc/kubernetes/pki/etcd/ca.crt \
--cert=/etc/kubernetes/pki/etcd/server.crt \
--key=/etc/kubernetes/pki/etcd/server.key \
snapshot save /opt/cluster1.db
# Once the back is done, it should be moved to etcd-server
scp /opt/cluster1.db etcd-server:/root
# To restore the backup first, we create the env
export ETCDCTL_API=3
# then restore it
etcdctl snapshot restore /root/cluster1.db --data-dir=/var/lib/etcd-data-new
# Give permissions
chown -R etcd:etcd etcd-data-new/
# Change the data dir location from the etcd service configuration
vi /etc/systemd/system/etcd.service
# And just update this
--data-dir=/var/lib/etcd-data-new
# then
systemctl daemon-reload
service etcd restart

# in the cluster delete controlplane pod and scheduler to refresh stale data
# inside the controlplane node, restart kubelet
systemctl restart kubelet