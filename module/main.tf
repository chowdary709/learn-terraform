# give a input distract  in module

module "test-1" {
  source = "./local-module"
  input = "hari chandra prasad"
}

# give a input  module in a variable

module "test-2" {
  source = "./local-module"
  input = var.input
}

variable "input" {
  default = "hari chandra prasad"
}