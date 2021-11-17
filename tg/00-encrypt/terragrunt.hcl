terraform {
	after_hook "get_encription_key" {
		commands     = ["apply"]
		execute      = ["${find_in_parent_folders("scripts")}/get_encription_key.sh"]
	}
}
