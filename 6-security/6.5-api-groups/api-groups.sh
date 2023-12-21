# To check the master node info
curl https://kube-master:6443/version

# To check the pods running
curl https://kube-master:6443/api/v1/pods

# API group
# /metrics
# /healthz
# /version
# /api -> core
# /apis -> named
# /logs

# Group: /api/v1
# Resources: namespaces - pods, rc, events, endpoints, nodes, secrets, services, configmaps, PV, PVC, bindings
# Verbs: get, list, create, delete...

# All the new stuff comes under this group
# /apis/
# /apps - /extensions - /networking.k8s.io - /certificates.k8s.io

# To see all the groups
curl http://localhost:6443 -k

# To see all the resources from each group
curl http://localhost:6443/apis -k

# To access these there're two ways
# 1.- To access by using key and cert
curl http://localhost:6443 -k \
    --key admin.key \
    --cert admin.crt \
    --cacert ca.crt
# 2.- Using a proxy
kubectl proxy

# kubeproxy and kubectl are not the same
