-- autotag.lua
return {
	-- autoclose tags
	"windwp/nvim-ts-autotag",
	event = "InsertEnter",
	ft = {
		"html",
		"xml",
		"javascriptreact",
		"typescriptreact",
		"svelte",
		"vue",
		"astro",
		"php",
		"markdown",
	},
	config = true,
}
