# STEPS TO CREATING AN EKS CLUSTER WITH NODE GROUPS
- Define the iam role for your clusters. 
  -  Policies included in your role include:
     - AmazonEKSClusterPolicy
     - AmazonEKSVPCResourceController. " optional to enable Security Groups for Pods"

-  Define the iam role for your node groups.
    -  Policies included in your role include:
       - AmazonEKSWorkerNodePolicy.
       - AmazonEKS_CNI_Policy.
       - AmazonEC2ContainerRegistryReadOnly.

- Define cluster inside vpc. for this model i used a custom created vpc module. [custom vpc:](https://github.com/Einsteiniumeinsteinian/vpc-module-terraform)
- Define eks resource and configure roles, versions and vpc. 
- Define your node group resource and specify configurations and dependencies. 