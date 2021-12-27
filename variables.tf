variable "install_karpenter" {
  type        = bool
  default     = false
  description = "Whether to install Karpenter autoscaler for EKS."
}


variable "oidc_url" {
  description = "OIDC url of the EKS cluster. Needed for Karpenter ServiceAccount."
  type        = string
}



variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint."
  type        = string
}



variable "subnet_name_selector" {
  type        = string
  default     = null
  description = "String to match subnet names to place Karpenter autoscaling nodes. Won't be used if not specified."
}

variable "subnet_tag_selector" {
  type = list(object({
    key   = string
    value = string
  }))
  default     = null
  description = "key/value pair list pass to provisioner to filter the subnets."
}

variable "instance_profile_name" {
  type        = string
  description = "IAM instance profile name to assign to autoscaled worker nodes. Mandatory."
}

variable "ec2_tags" {
  type = list(object({
    key   = string
    value = string
  }))
  default     = null
  description = "key/value pair list of tags to apply to launched EC2 worker nodes."
}

variable "launch_template_name" {
  type        = string
  default     = null
  description = "Launch template to use when spawning worker nodes."
}

variable "instance_types" {
  type = list(string)
  default = [
    "t3.medium",
    "t3.large",
    "t3.xlarge"
  ]
  description = "Instance types available to deployment as worker nodes."
}

variable "capacity_types" {
  type = list(string)
  default = [
    "on-demand"
  ]
  description = "Capacity type - on-demand, spot, or both."
}

variable "arch" {
  description = "Architecture. amd64 or arm."
  default     = "amd64"
  type        = string
}

variable "ttl_after_empty" {
  description = "TTL of the node after no load is running on it."
  type        = number
  default     = 30
}