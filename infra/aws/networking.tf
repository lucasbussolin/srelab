resource "aws_vpc" "srelab" {
  assign_generated_ipv6_cidr_block     = "false"
  cidr_block                           = "172.31.0.0/16"
  enable_dns_hostnames                 = "true"
  enable_dns_support                   = "true"
  enable_network_address_usage_metrics = "false"
  instance_tenancy                     = "default"
}

resource "aws_internet_gateway" "tfer--igw-6c13f117" {
  vpc_id = aws_vpc.srelab.id
}

resource "aws_lb" "metabase" {

  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = "false"
  enable_cross_zone_load_balancing            = "true"
  enable_deletion_protection                  = "false"
  enable_http2                                = "true"
  enable_tls_version_and_cipher_suite_headers = "false"
  enable_waf_fail_open                        = "false"
  enable_xff_client_port                      = "false"
  idle_timeout                                = "60"
  internal                                    = "false"
  ip_address_type                             = "ipv4"
  load_balancer_type                          = "application"
  name                                        = "metabase"
  preserve_host_header                        = "false"
  security_groups                             = [aws_security_group.default.id]

  subnet_mapping {
    subnet_id = "subnet-3871c706"
  }

  subnet_mapping {
    subnet_id = "subnet-5813713f"
  }

  subnet_mapping {
    subnet_id = "subnet-5d7f1673"
  }

  subnet_mapping {
    subnet_id = "subnet-a92210e3"
  }

  subnet_mapping {
    subnet_id = "subnet-f1610ead"
  }

  subnets                    = [aws_subnet.subnet-e, aws_subnet.subnet-a, aws_subnet.subnet-b, aws_subnet.subnet-c, aws_subnet.subnet-d]
  xff_header_processing_mode = "append"
}

resource "aws_lb_listener" "tfer--arn-003A-aws-003A-elasticloadbalancing-003A-us-east-1-003A-237533616493-003A-listener-002F-app-002F-metabase-002F-62f8e59c7afb73ba-002F-d7179f12515aca31" {
  default_action {
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:237533616493:targetgroup/target/73ca6852791e5362"
    type             = "forward"
  }

  # load_balancer_arn = "${data.terraform_remote_state.alb.outputs.aws_lb_tfer--metabase_id}"
  load_balancer_arn = aws_lb.metabase.id
  port              = "80"
  protocol          = "HTTP"
}

resource "aws_lb_target_group_attachment" "tfer--arn-003A-aws-003A-elasticloadbalancing-003A-us-east-1-003A-237533616493-003A-targetgroup-002F-target-002F-73ca6852791e5362-i-03d55fd7685002d53" {
  target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:237533616493:targetgroup/target/73ca6852791e5362"
  target_id        = "i-03d55fd7685002d53"
}

resource "aws_lb_target_group_attachment" "tfer--arn-003A-aws-003A-elasticloadbalancing-003A-us-east-1-003A-237533616493-003A-targetgroup-002F-target-002F-73ca6852791e5362-i-061128029684219e5" {
  target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:237533616493:targetgroup/target/73ca6852791e5362"
  target_id        = "i-061128029684219e5"
}

resource "aws_lb_target_group" "tfer--target" {
  deregistration_delay = "300"

  health_check {
    enabled             = "true"
    healthy_threshold   = "5"
    interval            = "30"
    matcher             = "200"
    path                = "/api/health"
    port                = "3000"
    protocol            = "HTTP"
    timeout             = "5"
    unhealthy_threshold = "2"
  }

  ip_address_type                   = "ipv4"
  load_balancing_algorithm_type     = "round_robin"
  load_balancing_anomaly_mitigation = "off"
  load_balancing_cross_zone_enabled = "use_load_balancer_configuration"
  name                              = "target"
  port                              = "3000"
  protocol                          = "HTTP"
  protocol_version                  = "HTTP1"
  slow_start                        = "0"

  stickiness {
    cookie_duration = "86400"
    enabled         = "false"
    type            = "lb_cookie"
  }

  target_type = "instance"
  vpc_id      = "vpc-2d1ba457"
}

