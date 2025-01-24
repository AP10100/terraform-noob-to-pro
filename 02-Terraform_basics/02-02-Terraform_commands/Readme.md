Terraform Basics commands
-----------------------------------------
Step-01: Introduction

working majorly with below commands :: :: :: ::

terraform init
Initialize prepares your workspace so Terraform can apply your configuration.

terraform validate

terraform plan
Plan allows you to preview the changes Terraform will make before you apply them.

terraform apply
Apply makes the changes defined by your plan to create, update, or destroy resources.

terraform destroy

---------------------------------------------------------------------Note : here we are using aws cloud provider with terraform to create a resource.

Now it is high time to work with the practicals with Terraform AWS.

let's go in.................


---------------------------------------------------------------------

So, we are planning to spin up the ec2 machine in aws with IAC with terraform.

here, Initialize your workspace in cli with init.
terraform init




some cli flow that happened after terraform success
----------------------------------------------------------------------

ubuntu@ip-172-31-2-121:~$ ls -l -a
total 65876
drwxr-x--- 8 ubuntu ubuntu     4096 Dec  7 19:15 .
drwxr-xr-x 3 root   root       4096 Dec  7 10:18 ..
drwxrwxr-x 2 ubuntu ubuntu     4096 Dec  7 14:39 .aws
-rw------- 1 ubuntu ubuntu     1083 Dec  7 19:09 .bash_history
-rw-r--r-- 1 ubuntu ubuntu      220 Jan  6  2022 .bash_logout
-rw-r--r-- 1 ubuntu ubuntu     3771 Jan  6  2022 .bashrc
drwx------ 2 ubuntu ubuntu     4096 Dec  7 10:21 .cache
-rw------- 1 ubuntu ubuntu       20 Dec  7 17:30 .lesshst
-rw-r--r-- 1 ubuntu ubuntu      807 Jan  6  2022 .profile
drwx------ 2 ubuntu ubuntu     4096 Dec  7 10:18 .ssh
-rw-r--r-- 1 ubuntu ubuntu        0 Dec  7 10:22 .sudo_as_admin_successful
drwxr-xr-x 2 ubuntu ubuntu     4096 Dec  7 15:03 .terraform.d
-rw------- 1 ubuntu ubuntu    18202 Dec  7 18:33 .viminfo
-rw-rw-r-- 1 ubuntu ubuntu      181 Dec  7 15:03 .wget-hsts
drwxr-xr-x 3 ubuntu ubuntu     4096 Dec  5 01:23 aws
-rw-rw-r-- 1 ubuntu ubuntu 67372695 Dec  7 14:21 awscliv2.zip
drwxr-xr-x 3 root   root       4096 Dec  7 16:26 terraform_basics



----------------------------------------------------------------------


ubuntu@ip-172-31-2-121:~/.aws$ ls -l -a
total 16
drwxrwxr-x 2 ubuntu ubuntu 4096 Dec  7 14:39 .
drwxr-x--- 8 ubuntu ubuntu 4096 Dec  7 19:15 ..
-rw------- 1 ubuntu ubuntu   43 Dec  7 14:39 config
-rw------- 1 ubuntu ubuntu  116 Dec  7 14:39 credentials

----------------------------------------------------------------------

<!-- ubuntu@ip-172-31-2-121:~/.aws$ cat config
[default]
region = us-east-1
output = json
ubuntu@ip-172-31-2-121:~/.aws$ cat credentials
[default]



----------------------------------------------------------------------

ubuntu@ip-172-31-2-121:~$ cd .terraform.d/
ubuntu@ip-172-31-2-121:~/.terraform.d$ ls -l -a
total 16
drwxr-xr-x 2 ubuntu ubuntu 4096 Dec  7 15:03 .
drwxr-x--- 8 ubuntu ubuntu 4096 Dec  7 19:15 ..
-rw-rw-r-- 1 ubuntu ubuntu  314 Dec  7 15:03 checkpoint_cache
-rw-r--r-- 1 ubuntu ubuntu  394 Dec  7 15:03 checkpoint_signature
ubuntu@ip-172-31-2-121:~/.terraform.d$ tree
.
├── checkpoint_cache
└── checkpoint_signature

0 directories, 2 files
ubuntu@ip-172-31-2-121:~/.terraform.d$ cat checkpoint_cache
5wi�1.10.1{"product":"terraform","current_version":"1.10.1","current_release":1733315792,"current_download_url":"https://releases.hashicorp.com/terraform/1.10.1","current_changelog_url":"https://github.com/hashicorp/terraform/blob/v1.10.1/CHANGELOG.md","project_website":"https://www.terraform.io","alerts":[]}ubuntu@ip-172-31-2-121:~/.terraform.d$
ubuntu@ip-172-31-2-121:~/.terraform.d$ cat checkpoint_signature
4854d059-ef1b-f95b-2935-08c905d55b38


