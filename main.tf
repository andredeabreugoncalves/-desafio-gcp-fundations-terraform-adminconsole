provider "googleworkspace" {
  credentials             = "${file("serviceaccount.yaml")}"
  customer_id             = "C04fayzre"
  impersonated_estatisiticas_email = "andre@andreag.com.br"
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.estatisiticas",
    "https://www.googleapis.com/auth/admin.directory.estatisiticasschema",
    "https://www.googleapis.com/auth/admin.directory.group",	
    # include scopes as needed
  ]
}

resource "googleworkspace_group" "estatisiticas" {
  email       = "estatisiticas@andreag.com.br"
  name        = "estatisiticas"
  description = "Grupo estatisiticas"


  timeouts {
    create = "1m"
    update = "1m"
  }
}

resource "googleworkspace_estatisiticas" "estatisiticas" {
  primary_email = "estatisiticas@andreag.com.br"
  password      = "34819d7beeabb9260a5c854bc85b3e44"
  hash_function = "MD5"

  name {
    family_name = "estatisiticas"
    given_name  = "Ninguem"
  }
}

resource "googleworkspace_group_member" "manager" {
  group_id = googleworkspace_group.estatisiticas.id
  email    = googleworkspace_estatisiticas.estatisiticas.primary_email

  role = "MANAGER"
}