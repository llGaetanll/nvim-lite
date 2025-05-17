local util = require "highlights.util"

local fixes = { "cmp", "dressing", "misc", "telescope" }
local colors = util.gen_colors()
local groups = util.merge_groups(fixes, colors)

util.set_highlights(groups)