This signature is a randomly generated UUID used to de-duplicate
alerts and version information. This signature is random, it is
not based on any personally identifiable information. To create
a new signature, you can simply delete this file at any time.
See the documentation for the software using Checkpoint for more
information on how to disable it.

-------------------------------------------------------------------------



error::
i run in to permission issue so much time while doing terraform command init and plan bcz i have created manifest directory wih root user access and the credential i have in the root .aws/credential path have ubuntu user so there is no credential for rot user when i ran sudo terraform plan then saying permission denied which is obvious .

sol:
so what i usd to do to get resolved is i changed the dir(terraform_manifest where the code is written) permission to ubuntu user or current user which does not required sudo permission so that a when i run terraform command like terraform plan then it is getting result successfully bcz .aws/credential has a same ubuntu user which does not requires sudo access to read the cred so that way if both te things have same user then it would works bcz terraform plan writes .terraform dir which requited aws credential with proper access permission enable 

so the best practice include not to run any terraform command with sudo bcz tha lets you ran permission issue .so avoid sudo and changed the root user with your local user of any custom user.


error 2:
we have to take ami and key pair for the same region that we configure while aws configure command otherwise it is throwing error.


error 3:

define the output.tf fie at the root level where the actual terraform.tf code is written to see the value after terraform apply but if you are define the output.tf file inside module dir then it is not showing after terraform apply command logs.

-----------------------------------------------------------------------------------
here is a dir structure of the terraform code i written

command :: :: tree -a
 terraform_basics
    └── terraform_manifests
        ├── .terraform
        │   ├── modules
        │   │   └── modules.json
        │   └── providers
        │       └── registry.terraform.io
        │           └── hashicorp
        │               └── aws
        │                   └── 4.67.0
        │                       └── linux_amd64
        │                           └── terraform-provider-aws_v4.67.0_x5
        ├── .terraform.lock.hcl
        ├── modules
        │   └── aws-ec2-instance
        │       ├── main.tf
        │       ├── outputs.tf
        │       └── variables.tf
        ├── terraform.tf
        ├── terraform.tfstate
        └── terraform.tfstate.backup


command :: :: tree
 terraform_basics
    └── terraform_manifests
        ├── modules
        │   └── aws-ec2-instance
        │       ├── main.tf
        │       ├── outputs.tf
        │       └── variables.tf
        ├── terraform.tf
        ├── terraform.tfstate
        └── terraform.tfstate.backup




-----------------------------------------------------------------------------------------


finally time to destroy the resources::

terraform destroy

module.ec2_instance.aws_instance.Terraform-EC2-Instance_demo: Destroying... [id=i-02ac86d4af4fd3d9e]
module.ec2_instance.aws_instance.Terraform-EC2-Instance_demo: Still destroying... [id=i-02ac86d4af4fd3d9e, 10s elapsed]
module.ec2_instance.aws_instance.Terraform-EC2-Instance_demo: Still destroying... [id=i-02ac86d4af4fd3d9e, 20s elapsed]
module.ec2_instance.aws_instance.Terraform-EC2-Instance_demo: Still destroying... [id=i-02ac86d4af4fd3d9e, 30s elapsed]
module.ec2_instance.aws_instance.Terraform-EC2-Instance_demo: Still destroying... [id=i-02ac86d4af4fd3d9e, 40s elapsed]
module.ec2_instance.aws_instance.Terraform-EC2-Instance_demo: Still destroying... [id=i-02ac86d4af4fd3d9e, 50s elapsed]
module.ec2_instance.aws_instance.Terraform-EC2-Instance_demo: Still destroying... [id=i-02ac86d4af4fd3d9e, 1m0s elapsed]
module.ec2_instance.aws_instance.Terraform-EC2-Instance_demo: Destruction complete after 1m3s

Destroy complete! Resources: 1 destroyed.






After destroyed the state file would have been something like ::

ubuntu@ip-172-31-2-121:~/terraform_basics$ cat terraform_manifests/terraform.tfstate
{
  "version": 4,
  "terraform_version": "1.10.1",
  "serial": 6,
  "lineage": "4324598b-4315-77aa-caa6-9b678a6cd5da",
  "outputs": {},
  "resources": [],
  "check_results": null
}
