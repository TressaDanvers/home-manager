theme: { config, pkgs, ... }: {
  home = {
    packages = with pkgs; [ tmux tree ];
    sessionVariables = { EDITOR = "nano"; };
  };

  programs = {
    bash = {
      enable = true;
      historyFile = "$XDG_STATE_HOME/bash/shell-history";
      shellAliases = {
        ls = "ls --color";
        ff = "clear; fastfetch";
        hms = "home-manager switch --flake $XDG_CONFIG_HOME/home-manager/"; 
        hmsr = "home-manager switch --flake $XDG_CONFIG_HOME/home-manager/; exec bash"; 
      };
      initExtra = ''
        PS1='\[\e[1m\][ \[\e[${theme.color.user-name}m\]\u\[\e[39m\]@\[\e[${theme.color.host-name}m\]\h\[\e[39m\] ]-[ \[\e[34m\]\W\[\e[39m\] ]\n\$\[\e[0m\] '
      '';
      profileExtra = ''
        clear; fastfetch
      '';
    };

    git.enable = true;

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    dircolors = {
      enable = true;
      enableBashIntegration = true;
    };

    fastfetch = {
      enable = true;
      settings = {
        modules = [
          { type = "title"; format = "{#1}[ {#${theme.color.user-name}}{user-name}{#39}@{#${theme.color.host-name}}{host-name}{#39} ]{#0}"; }
          "separator"

          "break"
          { type = "os";     key = "{#1}{#39}[ os     ]"; format = "{#1}[ {#${theme.color.os}}{name}{#39} ]{#0}"; }
          { type = "host";   key = "{#1}{#39}[ host   ]"; format = "{#1}[ {2}-{3} ]{#0}"; }
          { type = "kernel"; key = "{#1}{#39}[ kernel ]"; format = "{#1}[ {1}-{2} ]{#0}"; }
          { type = "uptime"; key = "{#1}{#39}[ uptime ]"; format = "{#1}[ {?days}{days}-{?}{?hours}{hours}:{?}{?minutes}{minutes}:{?}{seconds} ]{#0}"; }
          { type = "shell";  key = "{#1}{#39}[ shell  ]"; format = "{#1}[ {1} ]{#0}"; }
          "break"

          "break"
          { type = "cpu";    key = "{#1}{#39}[ cpu  ]"; format = "{#1}[ {1} ]{#0}"; }
          { type = "gpu";    key = "{#1}{#39}[ gpu  ]"; format = "{#1}[ {1}{?2}-{2}{?} ]{#0}"; }
          { type = "memory"; key = "{#1}{#39}[ ram  ]"; format = "{#1}[ {#0}{1} used{#1} | {#0}{2}{#1} ]{#0}"; }
          { type = "swap";   key = "{#1}{#39}[ swap ]"; format = "{#1}[ {#0}{1} used{#1} | {#0}{2}{#1} ]{#0}"; }
          { type = "disk";   key = "{#1}{#39}[ root ]"; format = "{#1}[ {#0}{1} used{#1} | {#0}{2}{#1} ]{#0}"; }
          "break"

          "separator"
        ];
      };
    };
  };

  xdg.enable = true;

  nixpkgs.config.allowUnfree = true;
}
