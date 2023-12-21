# Each server needs a cert and a key, Certificate Authority (CA)
# - Admin
# - Kube-Scheduler              ---> Kube-Api-Server
# - Kube-Controller-Manager     ---> Kube-Api-Server
# - Kube-Proxy                  ---> Kube-Api-Server

# - Kube-Api-Server             ---> ETCD
# - Kube-Api-Server             <--> Kubelet Server

# Technologies that allows to create certificates:
# - EASYRSA - OPENSSL - CFSSL

# Using OPENSSL

# Admin User
# - Key:
openssl genrsa -out admin.key 2048
# - Certificate Signing Request, CN = certificate name, O group with admin privileges within the k8s cluster
openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:master" -out admin.csr
# Sign Certificate (CA)
openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt

# Kube-Scheduler, Kube-Controller-Manager and Kube-Proxy
# - Same steps as above but replace -subj, do the same for these three
openssl req -new -key scheduler.key -subj "/CN=scheduler/O=system:kube-scheduler" -out scheduler.csr

# Kube API Server
# - Key:
openssl genrsa -out apiserver.key 2048
# - Certificate Signing Request must contain all the names of Kube-Api-Server in a file (check openssl.cnf file)
openssl req -new -key apiserver.key -subj "/CN=kube-apiserver" -out apiserver.csr --config openssl.cnf
# Sign Certificate (CA)
openssl x509 -req -in apiserver.csr -CA ca.crt -CAkey ca.key -out apiserver.crt
# To pass the cert and keys: ExecStart config (edit the static pod)

# Check TLS Certificates
# kube-apiserver, check the static pod from control plane
# cat /etc/kubernetes/manifest/kube-apiserver.yml
# You'll get all the cert locations, like tls, ca, and others. Once location found, run the command bellow:
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout
# An additional way to find this information is by checking pods logs or docker if kubeadmin commands ain't working 


# Lab:
# Check containers, since kubectl doesn't work
crictl ps -a | grep kube-apiserver
crictl logs --tail=2 1fb242055cff8

# The etcd-ca cert from kube-apiserver wasn't right since etcd has its own cert so it was using /etc/kubernetes/pki/ca.crt
# Need to make a change to use the one under etcd instead
/etc/kubernetes/manifests/kube-apiserver.yaml
--etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt