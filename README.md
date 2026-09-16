# Fluent UI — Documentação Completa

Biblioteca de interface gráfica para scripts Roblox.

---

## Índice

1. [Inicialização](#1-inicialização)
2. [Criando a Janela](#2-criando-a-janela)
3. [Temas Disponíveis](#3-temas-disponíveis)
4. [Abas e Sub-abas](#4-abas-e-sub-abas)
5. [Seções](#5-seções)
6. [Elementos](#6-elementos)
7. [Notificações](#7-notificações)
8. [Minimizador](#8-minimizador)
9. [SaveManager](#9-savemanager)
10. [Métodos da Library](#10-métodos-da-library)
11. [Exemplo Completo](#11-exemplo-completo)

---

## 1. Inicialização

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ServerSad/LibraryFluent/refs/heads/main/Library.lua"))()
```

---

## 2. Criando a Janela

```lua
local Window = Library:CreateWindow({
    Title                  = "Meu Script",
    SubTitle               = "v1.0",
    Theme                  = "Dark",
    Acrylic                = false,
    TabWidth               = 150,
    Size                   = UDim2.fromOffset(600, 480),
    MinimizeKey            = Enum.KeyCode.LeftControl,
    BackgroundImage        = "",
    BackgroundTransparency = 0.5,
    Icon                   = "",
    Image                  = "",
    Search                 = true,
    DropdownsOutsideWindow = false,
    UserInfo               = true,
    UserInfoTitle          = "Player Name",
    UserInfoSubtitle       = "VIP",
    UserInfoSubtitleColor  = Color3.fromRGB(255, 200, 0),
    UserInfoTop            = false,
})
```

---

## 3. Temas Disponíveis

| Nome        | Descrição             |
|-------------|-----------------------|
| `Dark`      | Cinza escuro clássico |
| `Darker`    | Ainda mais escuro     |
| `AMOLED`    | Preto puro            |
| `Light`     | Fundo branco          |
| `Balloon`   | Tons de azul claro    |
| `SoftCream` | Tons creme/bege       |
| `Aqua`      | Verde-azulado         |
| `Amethyst`  | Roxo                  |
| `Rose`      | Rosa/vermelho         |
| `Midnight`  | Azul meia-noite       |
| `Forest`    | Verde floresta        |
| `Sunset`    | Laranja/pôr do sol    |
| `Ocean`     | Azul oceano           |
| `Emerald`   | Verde esmeralda       |
| `Sapphire`  | Azul safira           |
| `Cloud`     | Azul petróleo         |
| `Grape`     | Preto com roxo        |
| `Bloody`    | Vermelho sangue       |
| `Arctic`    | Azul gelo             |

```lua
Library:SetTheme("Midnight")
```

---

## 4. Abas e Sub-abas

```lua
local MinhaAba = Window:AddTab({
    Title = "Combat",
    Icon  = "",
})

-- Navegar para uma aba pelo nome ou índice
Window:SetTab("Combat")
Window:SetTab(1)

-- Sub-abas dentro de uma aba
local SubA = MinhaAba:AddSubTab("ESP")
local SubB = MinhaAba:AddSubTab("Chams")

local Secao = SubA:AddSection("Configurações de ESP")
```

---

## 5. Seções

```lua
local MinhaSecao = MinhaAba:AddSection("Título da Seção")
local SecaoComIcone = MinhaAba:AddSection("Players", "rbxassetid://...")
```

---

## 6. Elementos

### Toggle

```lua
local MeuToggle = MinhaSecao:AddToggle({
    Title       = "Aimbot",
    Description = "Descrição opcional",
    Default     = false,
    Callback    = function(Value)
        print("Toggle:", Value)
    end,
})

MeuToggle:OnChanged(function(Value)
    print("Mudou para:", Value)
end)

MeuToggle:SetValue(true)
```

---

### Slider

```lua
local MeuSlider = MinhaSecao:AddSlider({
    Title       = "Walk Speed",
    Description = "Velocidade do personagem",
    Min         = 16,
    Max         = 500,
    Default     = 16,
    Rounding    = 0,
    Callback    = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

MeuSlider:OnChanged(function(Value) end)
MeuSlider:SetValue(100)
```

---

### Button

```lua
MinhaSecao:AddButton({
    Title       = "Teleportar",
    Description = "Vai ao spawn",
    Callback    = function()
        Library:Notify({ Title = "OK", Content = "Teleportado!", Duration = 3 })
    end,
})
```

---

### Dropdown

```lua
local MeuDrop = MinhaSecao:AddDropdown({
    Title       = "Target Part",
    Description = "Parte para mirar",
    Values      = { "Head", "Torso", "HumanoidRootPart" },
    Default     = "Head",
    Multi       = false,
    Search      = true,
    AllowNull   = false,
    Callback    = function(Value)
        print("Selecionado:", Value)
    end,
})

-- Multi-seleção
local MultiDrop = MinhaSecao:AddDropdown({
    Title    = "Partes",
    Values   = { "Head", "Torso", "LeftArm", "RightArm" },
    Default  = { "Head", "Torso" },
    Multi    = true,
    Callback = function(Value)
        for parte, ativo in pairs(Value) do
            print(parte, ativo)
        end
    end,
})

MeuDrop:OnChanged(function(Value) end)
MeuDrop:SetValue("Torso")
MeuDrop:SetValues({ "Head", "Torso", "LeftLeg" })
```

---

### Keybind

```lua
local MeuBind = MinhaSecao:AddKeybind({
    Title           = "Aimbot Key",
    Description     = "Tecla para ativar",
    Default         = "Q",
    Mode            = "Toggle",
    Callback        = function(Value) end,
    ChangedCallback = function(NewKey)
        print("Nova tecla:", NewKey)
    end,
})

MeuBind:OnChanged(function(Key) end)
MeuBind:SetValue("E", "Hold")
MeuBind:GetState()
```

**Modos disponíveis:**

| Modo       | Comportamento                                     |
|------------|---------------------------------------------------|
| `"Toggle"` | Alterna entre ativo/inativo a cada pressionamento |
| `"Hold"`   | Ativo apenas enquanto a tecla está pressionada    |
| `"Always"` | Sempre ativo, ignora a tecla                      |

---

### Colorpicker

```lua
local MeuColor = MinhaSecao:AddColorpicker({
    Title        = "Cor do ESP",
    Description  = "Escolha a cor",
    Default      = Color3.fromRGB(255, 0, 0),
    Transparency = false,
    Callback     = function(Color)
        print("Cor:", Color)
    end,
})

MeuColor:OnChanged(function(Color) end)
MeuColor:SetValue({ 0, 1, 1 }, 0)
MeuColor:SetValueRGB(Color3.fromRGB(0, 255, 100), 0.5)
```

---

### Input

```lua
local MeuInput = MinhaSecao:AddInput({
    Title       = "Player Name",
    Description = "Nome do alvo",
    Default     = "",
    Placeholder = "Digite aqui...",
    Numeric     = false,
    Finished    = false,
    MaxLength   = 50,
    Callback    = function(Value)
        print("Texto:", Value)
    end,
})

MeuInput:OnChanged(function(Value) end)
MeuInput:SetValue("NomeDoJogador")
```

---

### Paragraph

```lua
MinhaSecao:AddParagraph({
    Title   = "Informações",
    Content = "Versão 1.0 | Discord: meuhub.gg\nSuporte a múltiplas linhas.",
})

-- Suporta MiniMessage para texto colorido
MinhaSecao:AddParagraph({
    Title   = "Colorido",
    Content = "<red>Vermelho</red> | <green>Verde</green> | <gradient:#FF0000:#0000FF>Gradiente</gradient>",
})
```

---

## 7. Notificações

```lua
Library:Notify({
    Title      = "Título",
    Content    = "Mensagem principal",
    SubContent = "Detalhe adicional",
    Duration   = 5,
})

-- Fechar manualmente
local Notif = Library:Notify({ Title = "...", Content = "..." })
Notif:Close()
```

---

## 8. Minimizador

```lua
Library:CreateMinimizer({
    Draggable    = true,
    Icon         = "rbxassetid://...",
    Size         = UDim2.fromOffset(36, 36),
    Position     = UDim2.new(0, 300, 0, 20),
    Acrylic      = false,
    Transparency = 0,
    Corner       = 14,
    Visible      = true,
})
```

---

## 9. SaveManager

```lua
-- Salvar configurações
local ok, err = Library.SaveManager:Save()
if not ok then print("Erro ao salvar:", err) end

-- Carregar configurações
local ok, err = Library.SaveManager:Load()

-- Ativar auto-save ao criar a aba de configurações
local SettingsTab = Window:AddTab({
    Title       = "Settings",
    SaveManager = true,
})

-- Alterar pasta de save
Library.SaveManager.Folder = "MeuScript"
```

O arquivo é salvo em `FluentSettings/<Título da Janela>.json`.

---

## 10. Métodos da Library

```lua
Library:SetTheme("Arctic")          -- Muda o tema
Library:Destroy()                   -- Remove a interface
Library:ToggleBlur(true)            -- Ativa/desativa o blur acrílico do painel
Library:ToggleTransparency(true)    -- Alterna transparência do fundo
Library:SetWindowTransparency(1.5)  -- Define transparência (0–3)

-- Verificar se a lib foi destruída
if Library.Unloaded then return end
```

---

## 11. Exemplo Completo

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lucasggk/Library/refs/heads/main/Library.lua"))()

local Window = Library:CreateWindow({
    Title    = "My Hub",
    SubTitle = "v1.0",
    Theme    = "Midnight",
    Size     = UDim2.fromOffset(620, 500),
    TabWidth = 160,
})

Library:CreateMinimizer({ Draggable = true })

local CombatTab   = Window:AddTab({ Title = "Combat" })
local VisualTab   = Window:AddTab({ Title = "Visual" })
local SettingsTab = Window:AddTab({ Title = "Settings", SaveManager = true })

local ESPSub   = VisualTab:AddSubTab("ESP")
local ChamsSub = VisualTab:AddSubTab("Chams")

local AimSection = CombatTab:AddSection("Aimbot")

AimSection:AddToggle({
    Title    = "Aimbot",
    Default  = false,
    Callback = function(v) end,
})

AimSection:AddSlider({
    Title    = "FOV",
    Min      = 10,
    Max      = 500,
    Default  = 150,
    Rounding = 0,
    Callback = function(v) end,
})

AimSection:AddDropdown({
    Title    = "Target Part",
    Values   = { "Head", "Torso", "HumanoidRootPart" },
    Default  = "Head",
    Callback = function(v) end,
})

AimSection:AddKeybind({
    Title    = "Hold Key",
    Default  = "Q",
    Mode     = "Hold",
    Callback = function(v) end,
})

local ESPSec = ESPSub:AddSection("ESP")

ESPSec:AddToggle({
    Title    = "ESP",
    Default  = false,
    Callback = function(v) end,
})

ESPSec:AddColorpicker({
    Title    = "Box Color",
    Default  = Color3.fromRGB(255, 65, 65),
    Callback = function(v) end,
})

ESPSec:AddDropdown({
    Title    = "Mode",
    Values   = { "Box", "Skeleton", "Dot" },
    Default  = "Box",
    Callback = function(v) end,
})

local SettSec = SettingsTab:AddSection("Appearance")

SettSec:AddDropdown({
    Title    = "Theme",
    Values   = Library.Themes,
    Default  = "Midnight",
    Callback = function(v) Library:SetTheme(v) end,
})

SettSec:AddToggle({
    Title    = "Game Blur",
    Default  = true,
    Callback = function(v) Library:AcrylicBlur(v) end,
})

SettSec:AddButton({
    Title    = "Save Config",
    Callback = function()
        local ok = Library.SaveManager:Save()
        Library:Notify({
            Title    = "SaveManager",
            Content  = ok and "Config salva!" or "Erro ao salvar.",
            Duration = 3,
        })
    end,
})

SettSec:AddParagraph({
    Title   = "Informações",
    Content = "My Hub v1.0\nDiscord: discord.gg/myhub",
})

Library:Notify({
    Title    = "My Hub",
    Content  = "Carregado com sucesso!",
    Duration = 4,
})
```

---

## Notas Finais

- **MiniMessage** é suportado em todos os textos: `<red>texto</red>`, `<gradient:#FF0000:#00FF00>gradiente</gradient>`, `<b>negrito</b>`, `<i>itálico</i>`, `<u>sublinhado</u>`.
- O `SaveManager` só funciona fora do Roblox Studio.
- `Acrylic = true` adiciona efeito de profundidade, mas pode impactar performance.
