# This is not a recommended way!!

# This should be passed as a file to kube-apiserver
# specifying in the 
--basic-auth-file=user-details.csv
# So it can be done by updating static POD on /etc/kubernetes/manifest/kube-apiserver.yml file, adding the option above
# Once the POD is restarted run:
curl -v -k https://master-node-ip:6443/api/v1/pods -u "user1:password123"

# For Token file
--token-auth-file=user-token-details.csv
# To authentica
curl -v -k https://master-node-ip:6443/api/v1/pods --header "Authorization: Bearer <token>"

# This should consider a volumen