{
  description = "neovim flake with config and deps";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    deps = with pkgs; [
      # For lazygit plugin
      lazygit

      # VimTex Deps
      tree-sitter
      # nodejs_22

      # Telescope Deps
      ripgrep

      # LSPs
      nixd
      texlab
      lua-language-server
      svelte-language-server
      jdt-language-server
      # ocamlPackages.ocaml-lsp
      typescript-language-server
      vim-language-server
      basedpyright
      csharp-ls
      cmake-language-server
      tailwindcss-language-server
      # This is also the entirety of clang
      llvmPackages_21.clang-tools
      # ccls

      # Formatters
      markdownlint-cli
      alejandra
      tex-fmt
      yq-go
      black
      jq
      stylua
      nodePackages.prettier

      # Debugger adapters
      vscode-extensions.ms-vscode.cpptools

      # Debuggers
      gdb
    ];
  in {
    packages.${system} = {
      limConfig = ./.;
      limDeps = deps;
    };

    homeManagerModules = {
      default = {
        config,
        pkgs,
        ...
      }: {
        programs.home-manager.enable = true;
        home.file.".config/nvim".source = self.packages.${system}.limConfig;
        home.packages = self.packages.${system}.limDeps;
        programs.neovim.enable = true;
        home.sessionVariables.OPEN_DEBUG_AD7 = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";
      };
    };
  };
}
