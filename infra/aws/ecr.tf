resource "aws_ecrpublic_repository" "tfer--srelab" {
  catalog_data {
    architectures     = ["ARM 64"]
    operating_systems = ["Linux"]
  }

  force_destroy   = "false"
  repository_name = "srelab"
}