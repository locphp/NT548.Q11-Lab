# Lab1_Infrastructure - NT548 DevOps Practice update

## Project Description
AWS infrastructure deployment practice using Terraform, including:
- VPC with Public and Private Subnets
- Internet Gateway and NAT Gateway
- Route Tables for Public and Private subnets
- EC2 instances (Public and Private)
- Security Groups for security control

## System Architecture
```
VPC (10.0.0.0/16)
├── Public Subnet (10.0.1.0/24)
│   ├── Internet Gateway
│   ├── NAT Gateway
│   └── EC2 Public Instance
└── Private Subnet (10.0.2.0/24)
    └── EC2 Private Instance
```

## Module Structure
```
Lab1_Infrastructure/
├── modules/
│   ├── Vpc/              # VPC, Subnets, Internet Gateway
│   ├── NAT-Gateway/      # NAT Gateway and Elastic IP
│   ├── Route-Tables/     # Public and Private Route Tables
│   ├── EC2/              # EC2 Instances and SSH Key
│   └── Security-Groups/  # Security Groups
├── tests/                # Test cases
└── scripts/              # Setup scripts
```

## Installation Guide

### 1. Configure AWS Credentials
```bash
aws configure
```
Enter the following information:
- AWS Access Key ID
- AWS Secret Access Key  
- Default region: us-east-1
- Output format: json

### 2. Configure Variables
```bash
cp terraform.tfvars.example terraform.tfvars
```
Edit `terraform.tfvars` with your information:
- `vpc_cidr`: CIDR block for VPC
- `allowed_ip`: IP address allowed to SSH into Public instance
- `key_name`: SSH key pair name

### 3. Create S3 Backend
```bash
chmod +x scripts/setup-backend.sh
./scripts/setup-backend.sh
```
**Note**: Update S3 bucket name in `backend.tf` if needed

### 4. Initialize and Deploy
```bash
# Initialize Terraform
terraform init

# View deployment plan
terraform plan

# Deploy infrastructure
terraform apply -auto-approve
```

## Verification

After successful deployment, verify the infrastructure:

### Option 1: View Outputs
```bash
terraform output
```

### Option 2: Run Validation Test (Recommended)
```bash
# Run simple validation test (does not create new resources)
terraform test simple-validation.tftest.hcl
```
This test validates existing infrastructure without creating duplicates.

### Option 3: SSH Connection Test
```bash
# Get public IP from outputs
PUBLIC_IP=$(terraform output -json | jq -r '.EC2.value.public_instance_public_ip')

# Connect to public instance
ssh -i my_key.pem ubuntu@$PUBLIC_IP
```

## Test Cases

**Important:** The test files in `tests/` directory are for clean-room testing (deploying from scratch). Do NOT run them after infrastructure is already deployed as they will try to create duplicate resources.

For deployed infrastructure, use:
- `simple-validation.tftest.hcl` - Validates existing resources

See [TESTING.md](TESTING.md) for detailed testing guide.

## Cleanup
```bash
terraform destroy -auto-approve
```

## Notes
- File `my_key.pem` will be automatically created for SSH access to instances
- Ensure your IP is added to `allowed_ip` in `terraform.tfvars`
- Sensitive files (`.terraform/`, `*.tfstate`, `terraform.tfvars`) are already gitignored

