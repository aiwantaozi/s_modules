# Create a VPC
resource "aws_vpc" "michelia_test_resource" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "michelia_test_resource"
  }
}

resource "aws_subnet" "michelia_test_resource" {
  vpc_id            = aws_vpc.michelia_test_resource.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "michelia_test_resource"
  }
}

resource "aws_network_interface" "michelia_test_resource" {
  subnet_id   = aws_subnet.michelia_test_resource.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "michelia_test_resource"
  }
}

resource "aws_instance" "michelia_test_resource" {
  ami                  = "ami-0e0820ad173f20fbb"
  instance_type        = "t3.micro"
  iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"
  network_interface {
    network_interface_id = aws_network_interface.michelia_test_resource.id
    device_index         = 0
  }

  tags = {
    Name = "michelia_test_resource"
  }
}
