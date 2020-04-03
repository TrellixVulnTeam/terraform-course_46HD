#-----------------------------------------------------------------------------------------------
#allows you to specify in what subnet that database will be in eu-west-1a and eu-west-1b if you 
#enable HA you will have RDS on both subnets.
#-----------------------------------------------------------------------------------------------
resource "aws_db_subnet_group" "mariadb-subnet" {
  name        = "${local.default_name}-mariadb-subnet-g"
  description = "RDS subnet group"
  subnet_ids  =   module.vpc.public_subnets
}

#-----------------------------------------------------------------------------------------------
#allows you to specify parameters to cahnge settings in the database
#-----------------------------------------------------------------------------------------------
resource "aws_db_parameter_group" "mariadb-parameters" {
  name        = "${local.default_name}-mariadb-parameters"
  family      = "mariadb10.1"
  description = "MariaDB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

#-----------------------------------------------------------------------------------------------
#you can easey setup replication HA, automated snapshots (backups), security updates, easy instance replacement
#(for vertical scaling)
#supported databases mysql, mariadb, postgresql, sql, oracle.
#-----------------------------------------------------------------------------------------------
resource "aws_db_instance" "mariadb" {
  allocated_storage       = 100 # 100 GB of storage, gives us more IOPS than a lower number
  engine                  = "mariadb"
  engine_version          = "10.1.14"
  instance_class          = "db.t2.small" # use micro if you want to use the free tier
  identifier              = "codepipeline"
  name                    = "mariadb"
  username                = "root"           # username
  password                = var.RDS_PASSWORD # password
  db_subnet_group_name    = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name    = aws_db_parameter_group.mariadb-parameters.name
  multi_az                = "false" # set to true to have high availability: 2 instances synchronized with each other
  vpc_security_group_ids  = [aws_security_group.allow-mariadb.id]
  storage_type            = "gp2"
  backup_retention_period = 30                                          # how long you’re going to keep your backups
  availability_zone       = aws_subnet.main-private-1.availability_zone # prefered AZ
  skip_final_snapshot     = true                                        # skip final snapshot when doing terraform destroy

  tags = {
    Name = "${local.default_name}-mariadb-rds"
  }
}

-----------------------------------------

output "rds_endpoint" {
  value = aws_db_instance.mariadb.endpoint
}

#------------------------------------------------------
