resource "null_resource" "null" {
  count = 3
  provisioner "local-exec" {
    command ="echo index no - ${count.index}"
  }
}
# in this resource run 3 times