module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.3"

  name = "vpc_sta2"
  cidr = "172.16.0.0/16"

  azs             = ["ca-central-1a", "ca-central-1b"]
  private_subnets = ["172.16.0.0/21", "172.16.8.0/21"]
  public_subnets  = ["172.16.168.0/22", "172.16.172.0/22"]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = "staging",
  }

  public_subnet_tags = {
    Environment                    = "staging"
    Name                           = "staging-base-networkPublicAZ1"
    ServiceProvider                = "Rackspace"
    "karpenter.sh/discovery"       = "eks_sta2"
    "kubernetes.io/cluster/eks_sta2" = "shared"
    "kubernetes.io/role/elb"       = "1"
    "karpenter.sh/discovery" = "eks_sta2"
  }

  private_subnet_tags = {
    Environment                       = "staging"
    Name                              = "staging-base-networkPrivateAZ2"
    ServiceProvider                   = "Rackspace"
    "karpenter.sh/discovery"          = "eks_sta2"
    "kubernetes.io/cluster/eks_sta2"    = "shared"
    "kubernetes.io/role/internal-elb" = "1"
    "karpenter.sh/discovery" = "eks_sta2"
    network                           = "private"
  }
}