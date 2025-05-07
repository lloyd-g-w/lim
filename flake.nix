{
  description = "neovim flake with config and deps";

    inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs, ... }@inputs:
 let
    system = "x86_64-linux";
    pkgs   = import nixpkgs { inherit system; };
    deps   = with pkgs; [
      neovim
    ];
  in {
    # 1) expose the raw repo path so you can do `.source = limConfig;`
    packages.${system}.limConfig = ./.;

    # 2) expose the list of dependencies
    packages.${system}.limDeps = deps;

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

