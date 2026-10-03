{
  inputs,
  self,
  ...
}:
{
  flake.modules.neovim.main =
    {
      config,
      wlib,
      lib,
      pkgs,
      options,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.neovim ];
      options.nvim-lib.neovimPlugins = lib.mkOption {
        readOnly = true;
        type = lib.types.attrsOf wlib.types.stringable;
        default = config.nvim-lib.pluginsFromPrefix "plugins-" inputs;
      };
      
      config.settings.config_directory = lib.generators.mkLuaInline "vim.uv.os_homedir() .. '/nvim'";

      options.settings.colorscheme = lib.mkOption {
        type = lib.types.str;
        default = "onedark_dark";
      };
      config.settings.colorscheme = "rose-pine";
      config.specs.colorscheme = {
        lazy = true;
        data = builtins.getAttr config.settings.colorscheme (
          with pkgs.vimPlugins;
          {
            "onedark_dark" = onedarkpro-nvim;
            "onedark_vivid" = onedarkpro-nvim;
            "onedark" = onedarkpro-nvim;
            "onelight" = onedarkpro-nvim;
            "moonfly" = vim-moonfly-colors;
            "rose-pine" = rose-pine;
          }
        );
      };

      config.specs.lze = [
        config.nvim-lib.neovimPlugins.lze
        {
          data = config.nvim-lib.neovimPlugins.lzextras;
          name = "lzextras";
        }
      ];

      config.specs.nix = {
        data = null;
        runtimePkgs = with pkgs; [
          nixd
          nixfmt
        ];
      };
     
      config.specs.lua = {
        after = [ "general" ];
        lazy = true;
        data = with pkgs.vimPlugins; [
          lazydev-nvim
        ];
        runtimePkgs = with pkgs; [
          lua-language-server
          stylua
        ];
      };

      config.specs.general = {
        after = [ "lze" ];
        runtimePkgs = with pkgs; [
          lazygit
          tree-sitter
        ];
        lazy = true;
        data = with pkgs.vimPlugins; [
          {
            data = vim-sleuth;
            lazy = false;
          }
          snacks-nvim
          nvim-lspconfig
          nvim-surround
          vim-startuptime
          blink-cmp
          blink-compat
          cmp-cmdline
          colorful-menu-nvim
          lualine-nvim
          gitsigns-nvim
          which-key-nvim
          fidget-nvim
          nvim-lint
          conform-nvim
          nvim-treesitter-textobjects
          nvim-treesitter.withAllGrammars
        ];
      };

      config.specMods =
        {
          # When this module is ran in an inner list,
          # this will contain `config` of the parent spec
          parentSpec ? null,
          # and this will contain `options`
          # otherwise they will be `null`
          parentOpts ? null,
          parentName ? null,
          # and then config from this one, as normal
          config,
          # and the other module arguments.
          ...
        }:
        {
          # you could use this to change defaults for the specs
          # config.collateGrammars = lib.mkDefault (parentSpec.collateGrammars or false);
          # config.autoconfig = lib.mkDefault (parentSpec.autoconfig or false);
          # config.runtimeDeps = lib.mkDefault (parentSpec.runtimeDeps or false);
          # config.pluginDeps = lib.mkDefault (parentSpec.pluginDeps or false);
          # or something more interesting like:
          # add a runtimePkgs field to the specs themselves
          options.runtimePkgs = options.runtimePkgs // {
            description = ''
              A runtimePkgs spec field to put packages on the PATH
              If the spec is disabled, this value will not be included in the resulting neovim derivation
            '';
          };
          # You could do this too
          # config.before = lib.mkDefault [ "INIT_MAIN" ];
        };
      config.runtimePkgs = config.specCollect (acc: v: acc ++ (v.runtimePkgs or [ ])) [ ];

      # Inform our lua of which top level specs are enabled
      options.settings.cats = lib.mkOption {
        readOnly = true;
        type = lib.types.attrsOf lib.types.bool;
        default = builtins.mapAttrs (_: v: v.enable) config.specs;
      };
      # build plugins from inputs set
      options.nvim-lib.pluginsFromPrefix = lib.mkOption {
        type = lib.types.raw;
        readOnly = true;
        default =
          prefix: inputs:
          lib.pipe inputs [
            builtins.attrNames
            (builtins.filter (s: lib.hasPrefix prefix s))
            (map (
              input:
              let
                name = lib.removePrefix prefix input;
              in
              {
                inherit name;
                value = config.nvim-lib.mkPlugin name inputs.${input};
              }
            ))
            builtins.listToAttrs
          ];
      };
    };

  perSystem =
    {
      pkgs,
      self',
      ...
    }:
    {
      packages.neovimFull = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;
        imports = [
          self.modules.neovim.main
        ];
      };
    };
}
