# Type of authorizations:
# - Node authorizer
# - ABAC (Authorized based authorization) set of permissions in a policy file, json based for each person or group, it required cluster restart
# - RBAC creates roles with specific permissions
# - WEBHOOK External mechanism, thrid party modes
#
# - AlwaysAllow (default)
# - AlwaysDeny

# To set the autorization mode it's neccessary to change kube-apiserver configuration
# --authorization-mode=Node, RBAC, ABAC, Webhook

# When there're multiple auth modes, it will go in all of them in the order set