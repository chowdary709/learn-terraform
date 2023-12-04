module "expense" {
  count     = length(var.expense)
  source    = "./module"
  component = var.expense[count.index]
}

variable "expense" {
  default = ["frontend", "mysql", "backend"]
}