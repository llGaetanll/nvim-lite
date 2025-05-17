return {
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {
            input = {
                title_pos = "center",
                win_options = {
                    -- create new highlight groups that we can use to style dressing
                    -- without bleeding over to other plugins
                    winhighlight =
                    "FloatBorder:DressingFloatBorder,FloatTitle:DressingFloatTitle,Normal:DressingInputText",
                },
            },
        },
    },
}
