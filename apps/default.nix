{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Browsers
    # firefox
    chromium

    # Office suite
    libreoffice
    # scribus

    # Teaching
    texlive.combined.scheme-full

    # Vector graphics
    inkscape

    # Photo/image editor
    gimp
    #gimpPlugins.resynthesizer
    #gimpPlugins.ufraw
    
    # Media player
    vlc

    # Communication
    skype
    slack

    # Disk usage analysis
    baobab ncdu

    # Partitions
    gparted

    # Music
    spotify

    # Sharing
    dropbox
    syncthing
  ];

  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
    };
  };
}
