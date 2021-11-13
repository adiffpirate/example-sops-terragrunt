terraform {
	before_hook "tfvars_decrypt_and_convert_to_json" {
		commands = ["apply", "plan"]
		execute  = ["../scripts/decrypt_tfvars.sh", "secrets.tfvars", ">", "/tmp/tg_teste_decrypted_vars.json"]
	}

	# after_hook "delete_decrypted_tfvars" {
	# 	commands = ["apply", "plan"]
	# 	execute  = ["rm", "/tmp/tg_teste_decrypted_vars.json"]
	# }
}

locals {
	secrets = jsondecode(file("/tmp/tg_teste_decrypted_vars.json"))
}

inputs = merge(
	local.secrets,
	{
		project = "teste"
		env     = "hml"
	}
)
