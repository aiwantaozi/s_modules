variable "instance_name" {
  description = "The instance type of the ECS instance"
  default     = "example-instance"
}

variable "instance_type" {
  description = "The instance type of the ECS instance"
  default     = "ecs.s6-c1m2.small"
}

variable "instance_password" {
  description = "The instance type of the ECS instance"
  default     = "Test12345"
}

variable "image_id" {
  description = "The ID of the image used to launch the ECS instance"
  default     = "ubuntu_22_04_x64_20G_alibase_20230208.vhd"
}

variable "system_disk_category" {
  description = "The category of the system disk"
  default     = "cloud_efficiency"
}

variable "system_disk_size" {
  description = "The size of the system disk"
  default     = 40
}

variable "internet_charge_type" {
  description = "The billing method of the public network bandwidth"
  default     = "PayByTraffic"
}

variable "internet_max_bandwidth_out" {
  description = "The maximum outbound bandwidth of the public network"
  default     = 5
}

resource "alicloud_instance" "instance" {
  instance_name              = var.instance_name
  instance_type              = var.instance_type
  image_id                   = var.image_id
  system_disk_category       = var.system_disk_category
  system_disk_size           = var.system_disk_size
  internet_charge_type       = var.internet_charge_type
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  password                   = var.instance_password

  vswitch_id = data.alicloud_vswitches.default.vswitches.0.id

  key_name = "michelia"

  security_groups = [
    data.alicloud_security_groups.default.groups.0.id
  ]
}

data "alicloud_vpcs" "default" {
  name_regex = "default"
}

data "alicloud_vswitches" "default" {
  vpc_id = data.alicloud_vpcs.default.vpcs.0.id
}

data "alicloud_security_groups" "default" {
  name_regex = "default"
}

output "hostname_list" {
  value = join(",", alicloud_instance.instance.*.instance_name)
}

output "ecs_ids" {
  value = join(",", alicloud_instance.instance.*.id)
}

output "ecs_public_ip" {
  value = join(",", alicloud_instance.instance.*.public_ip)
}

output "tags" {
  value = jsonencode(alicloud_instance.instance.*.tags)
}
