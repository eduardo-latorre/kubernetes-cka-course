# The CA (Certificate Authority) certs allows to sign certification and keys
# The CA must be in a just server very secured 

# Certicate API allow to sign a (CSR) cert - Certificate Signing Request -  request through K8s
# CSI = a certificate pending to be signed

# Flow to sing a new admin cert named jane
# Create key
openssl genrsa -out jane.key 2048
# Create CSR
openssl req -new -key jane.key -subj "/CN=jane" -out jane.csr
# The admins gets the CSR and create an k8s object named CertificateSigningRequest
# Encode CSR into base64 string
cat jane.csr | base64
# Once the request is applied, you can see it by
kubectl get csr
# And then you can approve it
kubectl certificate approve jane
# To see the cert
kubectl get csr jane -o yaml

# The service that carries out all this processes is Controller Manager
# CSR-APPROVING
# CSR-SIGNING

# Lab:
# apiVersion: certificates.k8s.io/v1
# kind: CertificateSigningRequest
# metadata:
#   name: akshay
# spec:
#   groups:
#   - system:authenticated
#   request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZV3R6YUdGNU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQXNhRklielhUN2hYeVY2bVJ2YjA1VmtxM24xWko4TXI1R0hkNklDZ0RXZllyCkIwM1lIYVpaNHplMDFsMzZyOWVWTUNNRkI0bEJlNncwcWZja1pxVGx5eURVTnovRGFTUXJVNDVqbTROUEpaL2YKQklQaEN5dVlzWnNQdjlORHo1Y0ZzeFpUREI1VDk1Nk1JUU5qeXhiV1FhbzV2SkY1M1dmSEF3WTNCZlhuNkdoawpDR09mbk52MUQ3Z3gxYU9aMjN0SU5oNnFYRkZHd24vWngxWEtYR0YzSFdRcUpsZThBSDVBWEp5cGFuYUFXbkVtCnM3Wks3dUVTM3U1bXp5TUJzV2ZPMTFYS2t5dWtQam1iN0k0WmRWL2lDZ2NtL3Iva1VnNGlBRWJsR2RXK2NpWTMKcDMxNWZQeTk2blozeCtVR2lLY2EwejMwbTN4S3c0YzJYbTJHT0lxUTN3SURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBSS8xT1hBM2FOZENEV09PWmJMdnNxZVZsUkVrVVZndFhpRUJCME8vVGRRT0FHampMSEovCnA0WnEvemM5VE5oODQ3NXRBc1hYME1teWtCY1h5bnVMZURpbFl6aTM5VXAzWmdlMUJ0bEZpcU5NMzZvcTZkaXYKM2xQS2xtSGp4eXJDRGZhTW1WaWtFNHhmNFZ2c1Z5cUhDK0dINmVBTm41dmlrU2xlcUhIRU14Vyt5QThyV2diVwpaUThUMjlTeG5VcElHSnNseEJma2k3aEVmc3VRSHA3UjRoQU1DWGVKYWRwdW1rczR0cTNjTzlDOFJMTmFRcXVGCk1iYk9pemR5c29BcVpwdys5SlVzZkZrU0NtNTdMVEh3NXJBZFpQOTRCblFCTE5Oc0l2WXhWclFlNUZRQ0ZJNE8KUkVuQ2JlSHRDVzUxaVp0VHpreHFzSTFRd0JXdlBoZURtQkE9Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
#   signerName: kubernetes.io/kube-apiserver-client
#   usages:
#   - client auth
kubectl apply -f akshay-csr.yml
kubectl certificate approve akshay

kubectl get csr agent-smith -o yml
kubectl certificate deny agent-smith
kubectl delete csr agent-smith