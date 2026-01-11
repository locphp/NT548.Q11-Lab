#!/bin/bash

echo "========================================="
echo "Safe Infrastructure Destroy Script"
echo "========================================="
echo ""
echo "This script will destroy resources in the correct order"
echo "to avoid dependency issues."
echo ""

read -p "Are you sure you want to destroy all infrastructure? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Destroy cancelled."
    exit 0
fi

echo ""
echo "Step 1: Destroying EC2 instances..."
terraform destroy -target=module.ec2 -auto-approve

echo ""
echo "Step 2: Destroying Security Groups..."
terraform destroy -target=module.security_group -auto-approve

echo ""
echo "Step 3: Destroying NAT Gateway..."
terraform destroy -target=module.NAT -auto-approve

echo ""
echo "Step 4: Destroying Route Tables..."
terraform destroy -target=module.Route_Table -auto-approve

echo ""
echo "Step 5: Destroying remaining resources..."
terraform destroy -auto-approve

echo ""
echo "========================================="
echo "Infrastructure destroyed successfully!"
echo "========================================="
