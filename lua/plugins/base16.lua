return {
    {
        "llGaetanll/base16.nvim",
        priority = 1000,
        opts = {
            default_theme = "everforest",
            on_change = require "highlights"
        },
    },
}
