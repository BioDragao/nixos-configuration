{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Version control
    gitAndTools.gitFull

    # JVM
    openjdk8 visualvm # oraclejre8

    # Scala
    scala sbt ammonite

    # editors
    vscode 
    jetbrains.idea-community

    # Python
    python27Full
  ];

  virtualisation = {

    # VirtualBox
    virtualbox.host = {
      enable = true;
      enableHardening = false;
      addNetworkInterface = true;
    };

    # Docker
    docker = {
      enable = true;
      storageDriver = "devicemapper";
    };
  };
}
