nixInfo.lze.register_handlers({
  {
    spec_field = "auto_enable",
    set_lazy = false,

    modify = function(plugin)
      if vim.g.nix_info_plugin_name then
        if type(plugin.auto_enable) == "table" then
          for _, name in pairs(plugin.auto_enable) do
            if not nixInfo.get_nix_plugin_path(name) then
              plugin.enabled = false
              break
            end
          end
        elseif type(plugin.auto_enable) == "string" then
          if not nixInfo.get_nix_plugin_path(plugin.auto_enable) then
            plugin.enabled = false
          end
        elseif type(plugin.auto_enable) == "boolean" and plugin.auto_enable then
          if not nixInfo.get_nix_plugin_path(plugin.name) then
            plugin.enabled = false
          end
        end
      end

      return plugin
    end,
  },

  {
    spec_field = "for_cat",
    set_lazy = false,

    modify = function(plugin)
      if vim.g.nix_info_plugin_name then
        if type(plugin.for_cat) == "string" then
          plugin.enabled = nixInfo(false, "settings", "cats", plugin.for_cat)
        end
      end

      return plugin
    end,
  },

  nixInfo.lze.lsp,
})

nixInfo.lze.h.lsp.set_ft_fallback(function(name)
  local lspconfig = nixInfo.get_nix_plugin_path("nvim-lspconfig")

  if lspconfig then
    local ok, config = pcall(
      dofile,
      lspconfig .. "/lsp/" .. name .. ".lua"
    )

    return (ok and config or {}).filetypes or {}
  end

  return (vim.lsp.config[name] or {}).filetypes or {}
end)

