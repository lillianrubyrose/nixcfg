{
  lib,
  config,
  ...
}: {
  options.queernix.pipewire = {
    enable = lib.mkEnableOption "Enable PipeWire";
  };

  config = lib.mkIf config.queernix.pipewire.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
