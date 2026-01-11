#!/bin/bash

# 1. Generate a unique bucket name and store it in a variable
BUCKET_NAME="nt548-terraform-state-$(date +%s)"

# 2. Create the S3 bucket
echo "Creating bucket: $BUCKET_NAME"
aws s3 mb s3://$BUCKET_NAME --region us-east-1

# 3. Enable versioning for the created bucket 
aws s3api put-bucket-versioning \
  --bucket $BUCKET_NAME \
  --versioning-configuration Status=Enabled

# 4. Create DynamoDB table (add '|| true' to ignore error if table already exists)
echo "Creating DynamoDB table..."
aws dynamodb create-table \
  --table-name terraform-state-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1 || true

echo "Setup complete! Bucket name: $BUCKET_NAME"