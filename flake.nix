{
  description = "neovim flake with config and deps";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    deps = with pkgs; [
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
      ocamlPackages.ocaml-lsp
      typescript-language-server
      vim-language-server
      basedpyright
      csharp-ls
      cmake-language-server
      tailwindcss-language-server
      ccls
      # This is also the entirety of clang
      llvmPackages_20.clang-tools

      # Formatters
      mdformat
      alejandra
      tex-fmt
      yq-go
      black
      jq
      stylua
      nodePackages.prettier
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
      };
    };
  };
}
