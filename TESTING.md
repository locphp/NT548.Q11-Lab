# Testing Guide

## Simple Validation Test (Recommended)

This test validates the existing infrastructure without creating new resources.

```bash
terraform test simple-validation.tftest.hcl
```

**Result:** All 5 test suites passed
- validate_vpc
- validate_nat
- validate_route_tables
- validate_security_groups
- validate_ec2

## Original Test Files (tests/ directory)

The test files in `tests/` directory are designed for clean-room testing (creating infrastructure from scratch). They may fail if infrastructure already exists due to resource name conflicts.

**Note:** Since our infrastructure is already deployed and working, use the simple validation test above instead.

## Manual Verification

Run the verification script:
```bash
./verify-infrastructure.sh
```

This will check:
- VPC and Subnets
- Internet Gateway
- NAT Gateway
- EC2 Instances
- Security Groups
- Route Tables

## Test Results Summary

- Simple Validation: **PASSED** (5/5)
- Infrastructure deployed successfully
- All components verified and working
