-- pywal colors.
--
-- pywal regenerates ~/.cache/wal/colors-hyprland.conf in hyprlang format every
-- time the wallpaper changes, so it can't become a lua module -- we parse the
-- "$name = value" pairs out of it instead. Values are left as strings
-- (rgba(r,g,b,a)), which hl.config accepts as-is.

local M = {}

local values = {}

local path = (os.getenv("HOME") or "~") .. "/.cache/wal/colors-hyprland.conf"
local file = io.open(path, "r")
if file then
    for line in file:lines() do
        local key, value = line:match("^%s*%$(%S+)%s*=%s*(.-)%s*$")
        if key and value ~= "" then
            values[key] = value
        end
    end
    file:close()
end

-- Falls back when pywal hasn't run yet -- the old `source =` hard-failed there.
function M.get(name, fallback)
    return values[name] or fallback
end

return M
