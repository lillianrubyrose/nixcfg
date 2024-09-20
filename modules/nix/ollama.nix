{
  lib,
  config,
  ...
}: {
  options.queernix.ollama = {
    enable = lib.mkEnableOption "Enable ollama";
    cpu = lib.mkEnableOption "Enable CPU acceleration";
    rocm = lib.mkEnableOption "Enable ROCm acceleration";
    cuda = lib.mkEnableOption "Enable CUDA acceleration";
  };

  config = lib.mkIf config.queernix.ollama.enable {
    services.ollama = {
      enable = true;
      acceleration =
        if config.queernix.ollama.cpu
        then "cpu"
        else if config.queernix.ollama.rocm
        then "rocm"
        else if config.queernix.ollama.cuda
        then "cuda"
        else null;
    };
  };
}
