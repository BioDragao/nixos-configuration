let

  createUser = { username, id, realname, keys }: { groups }: {
    username = username;
    group.gid = id;
    user = {
      description = realname;
      uid = id;
      group = username;
      extraGroups = [ "networkmanager" "users"  "audio" "disk" "docker" "plugdev"
      "systemd-journal" "wheel" "vboxusers" "video"] ++ groups;
      home = "/home/${username}";
      isNormalUser = true;
      openssh.authorizedKeys.keys = keys;
    };
  };

  createUsers = xs: builtins.listToAttrs (
    builtins.map
    (
      x: {
        name = x.username;
        value = (createUser x);
      }
    )
    xs
  );

in createUsers [
  {
    username = "jchapuis";
    realname = "Jonas Chapuis";
    id = 1000;
    keys = [
       "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDHXTfECHVwgkguyvPB1Dn8cf3hgsUs4Q087YbtXL8ehXTZKBln6BhOPBO6FwVjRn/yDvyANpB9VRCOBbfOOtRYh12QoG4WYHtv+g9Y/r6vdu9LCkfUWUSFs9YRHLco92NDdj+AD2f4V+G502EkIOwAegtyj1u9QfaRnFf+QM7ytJAMeRDweWxsr6gfd8E67X/5EQtdnXGBBotovy5Hz65ku+2w8EyqgjfPs4iVEHkcaeXipBA/hFlh60/bmhHmRhh1w2LPRhKSP7Y7LdrMyxJQQtXsZNlfPhtYLzwMrm7n44oxe60+e1qUyHtbFjn0aysNijF+cIa4xWXBQ5ltJjV/ jonas.chapuis@nexthink.com"
    ];
  }

]
