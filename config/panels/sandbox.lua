--------------------------------------------------------------------------------
-- BASICS
--------------------------------------------------------------------------------
local AddonName, b2h = ...
local data = CopyTable(B2H.data)
data.keyword = "sandbox"
--------------------------------------------------------------------------------
-- PANEL CREATION
--------------------------------------------------------------------------------
B2H.Sand = B2H.Sand or {}
function B2H:FillSandboxPanel(panel, container, anchorline)
  for i=1,100 do
    local opts = {
      name="test_cb_"..i,
      region = container,
      label = i,
      parent = anchorline,
      p_anchor = "BOTTOMLEFT",
      offsetY = 0,
      offsetX = 0,
      onClick = function() end
    }
    if i == 1 then
      opts.offsetY = -10
    elseif i > 1 and i <= b2h.columns then
      opts.p_anchor = "TOPLEFT"
      opts.parent = _G["test_cb_"..(i - 1)]
      opts.offsetX = b2h.columnWidth + 20
    else
      opts.parent = _G["test_cb_"..(i - b2h.columns)]
    end
    _G["test_cb_"..i] = READI:CheckBox(data, opts)
  end
end