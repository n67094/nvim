local Module = {}

function Module.setup()
	local status_1, cmp = pcall(require, "cmp")
	if (not status_1) then 
		print("The plugin nvim-cmp is not installed")
		return 
	end
	
	local status_2, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if (not status_2) then 
		print("The plugin cmp_nvim_lsp is not installed")
		return 
	end
	
	local status_3, lspconfig = pcall(require, "lspconfig")
	if (not status_3) then 
		print("The plugin lspconfig is not installed")
		return 
	end
	
	local status_4, luasnip = pcall(require, "luasnip")
	if (not status_4) then 
		print("The plugin luasnip is not installed")
		return 
	end
	
	-- Add additional capabilities supported by nvim-cmp
	cmp_nvim_lsp.default_capabilities()

	-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
	local servers = { "clangd", "tsserver", "pyright", "rust_analyzer", "lua_ls" }
	for _, lsp in ipairs(servers) do
  		lspconfig[lsp].setup {
    		-- on_attach = my_custom_on_attach,
    		capabilities = cmp_nvim_lsp,
  	}
	end
	
	-- nvim-cmp setup
	cmp.setup {
		snippet = {
    			expand = function(args)
      				luasnip.lsp_expand(args.body)
    			end,
  		},
  		mapping = cmp.mapping.preset.insert({
    			['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    			['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    			-- C-b (back) C-f (forward) for snippet placeholder navigation.
    			['<C-Space>'] = cmp.mapping.complete(),
    			['<CR>'] = cmp.mapping.confirm {
      				behavior = cmp.ConfirmBehavior.Replace,
      				select = true,
    			},
    			['<Tab>'] = cmp.mapping(function(fallback)
      				if cmp.visible() then
        				cmp.select_next_item()
        			elseif luasnip.expand_or_jumpable() then
        				luasnip.expand_or_jump()
      				else
        				fallback()
      				end
    			end, { 'i', 's' }),
    			['<S-Tab>'] = cmp.mapping(function(fallback)
      				if cmp.visible() then
        				cmp.select_prev_item()
        			elseif luasnip.jumpable(-1) then
        				luasnip.jump(-1)
      				else
        				fallback()
      				end
    			end, { 'i', 's' }),
  		}),
  		sources = {
    			{ name = 'nvim_lsp' },
    			{ name = 'luasnip' },
  		},
	}
end

return Module
