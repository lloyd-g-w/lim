{
  description = "A portable Neovim configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # flake-utils provides helper functions to make flakes portable across systems
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
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
        llvmPackages.clang-tools # For C/C++, includes clangd. More portable than a versioned package.
        # ccls # Alternative to clangd

        # Formatters
        markdownlint-cli
        alejandra # For Nix
        yq-go
        black # For Python
        jq
        stylua # For Lua
        nodePackages.prettier

        # Debugger adapters
        vscode-extensions.ms-vscode.cpptools

        # Debuggers
        gdb
      ];
  in
    # Use flake-utils to generate outputs for common systems (x86_64-linux, aarch64-linux, etc.)
    flake-utils.lib.eachDefaultSystem (
      system: let
        # Import nixpkgs for the current system, allowing unfree packages
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # Get the list of dependencies for the current system
        deps = getNeovimDeps pkgs;

        # A helper variable for the cpptools path for clarity
        cppToolsPath = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools";
      in {
        # Development shell, accessible via `nix develop`
        devShells.default = pkgs.mkShell {
          name = "neovim-dev-shell";

          # Add Neovim itself and all its dependencies to the shell's PATH
          packages = [pkgs.neovim] ++ deps;

          # A hook that runs when you enter the shell
          shellHook = ''
            # Set environment variables required by plugins
            export OPEN_DEBUG_AD7="${cppToolsPath}/debugAdapters/bin/OpenDebugAD7"
            echo "Neovim dev shell activated."
            echo "Run 'nvim' to start."
          '';
        };

        # Package the neovim configuration directory itself.
        # This makes it a clean, referenceable build artifact.
        packages.neovim-config = ./.;
      }
    )
    // {
      # Home Manager module, defined outside the per-system loop.
      # It can be imported into any home-manager configuration.
      homeManagerModules.default = {
        config,
        pkgs,
        ...
      }: {
        programs.home-manager.enable = true;

        # Source the neovim configuration from this flake.
        # It correctly references the package for the system home-manager is building for.
        home.file.".config/nvim".source = self.packages.${pkgs.system}.neovim-config;

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
