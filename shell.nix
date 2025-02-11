let
  pkgs =
    import
      # f9f0d5 is 241203
      (fetchTarball "https://github.com/NixOS/nixpkgs/archive/f9f0d5c5380be0a599b1fb54641fa99af8281539.tar.gz")
      { };
in
pkgs.mkShell {
  packages = with pkgs; [
    nodejs_23
  ];
}
