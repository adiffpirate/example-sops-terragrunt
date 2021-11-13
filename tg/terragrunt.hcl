locals {
	secrets = jsondecode(run_cmd("--terragrunt-quiet", find_in_parent_folders("decrypt_tfvars.sh"), "secrets.tfvars"))
}

inputs = merge(
	local.secrets,
	{
		project = "teste"
		env     = "hml"
	}
)
