-- Ghous_Yuki Aot:R Hub (Xeno Optimized)

if not game:IsLoaded() then game.Loaded:Wait() end

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Ghous_Yuki Hub",
        Text = "Loading Aot:R Script...",
        Duration = 5
    })
end)

local url = "https://raw.githubusercontent.com/zerunquist/TekkitAotr/refs/heads/main/main"
local success, scriptCode = pcall(game.HttpGet, game, url)

if success then
    loadstring(scriptCode)()
else
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Ghous_Yuki Hub",
            Text = "Failed to load script!",
            Duration = 5
        })
    end)
end
