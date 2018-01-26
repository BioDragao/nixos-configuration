{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Browsers
    # firefox
    chromium

    # Office suite
    libreoffice
    # scribus

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

  ];
}