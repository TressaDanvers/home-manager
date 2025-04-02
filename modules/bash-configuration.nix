{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ tree ];

  programs = {
    bash = {
      enable = true;
      historyFile = "$XDG_STATE_HOME/bash/shell-history";
      initExtra = ''
        _ec() {
          local EC=$?;
          if ! [[ $EC == 0 ]]; then
            echo '-[ '$'\e[31mEC'$'\e[39m:'$EC' ]'
          fi
        }

        PS1='\[\e[1m\][ \[\e[32m\]\u\[\e[39m\]@\[\e[33m\]\h\[\e[39m\] ]-[ \[\e[34m\]\W\[\e[39m\] ]-[ \A ]$(_ec)\n \$\[\e[22m\] '
      '';
    };
  };
}
