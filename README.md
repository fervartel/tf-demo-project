# Basic Terraform template with VPC and EC2 examples

## Objectives
The objective of this project is to demostrate the use of Terraform modules with AWS as provider for creating:

- VPC
- 2 Private and 2 Public subnets in 2 separate AZs
- Association of Default ACL, Route Table, Security Group
- Internet gateway
- Route Table creation and association for both PRI and PUB subnets
- Single EC2 instance deployment

## Requirements

- [AWS account](https://aws.amazon.com/free/)
- [Terraform](https://www.terraform.io/)

## Advantages
The main advantage of using Terraform as IaC provider is the fact of being Cloud agnostic with support for multiple Cloud (as other services) providers.