data "aws_instance" "ec2" {
  filter {
    name   = "tag:eks:nodegroup-name"
    values = ["tech-challenge-node-group"]
  }
}
