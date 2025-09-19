{settings, pkgs, inputs, lib, ...}: let
   unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
in{
  home-manager.users.${settings.account.name}.programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
     gc = "sudo nix-collect-garbage --delete-old";
    };
    oh-my-zsh ={
      enable = true;
      plugins = ["vscode" "git"];
    };
    initContent = lib.mkAfter ''
        fastfetch
        export OCIO="/home/justaturtle/PixelManager-master"
    '';
    autosuggestion = {
      enable = true;
      strategy = [
        "history"
      ];
    };
  };
}
