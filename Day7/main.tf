provider "aws" {
    region = "us-east-1"
}

variable "cidr" {
    default = "10.0.0.0/16"
}

resource "aws_key_pair" "example" {
    key_name    = "terraform-demo-adil" 
    public_key  = file("~/.ssh/id_ed25519.pub") 
}

resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr  
}

resource "aws_subnet" "sub1" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              =   "10.0.0.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true 
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.myvpc.id

    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = aws_internet_gateway.igw.id  
    }  
}

resource "aws_route_table_association" "rta1" {
    subnet_id      = aws_subnet.sub1.id
    route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "websg" {
  name   = "web"
  vpc_id = aws_vpc.myvpc.id

  dynamic "ingress" {
    for_each = [80, 22]
    content {
      description = "Allow port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Note the plural 'cidr_blocks'
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "web-sg"
  }
}

resource "aws_instance" "server" {
    ami                    = "ami-0d97d7f07b25dd693"
    instance_type          =  "t3.micro"
    key_name               =  aws_key_pair.example.key_name
    vpc_security_group_ids = [aws_security_group.websg.id]
    subnet_id              = aws_subnet.sub1.id 


    connection {
    type            = "ssh"
    user            = "ubuntu"
    private_key     =   file("~/.ssh/id_ed25519")
    host            =   self.public_ip
    }

    # provisioner "file" {
    #     source = "app.py"
    #     destination = "/home/ubuntu/app.py"  
    # }


    provisioner "file" {
        source = "index.html"
        destination = "/tmp/index.html"  
    }


    provisioner "remote-exec" {
        inline = [ 
            "sudo apt-get update -y",
            "sudo apt-get install nginx -y",
            "sudo mkdir -p /var/www/html",
            "sudo install -m 644 /tmp/index.html  /var/www/html/index.html",
            "sudo systemctl reload nginx"
        ]
      
    }

    provisioner "local-exec" {
        command = "echo ${self.id} >> instance_ids.txt" 
    }

    
    # provisioner "remote-exec" {
    #     inline = [ 
    #         "echo 'Hello from the remote instance' ",
    #         "sudo apt update -y",
    #         "sudo apt install python3-flask -y",
    #         "cd /home/ubuntu",
    #         "sudo pip3 install flask",
    #         "sudo python3 app.py &"
    #     ]
      
    # } 
}




