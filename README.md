
# Hello World App for Boeing
============================

## Assumptions

- App must live in VPC with proper network architecture
- Terraform is used for cloud agnostic purposes
- High-Availability is ok in single region (this is bad practice in real non-contrived situations)
- I will use all AWS services

## General Info

- You can find all infrastructure code in the terraform folder
- Instance provisioning is done via cloud-init
- The microservice is written in python
- Python test environment provided by tox
- Testing can be run locally after app is installed, or pushed into AWS CodeBuild (WIP)
- Deploying is done with AWS Code Pipeline (WIP)
- Make is used as the build system
- Infrastructure is provisioned into an AWS AutoScaling group
- There is an ELB servicing the AutoScaling Group
- There is a security group around the instances that only allow web traffic
- Everything is contained in a VPC with a single public subnet in us-east-1a

## Things I would do differently given proper planning and time

- Use jenkins instead of code build
- Green/Blue deploys instead of rolling deploys to improve deploy confidence
- Chef or Ansible provisioning instead of Bash
- Multi-region high-availability using ELB and Route53 Latency based routing
- The introduction of real config management would also make the possibility of configuring environments much more realistic
- Everything is currently based around VM architecture, whereas Docker is much better for internal environments, and given proper scheduling, is very powerful in production
- Introducing global feature flagging would allow for Continuous Deployment, as you would be able to turn on/off code in production from an interface of some kind, allowing us to safely commit continuously
