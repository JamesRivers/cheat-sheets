# AWS CLI Cheat Sheet
# Random collection of commands I have needed to use
# https://docs.aws.amazon.com/cli/latest/reference/
# https://docs.aws.amazon.com/cli/latest/reference/ec2/index.htm
# Create a ec2 key Pair
aws ec2 create-key-pair --key-name 2302-academy-aviator-key --query 'KeyMaterial' --output text > 2302-academy-aviator.pem

# AWS show keypairs
aws ec2 describ/-key-pairs --query 'KeyPairs[*].KeyName' --output table

# Create an ec2 key pair and download it.
aws ec2 create-key-pair --key-name 2302-academy-aviator --query 'KeyMaterial' --output text > 2302-academy-aviator.pem && chmod 400 2302-academy-aviator.pem

# Check for the AMI Images that you can run as self
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
aws ec2 describe-images --owners self
aws ec2 describe-images --executable-users self --output table
## Check AMI Images excuetable by self and only show names
aws ec2 describe-images --executable-users self --query 'Images[*].Name' --output table
# AWS show tag value for ami   
aws ec2 describe-images --image-ids ami-0a0a0a0a0a0a0a0a0 --query 'Images[*].Tags[?Key==`Name`].Value[]' --output text
# AWS show all tag names for an ami
aws ec2 describe-images --image-ids ami-0a0a0a0a0a0a0a0a0 --query 'Images[*].Tags[*].Key' --output text
#AWS set new tag name and value for an ami
aws ec2 create-tags --resources ami-0a0a0a0a0a0a0a0a0 --tags Key=Name,Value=2302-academy-aviator-ami
# AWS show tags and values for an ami
aws ec2 describe-images --image-ids ami-0a0a0a0a0a0a0a0a0 --query 'Images[*].Tags[*].[Key,Value]' --output table
# AWS copy ami to another account and preserver the ami tags
# Delete AWS eni network interface
aws ec2 delete-network-interface --network-interface-id eni1a0a0a0a0a0a0a0a0

# AWS show ec2 instances
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PrivateIpAddress,PublicIpAddress,KeyName,LaunchTime,Tags[?Key==`Name`].Value[]]' --output table

# AWS show Ec2 instance with tag for environment being the word training
aws ec2 describe-instances --filters "Name=tag:environment,Values=training" --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PrivateIpAddress,PublicIpAddress,KeyName,LaunchTime,Tags[?Key==`Name`].Value[]]' --output table

# AWS Show account ID
aws sts get-caller-identity --query 'Account' --output text

# AWS show all the IAM roles for a certain user
aws iam list-roles --query 'Roles[*].RoleName' --output table

# AWS IAM Role get role 
aws iam get-role --role-name ic-bastion-role-academy-aviator-2302 --output table

# AWS IAM Role Assume Role Policy Document
# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html
aws iam update-assume-role-policy --role-name ic-bastion-role-academy-aviator-2302 --policy-document file://trust-policy.json 

# Sow AWS EC2 Running Instances
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PrivateIpAddress,PublicIpAddress,KeyName,LaunchTime,Tags[?Key==`Name`].Value[]]' --output table
# Show AWS Instances with Environment Tag
aws ec2 describe-instances --filters "Name=tag:Environment,Values=training" --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PrivateIpAddress,PublicIpAddress,KeyName,LaunchTime,Tags[?Key==`Name`].Value[]]' --output table

# AWS show domains for Route53
aws route53 list-hosted-zones --query 'HostedZones[*].Name' --output table

# AWS show host zone id for a domain
aws route53 list-hosted-zones --query 'HostedZones[?Name==`imagineacademy.tv.`].Id' --output text

# AWS show Media Convert endpoints
aws mediaconvert describe-endpoints --query 'Endpoints[*].Url' --output table

# AWS Show profiles 
aws configure list-profiles

# AWS Show VPCs
aws ec2 describe-vpcs --query 'Vpcs[*].VpcId' --output table

# AWS Show VPC names and IDs
aws ec2 describe-vpcs --query 'Vpcs[*].[VpcId,Tags[?Key==`Name`].Value[]]' --output table

# AWS show subnets and network ACLs for a VPC
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-05304c8001fe00777" --query 'Subnets[*].[SubnetId,Tags[?Key==`Name`].Value[],NetworkAclAssociationSet[0].NetworkAclId]' --output table

# AWS show subnet addresses for a VPC
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-05304c8001fe00777" --query 'Subnets[*].[SubnetId,Tags[?Key==`Name`].Value[],CidrBlock]' --output table

# AWS show s3 buckets
aws s3 ls

# AWS Show dynamoDB tables
aws dynamodb list-tables --query 'TableNames[*]' --output table

# AWS delete dynamoDB table
aws dynamodb delete-table --table-name ic-2302-academy-aviator
