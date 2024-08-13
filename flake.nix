{
  description = "Add new Git remotes easily";
  outputs = { self, nixpkgs }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.platforms.unix;

      nixpkgsFor = forAllSystems (system: import nixpkgs {
        inherit system;
      });
    in
      {
        packages = forAllSystems (system:
          let pkgs = nixpkgsFor.${system}; in
          {
            gra = pkgs.stdenv.mkDerivation {
              name = "gra";
              src = self;
              installPhase = ''
                install -m 755 -D gra $out/bin/gra
                install -m 644 -D gra_completion.bash $out/share/bash-completion/completions/gra
              '';
            };
            default = self.packages.${system}.gra;
        });
      };
}
