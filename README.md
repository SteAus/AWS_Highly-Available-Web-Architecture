# Highly Available Web Architecture
![Resistent-Web-Architecture](https://user-images.githubusercontent.com/98794737/154002380-3d97efdc-840d-45b6-9c87-045730b1b553.png)
## Purpose
This architecture was created to serve HTTPS traffic with the requirement of high availablity within a single region. Cost was not a consideration for the architecture. However, simple modifications can be made to reduce costs. 
## Overview
This architecture provides a single point of entry for the application via CLB. An ACM certificate is automatically created, validated with Route53, and installed on the CLB to handle HTTPS traffic. HTTPS is decrypted at the CLB before being passed along to an ASG inside the VPC securely. The ASG spans 3 availability zones to provide high availability for the instances. Cross-zone load balancing is also enabled to help maintain an equal number of instances in each availability zones during scaling. Each EC2 instance is launched from a launch template. The launch template uses a custom-built AMI that has Apache, and other basic tools installed for demonstration purpose. These instances have access to a highly available RDS instance and read replica. Additionally, multi-az is enabled to maximize RDS availability (aside from placing the read replica in a different region). This is excessive for most use cases. Users can opt for one option or the other based on their needs. 
## Installation
To install this infrastructure yourself, you will need to... 
1.	Donwload and install Terraform. The donwload can be found here: https://www.terraform.io/downloads
2.	Generate AWS access keys for Terraform. Details can be found here: https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/
3.	Clone the repository and create a `vars.tf` file inside the directory
4.	Inside `vars.tf`, create a variable for your access key, secret, and domain as shown below.
```
variable "key" {
  default = "your-key-here"
}
variable "secret" {
  default = "your-secret-here"
}
variable "domain" {
  default = "your-domain-here"
}
```
5.	Once configured, run `setup.bat` to build  the infrastructure in the correct order. Don’t forget to run `terraform destroy` when you’re ready to tear down.
## Disclamer
This infrastructure is under development and should not be considered secure under any circumstance. Security groups and NACLs are open for the sake of testing and demonstration.
