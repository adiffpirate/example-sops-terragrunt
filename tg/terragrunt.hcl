locals {
	secrets = yamldecode(sops_decrypt_file("secrets.yaml"))
}

inputs = merge(
	local.secrets,
	{
		project = "teste"
		env     = "hml"
	}
)