resource "aws_subnet" "subnet-f" {
  assign_ipv6_address_on_creation                = "false"
  availability_zone                              = "us-east-1f"
  cidr_block                                     = "172.31.48.0/20"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"
  vpc_id                                         = aws_vpc.srelab.id
}

resource "aws_subnet" "subnet-e" {
  assign_ipv6_address_on_creation                = "false"
  availability_zone                              = "us-east-1e"
  cidr_block                                     = "172.31.64.0/20"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"
  vpc_id                                         = aws_vpc.srelab.id
}

resource "aws_subnet" "subnet-a" {
  assign_ipv6_address_on_creation                = "false"
  availability_zone                              = "us-east-1a"
  cidr_block                                     = "172.31.0.0/20"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"
  vpc_id                                         = aws_vpc.srelab.id
}

resource "aws_subnet" "subnet-b" {
  assign_ipv6_address_on_creation                = "false"
  availability_zone                              = "us-east-1b"
  cidr_block                                     = "172.31.80.0/20"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"
  vpc_id                                         = aws_vpc.srelab.id
}

resource "aws_subnet" "subnet-c" {
  assign_ipv6_address_on_creation                = "false"
  availability_zone                              = "us-east-1c"
  cidr_block                                     = "172.31.16.0/20"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"
  vpc_id = aws_vpc.srelab.id
}

resource "aws_subnet" "subnet-d" {
  assign_ipv6_address_on_creation                = "false"
  availability_zone                              = "us-east-1d"
  cidr_block                                     = "172.31.32.0/20"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"
  vpc_id = aws_vpc.srelab.id
}

