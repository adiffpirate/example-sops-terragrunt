terraform {
	extra_arguments "decrypted_tfvars" {
		commands  = get_terraform_commands_that_need_vars()
		required_var_files = [run_cmd("--terragrunt-quiet", "${find_in_parent_folders("scripts")}/decrypt_tfvars.sh", "input.tfvars")]
	}
}

# inputs = yamldecode(sops_decrypt_file("input.yaml"))
