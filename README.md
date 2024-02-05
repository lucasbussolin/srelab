# SRE Lab
In this repository, it will be a solution for a SRE Role. Feel free to comment here.

The base of test is to make a metabase server with all SRE approach to the process.

If you want to test my solution, please contact me so i can turn on all structure. Load Balancer is expansive.

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

## Terraform
For this part of the challenge, i use [Terraformer](https://github.com/GoogleCloudPlatform/terraformer) to reverse Terraform from structure that i made in AWS.

It is separeted in three files with all resources described. With a little bit of treatment in this files, it could be more readable and usable for scale-up and scale-down process in Metabase tasks.

## Automatization
One of the challenge tasks is for make a code automatization for all infrastructure. By the way, i dind't do this.

My idea was use terraform code for all this automatization process, even Cloud creation and Application scale-up and Down. But in this process i could'nt finish this part.

So, we don't have scale-up and scale-down processess? What kind of SRE are you???

Ok, for this we can scale project by increasing or decrease desired tasks in our ECS Service. So, i count as a win.
