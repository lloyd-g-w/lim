{
  description = "A portable Neovim configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  } @ inputs: let
    # Define a function that returns the list of dependency packages for a given `pkgs`.
    # This keeps the list defined in one place and makes it reusable for the shell and home-manager.
    getNeovimDeps = pkgs:
      with pkgs; [
        # For lazygit plugin
        lazygit

        # VimTex Deps
        tree-sitter

        # Latex
        texpresso
        tectonic

        # Telescope Deps
        ripgrep

        # LSPs
        nixd
        texlab
        lua-language-server
        svelte-language-server
        jdt-language-server
        # ocamlPackages.ocaml-lsp # Uncomment if you write OCaml
        typescript-language-server
        vim-language-server
        basedpyright # For Python
        csharp-ls
        cmake-language-server
        tailwindcss-language-server
        tinymist
        rust-analyzer
        zls
        qt6.full

        # Packages that include lsps
        llvmPackages.clang-tools # clangd

        # Formatters
        tex-fmt
        rustfmt
        markdownlint-cli
        alejandra # For Nix
        yq-go
        black # For Python
        jq
        stylua # For Lua
        nodePackages.prettier
        astyle

        # Debugger adapters
        vscode-extensions.ms-vscode.cpptools

        # Debuggers
        gdb
      ];

    # We first generate all the per-system outputs using flake-utils.
    # We store this in a variable `perSystemOutputs` to avoid recursive `self` references later.
    perSystemOutputs = flake-utils.lib.eachDefaultSystem (
      system: let
        # Import nixpkgs for the current system, allowing unfree packages
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # Get the list of dependencies for the current system
        deps = getNeovimDeps pkgs;

        # Package the neovim configuration directory itself.
        neovim-config-pkg = ./.;
        neovim-init = ./init.lua;

        # A helper variable for the cpptools path for clarity
        cppToolsPath = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools";
      in {
        # Package the neovim configuration directory itself.
        # This makes it a clean, referenceable build artifact.
        packages.neovim-config = neovim-config-pkg;

        # Development shell, accessible via `nix develop`
        devShells.default = pkgs.mkShell {
          name = "neovim-dev-shell";

          # Add Neovim itself and all its dependencies to the shell's PATH
          packages = [pkgs.neovim] ++ deps;

          # A hook that runs when you enter the shell
          shellHook = ''
            # Set environment variables required by plugins
            export OPEN_DEBUG_AD7="${cppToolsPath}/debugAdapters/bin/OpenDebugAD7"

            # Create an alias so that running `nvim` in the shell uses this flake's configuration.
            alias nvim='nvim --cmd "set rtp^=${neovim-config-pkg}" -u ${neovim-init}'

            echo "Neovim dev shell activated."
          '';
        };

        apps = let
          limApp = pkgs.writeShellApplication {
            name = "lim";
            runtimeInputs = [pkgs.neovim] ++ deps;
            # "$@" adds all the args
            text = ''
              export OPEN_DEBUG_AD7="${cppToolsPath}/debugAdapters/bin/OpenDebugAD7"
              exec nvim --cmd "set rtp^=${neovim-config-pkg}" -u ${neovim-init} "$@"
            '';
          };
        in {
          default = {
            type = "app";
            program = "${limApp}/bin/lim";
          };
        };
      }
    );
  in
    # We merge the per-system outputs with the system-independent home-manager module.
    perSystemOutputs
    // {
      # Home Manager module, defined outside the per-system loop.
      # It can be imported into any home-manager configuration.
      homeManagerModules.default = {
        config,
        pkgs,
        ...
      }: {
        programs.home-manager.enable = true;

        nixpkgs.config.allowUnfree = true;
        nixpkgs.config.permittedInsecurePackages = [
          "libsoup-2.74.3"
        ];

        # Source the neovim configuration from this flake.
        # By using `perSystemOutputs` instead of `self`, we avoid the evaluation error.
        home.file.".config/nvim".source = perSystemOutputs.packages.${pkgs.stdenv.hostPlatform.system}.neovim-config;

        # Install all dependency packages into the user's profile.
        home.packages = getNeovimDeps pkgs;

        # Enable the home-manager neovim module for basic setup.
        programs.neovim.enable = true;

        # Set the environment variable system-wide for the C/C++ debugger.
        home.sessionVariables.OPEN_DEBUG_AD7 = let
          # Ensure we get the cpptools package for the correct system.
          cppTools = pkgs.vscode-extensions.ms-vscode.cpptools;
        in "${cppTools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";
      };
    };
}
