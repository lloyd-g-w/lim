local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")
local home = os.getenv("HOME")

-- Get Java 21 executable path from environment variable
local java_exe = os.getenv("JAVA_21_EXE")
if not java_exe then
	-- Fallback if the environment variable isn't set
	print("Warning: JAVA_21_EXE environment variable not set, using default 'java' command")
	java_exe = "java"
end

-- Find root of project
local root_markers = { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers)
if root_dir == "" then
	root_dir = vim.fn.getcwd()
end

-- Setup JDTLS config
local jdtls_path = vim.fn.stdpath("data") .. "/jdtls"
local config_path = jdtls_path .. "/config_linux" -- Adjust for your OS (linux/mac/win)
local plugins_path = jdtls_path .. "/plugins/"
local jar_path = vim.fn.glob(plugins_path .. "org.eclipse.equinox.launcher_*.jar")
local lombok_path = jdtls_path .. "/lombok.jar"

local config = {
	cmd = {
		java_exe, -- Use the Java 21 executable here
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. lombok_path,
		"-jar",
		jar_path,
		"-configuration",
		config_path,
		"-data",
		home .. "/.cache/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t"),
	},
	root_dir = root_dir,
	-- Rest of your configuration remains the same
	-- ...
}

-- Set up the LSP
jdtls.start_or_attach(config)
