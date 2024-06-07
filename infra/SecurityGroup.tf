resource "aws_security_group" "ssh_cluster" {
    name = "ssh_cluster"
    vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "ssh_cluster_in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # Comunicação externa
  cidr_blocks       = ["0.0.0.0/0"] # Todas os ips podem acessar nossa aplicação
  security_group_id = aws_security_group.ssh_cluster.id
}

resource "aws_security_group_rule" "ssh_cluster_out" {
  type              = "egress"
  from_port         = 0 # Todas as portas liberadas
  to_port           = 0 # Todas as portas liberadas
  protocol          = "-1" # Qualquer protocolo
  cidr_blocks       = ["0.0.0.0/0"] # Todas os ips podem acessar nossa aplicação
  security_group_id = aws_security_group.ssh_cluster.id
}