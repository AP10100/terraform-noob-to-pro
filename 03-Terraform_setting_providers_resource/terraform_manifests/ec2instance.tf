resource "aws_instance" "terra_demo_machine" {
   ami = "ami-005fc0f236362e99f"
   instance_type = "t2.micro"
   key_name = "N.virg_demo_key"
   user_data = file("${path.module}/app1-install.sh")
   tags = {
     "Name" = "EC2_Terra_demo"
   }
}


# The push refers to repository [docker.io/***/voting-webapp]
# An image does not exist locally with the tag: ***/voting-webapp

# ##[error]An image does not exist locally with the tag: ***/voting-webapp
# ##[error]The process '/usr/bin/docker' failed with exit code 1
# REPOSITORY   TAG       IMAGE ID       CREATED             SIZE
# <none>       <none>    54388db934a1   52 seconds ago      218MB
# <none>       <none>    829923af8881   About an hour ago   218MB
# <none>       <none>    919ce6eb18b4   17 hours ago        218MB
# nginx        latest    f876bfc1cc63   5 weeks ago         192MB
# node         18-slim   c21af35f2961   7 weeks ago         192MB


# # Docker
# # Build a Docker image
# # https://docs.microsoft.com/azure/devops/pipelines/languages/docker

# trigger:
#  paths:
#    include:
#      - result/*

# resources:
# - repo: self

# variables:
#   dockerRegistryServiceConnection: dockerhub.registry.connection
#   dockerHubImage: apsp/voting-webapp
#   dockerfilepath: '$(Build.SourcesDirectory)/result/Dockerfile'
#   imageRepository: 'resultapp'
#   tag: '$(Build.BuildId)'

# pool:
#  name: 'azureagent'

# stages:
# - stage: Build
#   displayName: Build image
#   jobs:
#   - job: Build
#     displayName: Build
#     steps:
#     - task: Docker@2
#       displayName: Build an image
#       inputs:
#         command: build
#         # dockerfile: $(dockerfilepath)
#         repository: '$(dockerHubImage)'
#         Dockerfile: 'result/Dockerfile'
#         tags: '$(tag)'

# - stage: push
#   displayName: push image
#   jobs:
#   - job: push
#     displayName: push
#     steps:
#     - task: Docker@2
#       displayName: push an image
#       inputs:
#         command: push
#         containerRegistry: '$(dockerRegistryServiceConnection)'
#         repository: '$(dockerHubImage)'
#         Dockerfile: 'result/Dockerfile'
#         tags: '$(tag)'




# WoElFloeaLHME0aSAOMVKIu4VwMJltLsiS8SaAvNhWjZAUw23gBDJQQJ99BAACAAAAAAAAAAAAASAZDOY3eJ
