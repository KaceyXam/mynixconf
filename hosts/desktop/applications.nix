{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    prismlauncher
    discord-canary
  ];
}
