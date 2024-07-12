{
  description = "Add new Git remotes quickly";
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
              '';
            };
            default = self.packages.${system}.gra;
        });
      };
}
