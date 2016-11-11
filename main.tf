provider "aws" {
  region = "${var.aws_region}"
  #shared_credentials_file = "${var.credentials_file}"
  #profile = "${var.credentials_profile}"
}

module "stack_ext_ssl" {
  source = "../../modules/stack_ext_ssl"

  credentials_file    = "${var.credentials_file}"
  credentials_profile = "${var.credentials_profile}"
  aws_region          = "${var.aws_region}"

  project_name = "${var.project_name}"
  service_name = "${var.service_name}"
  environment  = "${var.environment}"
  uuid         = "${var.uuid}"

  user_data       = "${element(concat(data.template_file.user_data_var.*.rendered, data.template_file.user_data_file.*.rendered), 0)}"
  iam_role        = "${element(concat(data.template_file.iam_role_var.*.rendered, data.template_file.iam_role_file.*.rendered), 0)}"
  iam_role_policy = "${element(concat(data.template_file.iam_role_policy_var.*.rendered, data.template_file.iam_role_policy_file.*.rendered), 0)}"
}


data "template_file" "user_data_file" {
  template = "${file("${path.module}/userdata.sh")}"
  count    = "${ replace(replace(var.user_data, "/.+/", "0"), "/^$/", "1") }"
}

data "template_file" "user_data_var" {
  template = "${var.user_data}"
  count    = "${ replace(replace(var.user_data, "/.+/", "1"), "/^$/", "0") }"
}


data "template_file" "iam_role_file" {
  template = "${file("${path.module}/iam_role.json")}"
  count    = "${ replace(replace(var.iam_role, "/.+/", "0"), "/^$/", "1") }"
}

data "template_file" "iam_role_var" {
  template = "${var.iam_role}"
  count    = "${ replace(replace(var.iam_role, "/.+/", "1"), "/^$/", "0") }"
}


data "template_file" "iam_role_policy_file" {
  template = "${file("${path.module}/iam_role_policy.json")}"
  count    = "${ replace(replace(var.iam_role_policy, "/.+/", "0"), "/^$/", "1") }"
}

data "template_file" "iam_role_policy_var" {
  template = "${var.iam_role_policy}"
  count    = "${ replace(replace(var.iam_role_policy, "/.+/", "1"), "/^$/", "0") }"
}

