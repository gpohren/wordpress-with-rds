resource "aws_key_pair" "wp_key" {
  key_name   = "wp_key"
  public_key = file(var.aws_key_path)
}