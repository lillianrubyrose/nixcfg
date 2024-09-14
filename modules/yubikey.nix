{ pkgs, ... }:

{
  services.pcscd.enable = true;
  # services.dbus.packages = [ pkgs.gcr ];
  environment.systemPackages = with pkgs; [ kdePackages.polkit-kde-agent-1 ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  security.polkit.enable = true;

  systemd = {
    user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit-kde-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
      };
    };
    extraConfig = ''
    DefaultTimeoutStopSec=10s
    '';
  };
}
