{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # andika
    atkinson-hyperlegible
    atkinson-hyperlegible-next
    # atkinson-hyperlegible-mono
    cascadia-code
    commit-mono
    crimson-pro
    departure-mono # Checkout the website @ https://departuremono.com!
    font-awesome
    ibm-plex
    # iosevka
    # jetbrains-mono
    # lexend
    liberation_ttf
    libertinus
    monaspace
    nerd-fonts.inconsolata
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    ttf-tw-moe
    ocr-a
  ];
}
