{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nix-repl
    wget 
    vim
    openssl
    openssh
    curl
    man
    tree 
    which 
    xclip
    
    # fancy command line shell 
    fish
    # command-line partition utils 
    gptfdisk 
    # process watch
    htop
    # json data processing 
    jq 
    # list open files
    lsof 
    # A set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
    psmisc 
    # adjust screen brightness automatically
    redshift
  ];

  services = { 
    redshift = {
      enable = true;

      # Lausanne
      latitude = "46.516";
      longitude = "6.63282";
    };
  };
}