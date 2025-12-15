# iac-template

This project demonstrates a AWS container deployment using ECS Fargate with a separation between infrastructure and application delivery.

Infrastructure is managed with Terraform and is responsible for AWS resources such as networking, ECS, IAM, ECR, and the Application Load Balancer. Application builds and deployments are handled separately using GitHub Actions and immutable container images.

The application runs as a FastAPI service on ECS Fargate behind an Application Load Balancer. New versions are deployed by building and pushing a Docker image to ECR and forcing a new ECS service deployment, without reapplying Terraform.

This structure is designed to be reusable and extensible for workloads such as scheduled Fargate tasks and ML model pipelines.


## Architecture

![architecture](docs/architecture.png)

## Security


Current security controls:
- ECS tasks run in private subnets and are only reachable through the Application Load Balancer.
- Security groups restrict inbound traffic to the ALB and allow the ECS service only from the ALB.
- IAM follows least privilege:
  - task execution role is limited to pulling images from ECR and writing logs to CloudWatch
  - task role is separate and can be extended later (for example, S3 read-only for model files)

Future improvements:
- add HTTPS on the ALB (ACM certificate) and redirect HTTP → HTTPS
- add authentication/authorisation in front of the service
- enable AWS WAF on the ALB for basic protection (rate limiting, common rules)
- store secrets in Secrets Manager


## Application container

This repository includes a small FastAPI application packaged as a Docker container to demonstrate application delivery on ECS Fargate.

The service exposes a simple API for training and running a deep-learning model (a small neural network) using FastAI. The model performs basic tabular regression and is used as a simple example workload for the infrastructure.


### Run locally

Docker and Docker Compose are required.

```bash
cd ./app
docker compose up --build
