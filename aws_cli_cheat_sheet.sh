# AWS CLI Cheat Sheet
# Randome collection of commands I have needed to use
# https://docs.aws.amazon.com/cli/latest/reference/
# https://docs.aws.amazon.com/cli/latest/reference/ec2/index.htm
# Create a ec2 key Pair
aws ec2 create-key-pair --key-name 2302-academy-aviator-key --query 'KeyMaterial' --output text > 2302-academy-aviator.pem

# Create an ec2 key pair and download it.
aws ec2 create-key-pair --key-name 2302-academy-aviator --query 'KeyMaterial' --output text > 2302-academy-aviator.pem && chmod 400 2302-academy-aviator.pem

# Check for the AMI Images that you can run as self
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
aws ec2 describe-images --owners self
aws ec2 describe-images --executable-users self 

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