resource "aws_security_group" "default" {
  description = "default VPC security group"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    cidr_blocks = ["172.31.0.0/16"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  name   = "default"
  vpc_id = "vpc-2d1ba457"
}

resource "aws_autoscaling_group" "tfer--Infra-ECS-Cluster-devtest-b09c5cbe-ECSAutoScalingGroup-lcp4eyPrWq4b" {
  capacity_rebalance        = "false"
  default_cooldown          = "300"
  default_instance_warmup   = "0"
  desired_capacity          = "2"
  force_delete              = "false"
  health_check_grace_period = "0"
  health_check_type         = "EC2"

  launch_template {
    id      = aws_launch_template.config.id
    name    = "ECSLaunchTemplate_m2OWTOW6Xjv0"
    version = "$Latest"
  }

  max_instance_lifetime   = "0"
  max_size                = "2"
  metrics_granularity     = "1Minute"
  min_size                = "0"
  name                    = "Infra-ECS-Cluster-devtest-b09c5cbe-ECSAutoScalingGroup-lcp4eyPrWq4b"
  protect_from_scale_in   = "false"
  service_linked_role_arn = "arn:aws:iam::237533616493:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"

  tag {
    key                 = "Name"
    propagate_at_launch = "true"
    value               = "ECS Instance - devtest"
  }

  traffic_source {
    identifier = "arn:aws:elasticloadbalancing:us-east-1:237533616493:targetgroup/target/73ca6852791e5362"
    type       = "elbv2"
  }

  vpc_zone_identifier       = [aws_subnet.subnet-e, aws_subnet.subnet-a, aws_subnet.subnet-b, aws_subnet.subnet-c, aws_subnet.subnet-d]
  wait_for_capacity_timeout = "10m"
}

resource "aws_launch_template" "config" {
  default_version         = "4"
  disable_api_stop        = "false"
  disable_api_termination = "false"

  iam_instance_profile {
    arn = "arn:aws:iam::237533616493:instance-profile/ecsInstanceRole"
  }

  image_id               = "ami-0d42173b665d626f0"
  instance_type          = "t2.micro"
  key_name               = "aws-test"
  name                   = "ECSLaunchTemplate_m2OWTOW6Xjv0"
  user_data              = "IyEvYmluL2Jhc2ggCmVjaG8gRUNTX0NMVVNURVI9ZGV2dGVzdCA+PiAvZXRjL2Vjcy9lY3MuY29uZmlnOw=="
  vpc_security_group_ids = ["sg-f8888bbd"]
}

resource "aws_default_network_acl" "tfer--acl-1e45a363" {
  default_network_acl_id = aws_vpc.srelab.default_network_acl_id
  egress {
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "0"
    icmp_code  = "0"
    icmp_type  = "0"
    protocol   = "-1"
    rule_no    = "100"
    to_port    = "0"
  }

  ingress {
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "0"
    icmp_code  = "0"
    icmp_type  = "0"
    protocol   = "-1"
    rule_no    = "100"
    to_port    = "0"
  }

  subnet_ids = [aws_subnet.subnet-f, aws_subnet.subnet-e, aws_subnet.subnet-a, aws_subnet.subnet-b, aws_subnet.subnet-c, aws_subnet.subnet-d]
}

resource "aws_docdb_subnet_group" "tfer--default-vpc-2d1ba457" {
  description = "Created from the RDS Management Console"
  name        = "default-vpc-2d1ba457"
  subnet_ids  = ["subnet-3020043f", "subnet-3871c706", "subnet-5813713f", "subnet-5d7f1673", "subnet-a92210e3", "subnet-f1610ead"]
}

resource "aws_db_instance" "tfer--database-1" {
  allocated_storage                     = "20"
  auto_minor_version_upgrade            = "true"
  availability_zone                     = "us-east-1f"
  backup_retention_period               = "1"
  backup_target                         = "region"
  backup_window                         = "06:54-07:24"
  ca_cert_identifier                    = "rds-ca-rsa2048-g1"
  copy_tags_to_snapshot                 = "true"
  customer_owned_ip_enabled             = "false"
  db_subnet_group_name                  = aws_db_subnet_group.group.name
  deletion_protection                   = "false"
  engine                                = "postgres"
  engine_version                        = "15.5"
  iam_database_authentication_enabled   = "false"
  identifier                            = "database-1"
  instance_class                        = "db.t3.micro"
  iops                                  = "0"
  kms_key_id                            = "arn:aws:kms:us-east-1:237533616493:key/ebbdd81e-940f-4f35-91b2-6f8133b0871e"
  license_model                         = "postgresql-license"
  maintenance_window                    = "fri:08:23-fri:08:53"
  max_allocated_storage                 = "1000"
  monitoring_interval                   = "0"
  multi_az                              = "false"
  network_type                          = "IPV4"
  option_group_name                     = "default:postgres-15"
  parameter_group_name                  = "default.postgres15"
  performance_insights_enabled          = "true"
  performance_insights_kms_key_id       = "arn:aws:kms:us-east-1:237533616493:key/ebbdd81e-940f-4f35-91b2-6f8133b0871e"
  performance_insights_retention_period = "7"
  port                                  = "5432"
  publicly_accessible                   = "true"
  storage_encrypted                     = "true"
  storage_throughput                    = "0"
  storage_type                          = "gp2"
  username                              = "postgres"
  vpc_security_group_ids                = [aws_security_group.default.id]
}

resource "aws_db_subnet_group" "group" {
  description = "Created from the RDS Management Console"
  name        = "default-vpc-2d1ba457"
  subnet_ids  = [aws_subnet.subnet-f, aws_subnet.subnet-e, aws_subnet.subnet-a, aws_subnet.subnet-b, aws_subnet.subnet-c, aws_subnet.subnet-d]
}

resource "aws_main_route_table_association" "tfer--vpc-2d1ba457" {
  route_table_id = aws_route_table.route_table.id
  vpc_id         = aws_vpc.srelab.id
}

resource "aws_route_table" "route_table" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tfer--igw-6c13f117.id
  }

  vpc_id = aws_vpc.srelab.id
}