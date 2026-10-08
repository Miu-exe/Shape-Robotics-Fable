{
  description = "Fable Blocks: run the web app locally (nginx + the remote-mode relay), the NixOS-native way";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems f;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          version = "0.13.6";
          fable-blocks = pkgs.stdenv.mkDerivation {
            pname = "fable-blocks";
            inherit version;
            src = ./nix;
            dontBuild = true;
            nativeBuildInputs = [ pkgs.makeWrapper ];
            installPhase = ''
              mkdir -p $out/share/fable-blocks
              cp -r $src/site $out/share/fable-blocks/site
              cp $src/relay.cjs $out/share/fable-blocks/relay.cjs
              cp $src/nginx.conf.template $out/share/fable-blocks/nginx.conf.template

              substitute $src/run.sh $out/share/fable-blocks/run.sh \
                --subst-var-by OUT "$out" \
                --subst-var-by NGINX "${pkgs.nginx}" \
                --subst-var-by NODE "${pkgs.nodejs_22}"
              chmod +x $out/share/fable-blocks/run.sh

              mkdir -p $out/bin
              makeWrapper $out/share/fable-blocks/run.sh $out/bin/fable-blocks \
                --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.xdg-utils ]}
            '';
            meta = {
              description = "Fable Blocks web app, served locally (no install step, no dependency on robotics.miuthecat.uk)";
              mainProgram = "fable-blocks";
              license = pkgs.lib.licenses.mit;
              platforms = systems;
            };
          };
        in
        {
          inherit fable-blocks;
          default = fable-blocks;
        });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.fable-blocks}/bin/fable-blocks";
        };
      });
    };
}
