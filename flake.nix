{
  description = "neovim flake with config and deps";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11"; };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      deps = with pkgs; [
        # VimTex Deps
        tree-sitter
        # nodejs_22

        # Telescope Deps
        ripgrep

        # LSPs
        nil
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

        # Formatters
        nixfmt-rfc-style
        tex-fmt
        yq-go
        black
        jq
        eslint_d
        stylua
        nodePackages.prettier
      ];
    in {
      # 1) expose the raw repo path so you can do `.source = limConfig;`
      # 2) expose the list of dependencies
      packages.${system} = {
        limConfig = ./.; # the root of this repo
        limDeps = deps; # the list of tools
      };

      # 3) export a Home-Manager **module** that wires both together
      home-manager-module = { config, pkgs, ... }: {
        # Make sure HM is enabled
        programs.home-manager.enable = true;

        # Deploy your repo into ~/.config/nvim
        home.file.".config/nvim".source = self.packages.${system}.limConfig;

        # Install your bundle of tools
        home.packages = self.packages.${system}.limDeps;

        programs.neovim.enable = true;
      };
    };
}
