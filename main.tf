provider "googleworkspace" {
  credentials             = "${file("serviceaccount.yaml")}"
  customer_id             = "C04fayzre"
  impersonated_user_email = "andre@andreag.com.br"
  oauth_scopes = [
   "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.userschema",
    "https://www.googleapis.com/auth/admin.directory.group",		
    # include scopes as needed
  ]
}

resource "googleworkspace_group" "estatisticas" {
  email       = "estatisticas@andreag.com.br"
  name        = "estatisticas"
  description = "Grupo estatisticas"


  timeouts {
    create = "1m"
    update = "1m"
  }
}

resource "googleworkspace_user" "estat" {
  primary_email = "estat@andreag.com.br"
  password      = "34819d7beeabb9260a5c854bc85b3e44"
  hash_function = "MD5"

  name {
    family_name = "estatistica"
    given_name  = "Ninguem"
  }
}

resource "googleworkspace_group_member" "manager" {
  group_id = googleworkspace_group.estatisticas.id
  email    = googleworkspace_user.estat.primary_email

  role = "MANAGER"
}