kubectl run nginx-pod --image=nginx:alpine
kubectl run redis --labels="tier=db" --image=redis:alpine
kubectl run custom-nginx --image=nginx --port=8080
kubectl run nginx --image=nginx --dry-run=client --output=yaml
kubectl create service clusterip redis-service --tcp=6379:6379
kubectl create deployment webapp --image=kodekloud/webapp-color --replicas=3
kubectl create namespace dev-ns
kubectl create deploy redis-deploy --image=redis --replicas=2 --namespace=dev-ns
kubectl create deployment httpd-frontend --image=httpd:2.4-alpine --dry-run=client --replicas=2 --output=yaml

# Create a pod called httpd using the image httpd:alpine in the default namespace. 
# Next, create a service of type ClusterIP by the same name (httpd). The target port for the service should be 80.
kubectl run httpd --image=httpd:alpine --port=80 --expose=true