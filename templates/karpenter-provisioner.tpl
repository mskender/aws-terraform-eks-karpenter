apiVersion: karpenter.sh/v1alpha5
kind: Provisioner
metadata:
  name: ${provisioner_name}
spec:
  requirements:
    - key: karpenter.sh/capacity-type
      operator: In
      values: [
        ${capacity_types}
        ]
    - key: node.kubernetes.io/instance-type
      operator: In
      values: [
        ${instance_types}
      ]
    - key: kubernetes.io/arch
      operator: In
      values: [ ${arch} ]      
  provider:
    instanceProfile: "${instance_profile}"
%{ if launch_template_name != null }
    instanceProfile: ${launch_template_name}
%{ endif }
%{ if subnet_name_selector  != null ||  subnet_tag_selector != null }
    subnetSelector:
%{ if subnet_name_selector != null }
      Name: "${subnet_name_selector}"
%{ endif }
%{ if subnet_tag_selector != null }
%{ for kv in subnet_tag_selector }
      ${kv.key}: "${kv.value}"
%{ endfor }
%{ endif }
%{ endif }
%{ if ec2_tags != null }
    tags:
%{ for kv in ec2_tags}
      ${kv.key}: "${kv.value}"
%{ endfor }
%{ endif }
  ttlSecondsAfterEmpty: ${ttl_after_empty}