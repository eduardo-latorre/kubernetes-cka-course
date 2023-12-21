# To check kube cluster
curl https://my-kube-playground:6443/api/v1/pods \
--key admin.key
--cert admin.crt
--cacert ca.crt

# This is the setup used by kubectl commands, so to avoid 
# specifying key and certs in a command, the following file is used
# The KubeConfig file is specfied in a env variable
$HOME/.kube/config

# The file specifies three concepts:
# Cluster <-> Context <-> Admin
# Context section allows to link between Cluster and Admin
# This command is used to check the default config file
kubectl config view

# To check an specific config file
kubectl config view --kubeconfig=my-custom-config

# To chage the context, example
kubectl config use-context prod-user@production

# To check other options of config
kubectl config -h

# Context can have multiple namespaces as well

# The KubeConfig file can either have the full path to the ca.crt or
# it can be manually passed the entire cert encoded by base64 algorithm
# in the config file use field: certificate-authority-data to pass the cert
# encoded

# Lab