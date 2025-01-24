Syntax :: ::

Configuration Syntax

1. Arguments, Blocks, Attributes & Meta-Arguments

i. Arguments :
Arguments can be required or optional

An argument assigns a value to a particular name:
image_id = "abc123"

ii. Blocks :
A block is a container for other content:
resource "aws_instance" "example" { # BLOCK
  ami = "ami-04d29b6f966df1537"    # Argument
  instance_type = var.instance_type # Argument with value as expression (Variable value replaced from varibales.tf

  network_interface {
    # ...
  }
}

2. Identifiers

Identifiers can contain letters, digits, underscores (_), and hyphens (-). The first character of an identifier must not be a digit, to avoid ambiguity with literal numbers.

3. Comments

The Terraform language supports three different syntaxes for comments:
# begins a single-line comment, ending at the end of the line.
// also begins a single-line comment, as an alternative to #.
/* and */ are start and end delimiters for a comment that might span over multiple lines.

-------------------------------------------------------------------------------------------------------------

1. Understand about Terraform Top-Level Blocks

Terraform Settings Block
Provider Block
Resource Block
Input Variables Block
Output Values Block
Local Values Block
Data Sources Block
Modules Block


2. Meta-Argument

i. The depends_on Meta-Argument

In Terraform, the depends_on block is used to explicitly define dependencies between resources. This ensures that Terraform knows the correct order to create, update, or destroy resources, even if it can't automatically determine the dependency from the resource configuration.

Example 1: 
Suppose you have an S3 bucket and a Lambda function. The Lambda function's configuration depends on the S3 bucket existing, but there isn't an explicit reference in the function to the bucket.

resource "aws_s3_bucket" "example" {
  bucket = "my-example-bucket"
}

resource "aws_lambda_function" "example" {
  filename         = "lambda_function.zip"
  function_name    = "my_lambda_function"
  role             = "arn:aws:iam::123456789012:role/lambda-role"
  handler          = "index.handler"
  runtime          = "nodejs18.x"

  depends_on = [aws_s3_bucket.example]
}

Terraform will ensure the S3 bucket is created before the Lambda function because of the depends_on block.
Without depends_on, Terraform might try to create the Lambda function first, leading to errors if it requires the bucket to exist.

-------------------------------------------------------------------------------------------------------------

Example 2: Custom Resource Dependency

You might use depends_on when working with non-Terraform-managed resources or when dependencies are implied.

resource "null_resource" "trigger_after_setup" {
  depends_on = [aws_instance.web_server]
}
Here:

The null_resource will only run after the aws_instance.web_server resource is successfully created, even though there’s no direct configuration linking them.

Key Points:
Implicit Dependencies: Terraform usually figures out dependencies automatically.
Explicit Dependencies: Use depends_on when Terraform can't infer the dependency


-------------------------------------------------------------------------------------------------------------


for example of iam role attachment to ec2 instance

ec2 instance ---> role profile
          role profile ---> role attached
                   attached iam role ---> with policy and permission

code ::

resource "aws_iam_role" "example" {
  name = "example"

  # assume_role_policy is omitted for brevity in this example. Refer to the
  # documentation for aws_iam_role for a complete example.
  assume_role_policy = "..."
}

resource "aws_iam_instance_profile" "example" {
  # Because this expression refers to the role, Terraform can infer
  # automatically that the role must be created first.
  role = aws_iam_role.example.name
}

resource "aws_iam_role_policy" "example" {
  name   = "example"
  role   = aws_iam_role.example.name
  policy = jsonencode({
    "Statement" = [{
      # This policy allows software running on the EC2 instance to
      # access the S3 API.
      "Action" = "s3:*",
      "Effect" = "Allow",
    }],
  })
}

resource "aws_instance" "example" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

  # Terraform can infer from this that the instance profile must
  # be created before the EC2 instance.
  iam_instance_profile = aws_iam_instance_profile.example

  # However, if software running in this EC2 instance needs access
  # to the S3 API in order to boot properly, there is also a "hidden"
  # dependency on the aws_iam_role_policy that Terraform cannot
  # automatically infer, so it must be declared explicitly:
  depends_on = [
    aws_iam_role_policy.example
  ]
}


ii. The count Meta-Argument

Basic Syntax
The count meta-argument accepts a whole number, and creates that many instances of the resource or module. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

code:
resource "aws_instance" "server" {
  count = 4 # create four similar EC2 instances

  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

  tags = {
    Name = "Server ${count.index}"
  }
}

----------------------------------------------------------------------------------------------------------


The count Object
In blocks where count is set, an additional count object is available in expressions, so you can modify the configuration of each instance. This object has one attribute:

count.index — The distinct index number (starting with 0) corresponding to this instance.
<TYPE>.<NAME>[<INDEX>] or module.<NAME>[<INDEX>] (for example, aws_instance.server[0], aws_instance.server[1], etc.) refers to individual instances.

----------------------------------------------------------------------------------------------------------

When to Use for_each Instead of count:

If your instances are almost identical, count is appropriate. If some of their arguments need distinct values that can't be directly derived from an integer, it's safer to use for_each.

Let's say you want to:

Create 2 EC2 instances for a "dev" environment.
Create 1 EC2 instance for a "prod" environment.
You can use for_each with a map to achieve this:

resource "aws_instance" "example" {
  for_each = {
    dev  = 2
    prod = 1
  }

  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

  tags = {
    Environment = each.key
  }
}

---------------------------------------------------------------------------------------------------------


let's say if every instance have different key and value and want to do with for_each then

checkout the terraform_manifest dir and open the main.tf file......


