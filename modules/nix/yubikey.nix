{pkgs, ...}: {
  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
  };

  security.polkit.enable = true;
}
