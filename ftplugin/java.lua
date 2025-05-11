local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")
local home = os.getenv("HOME")
local cache_dir = home .. "/.cache/jdtls"

-- Ensure writable config directory exists
vim.fn.mkdir(cache_dir, "p")
vim.fn.system({ "cp", "-r", vim.fn.glob("/nix/store/*jdt-language-server*/share/java/jdtls/config_linux"), cache_dir })

local config_path = cache_dir .. "/config_linux"

-- Find plugin JAR and lombok as before
local jar_path = vim.fn.glob(
	"/nix/store/*-jdt-language-server-*/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
	false,
	true
)[1] or ""
local lombok_path = vim.fn.glob("/nix/store/*lombok*/share/java/lombok.jar", false, true)[1] or ""

if jar_path == "" or not vim.loop.fs_stat(config_path) then
	vim.notify("JDTLS: failed to find or copy required files", vim.log.levels.ERROR)
	return
end

local root_markers = { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers) or vim.fn.getcwd()

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

jdtls.start_or_attach(config)
