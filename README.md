
# Hello World App for Boeing

## Assumptions

- App must live in VPC with proper network architecture
- Terraform is used for cloud agnostic purposes
- High-Availability is ok in single region (this is bad practice in real non-contrived situations)
- I will use all AWS services
- I will not use OpsWorks, or Elastic Beanstalk, those are too easy, and don't show an understanding of the underlying principals. I realize this might affect the outcome,
  but should be effective in showing a deeper understanding of how these technologies are built and used.

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

## Items not integrated that were planned
- Cloudwatch for CPU metric to autoscale
- Application logging to ElasticSearch Service

## Things I would do differently given proper planning and time

- Vagrant or docker for local dev env
- Use jenkins instead of code build
- Green/Blue deploys instead of rolling deploys to improve deploy confidence
- Chef or Ansible provisioning instead of Bash
- Multi-region high-availability using ELB and Route53 Latency based routing
- The introduction of real config management would also make the possibility of configuring environments much more realistic
- Everything is currently based around VM architecture, whereas Docker is much better for internal environments, and given proper scheduling, is very powerful in production
- Introducing global feature flagging would allow for Continuous Deployment, as you would be able to turn on/off code in production from an interface, allowing us to safely commit continuously

## Testing Instructions
Tox is available for testing across all versions of Python. The Make build system is also available, with a 'Make test' command to run tests. This could further be split into 'Make unit', 'Make integration', 'Make functional', etc...
```
$ cd ${projectdir}
$ make test
```

## Installation Instructions
The Make build system is available in this project to make common tasks easier to reason about. Installation is a simple two-liner. This is a very basic example of the installation process, you should consider installing this package into a virtualenv.

```
$ cd ${projectdir}
$ make install
```

## Git Strategy
The project would follow a Github-Flow style of merging, making master our main integration branch from feature branches. Master should always be deployable.

Starting in your development feature branch, you should run Unit tests locally before pushing your code to Github. After merging into Master, a build should automatically kick off on a dev server to run unit tests. If Unit tests pass, another build should kick off for the staging environment, where integration, and functional tests should run.
