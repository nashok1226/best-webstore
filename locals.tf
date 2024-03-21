locals {
  security_groups = {
    public = {
      name        = "web-public-sg"
      description = "sg for web access"
      ingress = {
        web_access = {
          from        = 80
          to          = 80
          protocol    = "TCP"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }

    private = {
      name        = "web-private-sg"
      description = "ag for lb access"
      ingress = {
        instance_access = {
          from     = 80
          to       = 80
          protocol = "TCP"
        }
      }
    }
  }
}