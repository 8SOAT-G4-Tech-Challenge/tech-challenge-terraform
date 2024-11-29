provider "kubernetes" {
  #   alias = "aws"
    # host                   = data.outputs.eks_cluster_endpoint
    # cluster_ca_certificate = base64decode(data.kubeconfig-certificate-authority-data)
  #   token                  = data.aws_eks_cluster_auth.default.token
  #   alias = "aws"
  host                   = "https://3601050214C19FCE74538E8E95B851AA.gr7.us-east-1.eks.amazonaws.com"
  cluster_ca_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJT1VEOHZaY3c1NHd3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRFeE1qWXdNVEk1TURoYUZ3MHpOREV4TWpRd01UTTBNRGhhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUNzYWszQ2lKKytRZm0rcGxucmVpdWwxcEo0aURhY2pyUTlYemxuR0h5ZS9aeEhIeXNzNkE0anZGYjMKZU9UbE5nblRVZzlmYyswREN3UlpCRkxJdU1zc0NUOVhHdlNKQ0EvOHlURUJtNmhqSDBzSG1yQUpzQUVpWXFpRgorTzArVTFzY1dNYnRhc3Yzb1NFUmprNm0rOE9sOFV2Sk5UdUtXek4xNTRIMVA1dWV6NEZ3dXRwOHVrSVJTNGpZClp2MWtKSVo0SnJIaUFNYndYeVR3czVhTi9JRytrd3R0Q1FEZUhqRTUyYUJOQXdWaVVpVGlNSmZ2b2poczdneHIKMy9OK2RyS1REU2t6SVAzSXhRUzBwRFJYbkRjSTZaRlUvTTBNbWhwRmlpK3hZaXRiS2kwbm9oaTYxSlNKdEZiNQo4bng5THFaWkJ1N1FvSGZiYXFOVlYzSnlPcE9iQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJSSzNKWHNkemw5eEpjNWM1Q0RiUVpCUUZNZW5UQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQ1ZoQlFVNUJyTwp4STNkcElMSm5QdXpaZ01ETGFFKysydFZlWmpvcTlQVnFYbmYxa3AxUXZPRnJOcjVmYWRuU3dsamo1eTRoZmloCjQ1TDlOMG5oMWI4ditOZ2VSMlhJWWtWdmExSWVGVVNNYldTVWhqNEUvU3UyMks2THN1U2xZSWJHQ3pMdW1KZFAKdCthbThXNnFDSWxPZURzaUVKMnVRZEl6ZjN2djRyNUF6cDhoZVVlRmJJdHBiZGo1WHUvWXIvYjJiREk2eExFUgpXUVMwMFFJNnE2QnZHNjJZcURyUUcyMHpzQzM5RUlXSGpvQUx6THp1RjJkVnVHVjlFY2dLYyt5bU5kMFA2RVdDCkg1RFRLS0Y2MGJFV0xESTlJUFBWaEhvNklCQlU0T2xLVUVzZFR5QkpTb3RPOGh0WkllZStqWllHS29GTWFuaDQKeEVFNzVHc2lBdGFDCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K")
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
  # host = "https://1DCF6264042592C258F486877FCE0E73.gr7.us-east-1.eks.amazonaws.com"
  # client_certificate     = file("~/.kube/client-cert.pem")
  # client_key             = file("~/.kube/client-key.pem")
  # cluster_ca_certificate = file("~/.kube/cluster-ca-cert.pem")
}