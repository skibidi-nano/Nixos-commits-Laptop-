{
  description = "J's Flake Configuration mit funktionierender Unstable-Kopplung";

  inputs = {
    # Nutzt den instabilen Kanal, auf dem Ihr System läuft
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Koppelt Home-Manager an den master-Branch für unstable-Systeme
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.cocktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.j = import ./home.nix;
        }
      ];
    };
  };
}
