# When roles are created without specifying namespace, it'll be created in default namespace
# Roles can be categorized under:
# - Namespaces
# - Cluster scoped (next chapter)

# To create the Role, check the rol-template.yml
kubectl create -f rol-template.yml

# Then the role needs to be bound to rol-bind-template.yml, namespace default
kubectl create -f rol-bind-template.yml 

# Get roles information
kubectl get roles
kubectl get rolebindings
kubectl describe role <role-name>
kubectl describe rolebindings <role-binding-name>

# Check access (This will be from admin)
kubectl auth can-i create deployments
kubectl auth can-i delete nodes

# To check from a specific user
kubectl auth can-i delete nodes --as dev-user
kubectl auth can-i delete nodes --as dev-user -namespace test

# Lab
kubectl get roles -A
kubectl describe role kube-proxy -n kube-system
# To get who is asigned to this role
kubectl describe rolebinding kube-proxy -n kube-system

kubectl auth can-i get pods --as dev-user

# Add permision through resources
kubectl edit role developer -n blue