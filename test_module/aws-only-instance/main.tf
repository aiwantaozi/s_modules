resource "aws_instance" "michelia_test_resource" {
  ami                  = "ami-0e0820ad173f20fbb"
  instance_type        = "t3.micro"
  iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"

  tags = {
    Name = "michelia_test_resource_only_instance"
  }
}
