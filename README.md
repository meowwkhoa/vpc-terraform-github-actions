# README.md

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->
<!-- code_chunk_output -->

* Contents:
    * Introduction
    * [Setup Instructions](#setup-instructions)
    * Usage
    * [Repository Structure](#repository-structure)
<!-- /code_chunk_output -->

## Introduction:
Creating a VPC using Terraform as IAAC and GitHub Actions as CI/CD for the NT548.P11 course - Fall 2024 semester at University of Information Technology - VNUHCM.

## Setup Instructions:
1. **Create AWS IAM User:**
   - Go to the IAM section in AWS.
   ![IAM_section](assets/IAM_section.png)
   - Go to ``Users`` section.
   ![Users_section](assets/Users.png)
   - Create a new user with your user name.
   ![Users_name](assets/User_name.png)
   - Attach the necessary policies.
   ![Permission](assets/Permission.png)
   - Now we can see our user on the AWS platform.
   ![All_users](assets/All_users.png)
   - Click on our user, then ``Security credentials``.
   ![Credentials](assets/Credential.png)
   - Go to ``Access keys`` and click ``Create access key``.
   ![Access_keys](assets/Access_keys.png)
   - Choose ``CLI``.
   ![CLI](assets/CLI.png)
   - Then ``Create access key``.
   ![Create_key](assets/Create_key.png)
   - Now, we can either download the CSV file to save the keys or copy them directly.
   ![CSV](assets/CSV.png)

2. **Configure GitHub Secrets:**
   - Go to the repository settings on GitHub.
   ![Settings](assets/Settings.png)
   - Navigate to the "Environments" section.
   ![Environments](assets/Environments.png)
   - Add the following secrets:
     - `AWS_ACCESS_KEY_ID`
     - `AWS_SECRET_ACCESS_KEY`
     - `AWS_REGION` (e.g., `us-east-1`)
   ![Access_key_pasting](assets/Access_key.png)

## Usage:
1. **Clone the Repository:**
   ```bash
   git clone https://github.com/meowwkhoa/vpc-terraform-github-actions.git
   cd vpc-terraform-github-actions
   ```

2. **Create a New Branch:**
   ```bash
   git checkout -b test
   ```

3. **Make Changes and Push:**
- Make any necessary changes to the code.
- Stage and commit the changes:
   ```bash
   git add .
   git commit -m "test"
   git push origin test
   ```    

4. **Create a Pull Request:**
- Go to the repository on GitHub.
- Create a pull request from the `test` branch to the `main` branch.

5. **Monitor Deployment:**
- The GitHub Action will trigger automatically.
- Monitor the infrastructure changes in the AWS Management Console.


## Repository structure:
```txt
vpc-terraform-github-actions
  ├── .github
  │   └── workflows
  │       └── terraform-deploy.yml                /* GitHub Actions workflow file */
  ├── modules
  │   ├── VPC
  │   │   ├── main.tf
  │   │   ├── outputs.tf
  │   │   └── variables.tf
  │   ├── NAT
  │   │   ├── main.tf
  │   │   ├── outputs.tf
  │   │   └── variables.tf
  │   ├── Route_Table
  │   │   ├── main.tf
  │   │   ├── outputs.tf
  │   │   └── variables.tf
  │   ├── Security_Groups
  │   │   ├── main.tf
  │   │   ├── outputs.tf
  │   │   └── variables.tf
  │   └── EC2
  │       ├── main.tf
  │       ├── outputs.tf
  │       └── variables.tf
  ├── main.tf
  ├── outputs.tf
  ├── variables.tf
  ├── assets               /* Images */
  └── README.md            /* Readme file with instructions */


```