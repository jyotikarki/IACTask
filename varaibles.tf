variable "vendor_configs" {
  type = map(string)
  default = {
    vendor1 = "${path.module}/configs/vendor1.json",
    vendor2 = "${path.module}/configs/vendor2.json"
  }
}


