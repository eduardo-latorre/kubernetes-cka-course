# Cluster scoped 

# Cluster scoped are NOT part of Namespaces, so it's no possible to specify namespace or filter by it

# Namespaces -> pods, rs, deployments, confgimaps, roles, rolebindings
# Cluster scoped -> nodes, namespaces, clusterrole, clusterrolebinding, certificaterequests

# To get the resources
kubectl api-resources --namespaced=true
kubectl api-resources --namespaced=false

# Lab
kubectl get clusterroles | wc -l # wc: words count command, -l stands for lines
kubectl get clusterrolebindings | wc -l

# Differences between list and get verbs in k8s??