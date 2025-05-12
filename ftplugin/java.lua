local config = {
	cmd = {
		"jdtls", -- the nix-provided wrapper
		"-data",
		vim.fn.stdpath("data") .. "/jdtls-workspace",
	},
	root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "build.gradle" }),
	settings = { java = {} },
	init_options = { bundles = {} },
}
require("jdtls").start_or_attach(config)
