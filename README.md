# SRE Lab
In this repository, it will be a solution for a SRE Role. Feel free to comment here.

## Cloud Structure
![Image](https://raw.githubusercontent.com/lucasbussolin/srelab/main/images/diagram.png)

## CI/CD

I used Github Actions for CI/CD process. The workflow is divided by two jobs.

### Build and Release

Steps (in order):
- [actions/checkout@v4](https://github.com/actions/checkout) - Access the repository and find all data that the process needs.

- [aws-actions/configure-aws-credentials@v4](https://github.com/aws-actions/configure-aws-credentials) - Log in the AWS account by IdP previously configured and repository rules.

- [aws-actions/amazon-ecr-login@v2](https://github.com/aws-actions/amazon-ecr-login) - Log in AWS ECR.

- Build and push image - Build docker image from Dockerfile and push to AWS ECR. 

*Image tagged by run sha id.

### Deploy

Steps (in order):
- [actions/checkout@v4](https://github.com/actions/checkout) - Access the repository and find all data that the process needs.

- [aws-actions/configure-aws-credentials@v4](https://github.com/aws-actions/configure-aws-credentials) - Log in the AWS account by IdP previously configured and repository rules.

- [aws-actions/amazon-ecr-login@v2](https://github.com/aws-actions/amazon-ecr-login) - Log in AWS ECR.

- Mount task-definition file - Mount ECS task-definition file by changing all envs from '.aws/dev/template.json' to repository secrets.

- [aws-actions/amazon-ecs-render-task-definition@v1](https://github.com/aws-actions/amazon-ecs-render-task-definition) - Inserts a container image URI into an Amazon ECS task definition JSON file, creating a new task definition file.

- [aws-actions/amazon-ecs-deploy-task-definition@v1](https://github.com/aws-actions/amazon-ecs-deploy-task-definition) - Deploy last task-definition to ECS Cluster service.