#-----------------------------------------------------------------------------------------------------------------
resource "aws_instance" "win-example" {
  ami           = lookup(var.WIN_AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  # the VPC subnet$
  subnet_id = aws_subnet.main-public-1.id

  security_groups = ["${aws_security_group.sg_win.id}"]

  #vpc_security_group_ids = ["${aws_security_group.my_security_group.id}"]

  key_name = aws_key_pair.mykey.key_name

  user_data = <<EOF

<powershell>
net user ${var.INSTANCE_USERNAME} '${var.INSTANCE_PASSWORD}' /add /y
net localgroup administrators ${var.INSTANCE_USERNAME} /add

winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow

net stop winrm
sc.exe config winrm start=auto
net start winrm
</powershell>
EOF

  provisioner "file" {
    source      = "test.txt"
    destination = "C:/test.txt"
  }

  # connection {
  #   host = coalesce(self.public_ip, self.private_ip)
  #   type = "winrm"
  #   timeout = "20m"
  #   user = "${var.INSTANCE_USERNAME}"
  #   password = "${var.INSTANCE_PASSWORD}"
  # }

  tags = {
    Name = "Windown instance"
  }
}
#-----------------------------------------------------------------------------------------------------------------
output "ipaddress" {
  value = aws_instance.win-example.public_ip

}
#-----------------------------------------------------------------------------------------------------------------

