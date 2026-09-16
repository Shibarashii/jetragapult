-- Input configuration

hl.config({
    input = {
      touchpad = {
        natural_scroll = true
      },
        -- sensitivity = -0.25,
        accel_profile = "flat",
        kb_options = "caps:swapescape",
        scroll_factor = 1.5,
        sensitivity = 0.8,
        repeat_rate = 60,
        repeat_delay = 400
    },
    -- Uncomment the section below to enable software cursors; this can help with cursor display or behavior issues
    -- cursor = {
    --     no_hardware_cursors = 1,
    -- },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
-- hl.gesture({ fingers = 3, direction = "down",       action = "close" })
-- hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })
-- hl.gesture({ fingers = 3, direction = "left",       action = "float" })
