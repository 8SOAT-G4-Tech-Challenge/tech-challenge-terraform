provider "kubernetes" {
  #   alias = "aws"
  #   host                   = data.outputs.eks_cluster_endpoint
  #   cluster_ca_certificate = base64decode(data.kubeconfig-certificate-authority-data)
  #   token                  = data.aws_eks_cluster_auth.default.token
  #   alias = "aws"
  host                   = "https://1DCF6264042592C258F486877FCE0E73.gr7.us-east-1.eks.amazonaws.com"
  cluster_ca_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJWlg1cTltYVJ6dnN3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRFeE1qTXhOREU1TkRoYUZ3MHpOREV4TWpFeE5ESTBORGhhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURBL3BkUlR4cVlxS0ZsV1U1akdzRmlURzJ3SUZDYituQW9zUHJFYjhDaTZra0xzMGpMZFpialhyT1gKV0lvZE1HQVVkR0t1Y2xBYXNTaEEvQ1h3S0cybnc3UDZQbWZibTFXT3kzOWhFNFZ2WGFXcGZzdWR4RW52NFplQQpOa25LaU42OU5aakNIVTFRTTZyeFdhTmRJL05QZlgzb2lWY2x0RXdtYURLdiszUjVveVBnWmxPcTBaQVl1dG1BClQrSXUzRkdqNm9qQXEyeXgzRm1xeTZUWlJVSWNscXk1MnVTTmI0VkxyRDhTTTVHTXBKaXJWTTRNUXNEbVpCbmUKemVDc1hEQU9HS211WHQ3Y2hhTXpmbUF6Y2V1QzQwR01Zd2duMkptckxZbmRwaEZvK0wwOHdYNTBkb25IR0pGUwpYcFp5Q0RycEgyTnhTQWVHSCtYU1VCRmJheDRaQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJTWXA1aU5aVCtZZGl4cjBzVU5JcTNFdGs2QkdqQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQzBGcVZrU3J3RwpIQkdqMjMvY1plRTN4Q3gxR2RwL1JPeGtDTG1EbE5Ca2Mxa082S1FzQXRHbTBNNUtFQW1MU2V5ZjFkbkNaODJNCnhQTGFXUjJJOVo4YWVDWmlGcnUzV2tha0l1YVJWakhxbDZvdVAxYnNONUVjZTFSM2h1UnZNaGs0WVpDcFhBYnkKalJQUzIvU2NFN05yVitaaHF2R1pmRXpPQWZJM3Z0K0doSzVIdTFBdkdoVHBIY3FSRjNETUV2bjhMQjdBRmJzUAo3NVQxbTVIVnMyb1U3YlRhS0xlc1JVNSsxYTU2VG1ETzAxODd3dVBBN2tlTmlmVXFnMFRldUh4WVBTVkMxVVRJCkZjdkFFdHFSUG5zMVVGcGU2S001Z3BPTWRlY2Z1NGFPNjJKVEpuc2VpK3I4VnFRQVc3NngvSFg1Y2ZkalJoWjgKNnFaUWVzbWMzOFBJCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K")
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