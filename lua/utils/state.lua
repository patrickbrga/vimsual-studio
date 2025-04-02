local S = {}

S.IsDebbuging = false
function S.ToggleDebbuging()
    S.IsDebbuging = not S.IsDebbuging
end

return S
