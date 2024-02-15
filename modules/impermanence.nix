{
  environment.persistence."/nix/persistent" = {
    hideMounts = true;
    
    directories = [
      "/var/log"
      "/var/lib"
      "/etc/NetworkManager/system-connections"
      "/etc/v2raya"
    ];
    
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
    ];
    
    users.ethan = {
      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Videos"
        "Pictures"
        "Ethan"
	"scripts"
         
        ".cache"
        ".config"
        ".local"
	".mozilla"
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
      ];
    };
  };

  systemd.services.nix-daemon = {
    environment = {
      TMPDIR = "/var/cache/nix";
    };
    serviceConfig = {
      CacheDirectory = "nix";
    };
  };
  environment.variables.NIX_REMOTE = "daemon";
}
