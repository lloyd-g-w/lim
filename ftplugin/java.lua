local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")
local home = os.getenv("HOME")

-- Get Java 21 executable from environment (or fallback)
local java_exe = os.getenv("JAVA_21_EXE") or "java"

-- Find project root
local root_markers = { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers) or vim.fn.getcwd()

-- Find paths installed via Nix
local jar_path = vim.fn.glob(
	"/nix/store/*-jdt-language-server-*/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
	false,
	true
)[1] or ""
local config_path = vim.fn.glob("/nix/store/*-jdt-language-server-*/share/java/jdtls/config_linux", false, true)[1]
	or ""
local lombok_path = vim.fn.glob("/nix/store/*lombok*/share/java/lombok.jar", false, true)[1] or ""

-- Safety checks
if jar_path == "" or config_path == "" then
	vim.notify("JDTLS: Failed to find required JAR or config", vim.log.levels.ERROR)
	return
end

-- Setup config
local config = {
	cmd = {
		java_exe,
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
}

-- Launch JDTLS
jdtls.start_or_attach(config)
