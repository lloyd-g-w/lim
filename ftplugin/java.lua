local home = os.getenv("HOME")
local jdtls_path = home .. "/.local/share/jdtls"
local jar_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_path = jdtls_path .. "/config_linux"
local lombok_path = jdtls_path .. "/lombok.jar"

if jar_path == "" then
	vim.notify("Could not find launcher JAR", vim.log.levels.ERROR)
	return
end

local root_markers = { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers) or vim.fn.getcwd()

local config = {
	cmd = {
		"java",
		"-javaagent:" .. lombok_path,
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
		"-jar",
		jar_path,
		"-configuration",
		config_path,
		"-data",
		home .. "/.cache/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t"),
	},
	root_dir = root_dir,
}

require("jdtls").start_or_attach(config)
