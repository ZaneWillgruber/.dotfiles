-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
--
-- This dock is awkward in two ways:
--   * it shuffles DP-N connector names on every boot, and
--   * it exposes a phantom output cloning the FB4XR83 serial, which shows up as
--     a degraded (~30Hz) duplicate.
-- Static `monitor = DP-N,...` or `desc:` rules can't handle either reliably.
--
-- So: match on EDID serial, keep the highest-refresh real output per serial,
-- disable the rest (that kills the phantom), then place the survivors.
--
-- This logic used to live in fix-dock-monitors.sh, driven by hyprctl + socat.
-- Under a Lua config `hyprctl keyword` is refused outright ("keyword can't work
-- with non-legacy parsers"), so that script was a silent no-op. hl.get_monitors()
-- and hl.on("monitor.*") do the same job natively, without bash/jq/socat.

-- Physical arrangement (left -> right). Swap these two if the sides come out wrong.
local LEFT_SERIAL  = "4C4XR83"
local RIGHT_SERIAL = "FB4XR83" -- the one with the phantom twin

-- 4K externals; scale 1.25 => 3072x1728 logical each.
local EXT_MODE  = "3840x2160@60"
local EXT_SCALE = 1.25

-- Laptop panel, top-left. scale 2 => 1920x1200 logical.
local LAPTOP = {
    output   = "eDP-1",
    mode     = "3840x2400@59.99",
    position = "0x0",
    scale    = 2,
}

-- Logical widths at the scales above:
--   laptop = 3840/2    = 1920 -> x    0..1920
--   left   = 3840/1.25 = 3072 -> x 1920..4992
--   right  = 3840/1.25 = 3072 -> x 4992..8064
local SIDES = {
    { serial = LEFT_SERIAL,  position = "1920x0" },
    { serial = RIGHT_SERIAL, position = "4992x0" },
}

-- A sane default so the laptop is usable even before any layout pass runs.
hl.monitor(LAPTOP)

-- Every live output reporting `serial`, best first. The phantom gives itself away
-- by running degraded (~30Hz), so refresh rate is the discriminator; the name
-- comparison is only there to keep ties deterministic, since a phantom can report
-- the real mode while it is disabled and table.sort ties are otherwise arbitrary.
local function outputs_for(serial)
    local matches = {}
    for _, m in ipairs(hl.get_monitors() or {}) do
        if m.serial == serial then
            matches[#matches + 1] = m
        end
    end
    table.sort(matches, function(a, b)
        if a.refresh_rate ~= b.refresh_rate then
            return a.refresh_rate > b.refresh_rate
        end
        return a.name < b.name
    end)
    return matches
end

local applying = false

local function apply_layout()
    -- Disabling an output re-fires monitor.removed; don't recurse into ourselves.
    if applying then return end
    applying = true

    hl.monitor(LAPTOP)

    local placements = {}
    for _, side in ipairs(SIDES) do
        local matches = outputs_for(side.serial)
        -- Anything past the best match is the phantom (or a stale duplicate).
        for i = 2, #matches do
            hl.monitor({ output = matches[i].name, disabled = true })
        end
        if matches[1] then
            placements[#placements + 1] = { output = matches[1].name, position = side.position }
        end
    end

    -- Only commit the docked layout once both externals are actually present.
    -- Undocked or half-docked, the laptop default above is enough.
    if #placements == #SIDES then
        for _, p in ipairs(placements) do
            hl.monitor({
                output   = p.output,
                mode     = EXT_MODE,
                position = p.position,
                scale    = EXT_SCALE,
            })
        end
    end

    applying = false
end

-- Runs on config reload (monitors already exist); the events cover boot + hotplug.
apply_layout()
hl.on("hyprland.start", apply_layout)
hl.on("monitor.added", apply_layout)
hl.on("monitor.removed", apply_layout)

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

-- Exported so workspace rules can bind by panel identity instead of the DP-N
-- names, which this dock reshuffles every boot. Hyprland has no `serial:`
-- selector, but a monitor's EDID description ends with its serial, and `desc:`
-- matches on a prefix of that -- so this resolves to the right panel regardless
-- of which connector it landed on. The phantom shares the description, but
-- apply_layout has already disabled it by the time a workspace opens.
return {
    LEFT_SERIAL  = LEFT_SERIAL,
    RIGHT_SERIAL = RIGHT_SERIAL,

    ---@param serial string
    ---@return string
    desc_for = function(serial)
        return "desc:Dell Inc. DELL U2720Q " .. serial
    end,
}
