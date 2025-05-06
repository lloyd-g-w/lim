{
  description = "Standalone Neovim config flake";

  inputs = {};  # no dependencies

  outputs = { self, ... }@inputs:
  let
    system = "x86_64-linux";  # adjust if you need aarch64, etc.
  in {
    # expose your repo checkout as a package called `neovimConfig`
    packages.${system}.neovimConfig = ./.;
  };
}

