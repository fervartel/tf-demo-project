# Terraform template with VPC, ELB and ASG

## Objectives
The objective of this project is to demostrate how to use Terraform modules with AWS for creating:

- VPC
- 2 Private and 2 Public subnets in 2 separate AZs
- Association of Default ACL, Route Table, Security Group
- Internet gateway
- Route Table creation and association for both PRI and PUB subnets
- Auto-Scaling group
- Application Load Balancer

## Requirements

- [AWS account](https://aws.amazon.com/free/)
- [Terraform](https://www.terraform.io/)
- [tf-modules](https://github.com/fervartel/tf-modules)

## Advantages
The main advantage of using Terraform as IaC provider is the fact of being Cloud agnostic with support for multiple Cloud (as other services) providers.