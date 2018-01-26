{ config, pkgs, ... }:
{
  # Use Plasma 5
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  environment.systemPackages = with pkgs; [
    # Archives (e.g., tar.gz and zip)
    ark

    # GPG manager for KDE
    kgpg

    # This is needed for graphical dialogs used to enter GPG passphrases
    pinentry_qt5

    kdeplasma-addons

    # Text editor
    # kate

    # Torrenting
    # ktorrent

    # Connect desktop and phone
    # kdeconnect

    # Drop-down terminal (F12)
    yakuake

    # Printing and scanning
    kdeApplications.print-manager
    simple-scan

     # Screenshots
    kdeApplications.spectacle

    # Document readers
    kdeApplications.okular

    # Image viewer
    gwenview
   
    # Email
    kdeApplications.kmail
    kdeApplications.kontact
    kdeApplications.korganizer
    
    # KDE apps
    kdeApplications.kompare
    kdeApplications.kolourpaint
    kdeFrameworks.kconfig
    kdeFrameworks.kconfigwidgets
    kdeApplications.konsole
    dolphin
    kdeApplications.dolphin-plugins

  ];

}
