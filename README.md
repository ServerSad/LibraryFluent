# FluentPro — Documentação Completa

Biblioteca de interface gráfica para scripts Roblox, com topbar profissional.

---

## Índice

1. [Inicialização](#1-inicialização)
2. [Criando a Janela](#2-criando-a-janela)
3. [Topbar](#3-topbar)
4. [Temas Disponíveis](#4-temas-disponíveis)
5. [Abas e Sub-abas](#5-abas-e-sub-abas)
6. [Seções](#6-seções)
7. [Elementos](#7-elementos)
8. [Notificações](#8-notificações)
9. [SaveManager](#9-savemanager)
10. [Métodos da Janela](#10-métodos-da-janela)
11. [Métodos da Library](#11-métodos-da-library)
12. [Exemplo Completo](#12-exemplo-completo)

---

## 1. Inicialização

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU_USUARIO/SEU_REPO/main/FluentPro.lua"))()
```

---

## 2. Criando a Janela

```lua
local Window = Library:CreateWindow({
    Title                  = "Meu Script",
    SubTitle               = "v1.0",
    Icon                   = "rbxassetid://84198100024860",
    IconCorner             = "circle",
    Theme                  = "Dark",
    Acrylic                = false,
    TabWidth               = 150,
    Size                   = UDim2.fromOffset(600, 480),
    MinimizeKey            = Enum.KeyCode.LeftControl,
    BackgroundImage        = "",
    BackgroundTransparency = 0.5,
    Image                  = "",
    Search                 = true,
    DropdownsOutsideWindow = false,
    SaveFile               = "MeuScript",
    UserInfo               = true,
    UserInfoTitle          = "Player Name",
    UserInfoSubtitle       = "VIP",
    UserInfoSubtitleColor  = Color3.fromRGB(255, 200, 0),
    UserInfoTop            = false,
})
```

| Campo | Padrão | Descrição |
|-------|--------|-----------|
| `Title` | **obrigatório** | Nome do hub na topbar |
| `SubTitle` | — | Texto ao lado do nome, separado por um divisor |
| `Icon` | — | Foto da topbar (ver [Topbar](#3-topbar)) |
| `IconCorner` | `"circle"` | Formato da foto: `"circle"`, `"rounded"` ou `"square"` |
| `Size` | `580 x 460` | Tamanho inicial da janela |
| `MinimizeKey` | `LeftControl` | Tecla que esconde / mostra a janela inteira |
| `Image` | — | Imagem grande no topo da coluna de abas |
| `Search` | `true` | Caixa de busca acima das abas |
| `SaveFile` | `Title` | Nome do arquivo de config |
| `UserInfoTop` | `false` | Coloca o bloco do jogador em cima das abas em vez de embaixo |

---

## 3. Topbar

A topbar é uma barra arredondada dentro da janela com a **foto**, o **nome do hub**, o
**subtítulo** e os botões **minimizar**, **maximizar** e **fechar**.

- **Minimizar** enrola a janela dentro da própria topbar. Clica de novo e ela volta.
  Por isso **não existe mais botão flutuante** — não use `CreateMinimizer`.
- **Maximizar** ocupa a tela inteira e tira o arredondamento das bordas. Clica de novo para restaurar.
- **Fechar** pede confirmação e descarrega a interface.
- **Arrastar** a janela é pela topbar.
- **Duplo clique** na topbar maximiza / restaura.

### Formatos aceitos no `Icon`

```lua
Icon = "rbxassetid://84198100024860"   -- asset do Roblox
Icon = 84198100024860                  -- só o id (número ou string)
Icon = "avatar"                        -- foto do próprio jogador
Icon = "https://site.com/logo.png"     -- baixa e usa (precisa de writefile + getcustomasset)
```

A foto por link é baixada uma vez e fica em cache no workspace do executor. O download roda em
segundo plano, então a janela abre na hora e a foto aparece quando chega.

### Mudando em tempo real

```lua
Window:SetTitle("Novo Nome")
Window:SetSubTitle("v2.0")          -- "" esconde o subtítulo
Window:SetIcon("avatar")
```

`SetTitle` muda só o texto da barra — o arquivo de config continua o mesmo.

---

## 4. Temas Disponíveis

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

A lista completa fica em `Library.Themes`.

---

## 5. Abas e Sub-abas

```lua
local MinhaAba = Window:AddTab({
    Title = "Combat",
    Icon  = "rbxassetid://10723407389",
})

-- Navegar para uma aba pelo nome ou índice
Window:SetTab("Combat")
Window:SetTab(1)

-- Sub-abas dentro de uma aba
local SubA = MinhaAba:AddSubTab("ESP")
local SubB = MinhaAba:AddSubTab("Chams", "rbxassetid://...")

local Secao = SubA:AddSection("Configurações de ESP")
```

---

## 6. Seções

```lua
local MinhaSecao = MinhaAba:AddSection("Título da Seção")
local SecaoComIcone = MinhaAba:AddSection("Players", "rbxassetid://...")
```

---

## 7. Elementos

Todo elemento aceita duas formas. O **id** é a chave usada no save:

```lua
MinhaSecao:AddToggle("AutoFarm", { Title = "Auto Farm" })  -- id explícito
MinhaSecao:AddToggle({ Title = "Auto Farm" })              -- id = Config.Id ou o Title
```

Depois de criado, o elemento fica em `Library.Options`.

### Toggle

```lua
local MeuToggle = MinhaSecao:AddToggle("Aimbot", {
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
local MeuSlider = MinhaSecao:AddSlider("WalkSpeed", {
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
        Library:Notify({ Title = "OK", Content = "Teleportado", Duration = 3 })
    end,
})
```

---

### Dropdown

```lua
local MeuDrop = MinhaSecao:AddDropdown("TargetPart", {
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

-- Multi-seleção: o Default é um MAPA, não uma lista
local MultiDrop = MinhaSecao:AddDropdown("Partes", {
    Title    = "Partes",
    Values   = { "Head", "Torso", "LeftArm", "RightArm" },
    Default  = { Head = true, Torso = true },
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

> **Cuidado:** o dropdown escreve dentro das tabelas que recebe em `Values` e `Default`.
> Sempre passe uma tabela nova — nunca uma tabela que o seu script usa em outro lugar,
> e nunca a mesma tabela nos dois campos.

---

### Keybind

```lua
local MeuBind = MinhaSecao:AddKeybind("AimKey", {
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
local MeuColor = MinhaSecao:AddColorpicker("EspColor", {
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
local MeuInput = MinhaSecao:AddInput("PlayerName", {
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

`Finished = true` só chama o Callback quando a pessoa aperta Enter.

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

## 8. Notificações

```lua
Library:Notify({
    Title      = "Título",
    Content    = "Mensagem principal",
    SubContent = "Detalhe adicional",
    Duration   = 5,
})

-- Sem Duration a notificação fica até ser fechada
local Notif = Library:Notify({ Title = "...", Content = "..." })
Notif:Close()
```

---

## 9. SaveManager

O save é **automático**: todo elemento com Callback salva sozinho ~0,35 s depois de mudar, e a
config é carregada sozinha logo depois do `CreateWindow`. Não precisa fazer nada.

```lua
-- Salvar / carregar / apagar manualmente
local ok, err = Window:Save()
local ok, err = Window:Load()
Window:ClearSave()

-- Alterar pasta de save
Library.SaveManager.Folder = "MeuScript"
```

O arquivo é salvo em `FluentSettings/<SaveFile ou Title>.json`.
Use `SaveFile` no `CreateWindow` para o nome do arquivo não mudar se você trocar o título do hub.

---

## 10. Métodos da Janela

```lua
Window.ToggleCollapse()           -- enrola / desenrola na topbar (o botão de minimizar)
Window:SetCollapsed(true)         -- força enrolado
Window.Collapsed                  -- true se está enrolada

Window.Maximize(true)             -- maximiza (false restaura)
Window.Maximized                  -- true se está maximizada

Window:Minimize()                 -- esconde / mostra a janela inteira (é o que a MinimizeKey faz)

Window:SetTitle("Nome")
Window:SetSubTitle("Sub")
Window:SetIcon("avatar")

Window:ToggleSearch()             -- mostra / esconde a busca
Window:SetBackgroundImage("rbxassetid://...", 0.5)
Window:AcrylicBlur(true)          -- mesmo que Library:SetAcrylic

Window:Dialog({
    Title   = "Confirmar",
    Content = "Tem certeza?",
    Buttons = {
        { Title = "Sim", Callback = function() end },
        { Title = "Não" },
    },
})
```

---

## 11. Métodos da Library

```lua
Library:SetTheme("Arctic")        -- Muda o tema
Library:SetAcrylic(true)          -- Liga / desliga o desfoque acrílico
Library:SetTransparency(true)     -- Liga / desliga a transparência do fundo
Library:Destroy()                 -- Remove a interface

-- Verificar se a lib foi destruída
if Library.Unloaded then return end
```

---

## 12. Exemplo Completo

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU_USUARIO/SEU_REPO/main/FluentPro.lua"))()

local Window = Library:CreateWindow({
    Title      = "My Hub",
    SubTitle   = "v1.0",
    Icon       = "rbxassetid://84198100024860",
    IconCorner = "circle",
    Theme      = "Midnight",
    Size       = UDim2.fromOffset(620, 500),
    TabWidth   = 160,
    SaveFile   = "MyHub",
})

local CombatTab   = Window:AddTab({ Title = "Combat" })
local VisualTab   = Window:AddTab({ Title = "Visual" })
local SettingsTab = Window:AddTab({ Title = "Settings" })

local ESPSub   = VisualTab:AddSubTab("ESP")
local ChamsSub = VisualTab:AddSubTab("Chams")

local AimSection = CombatTab:AddSection("Aimbot")

AimSection:AddToggle("Aimbot", {
    Title    = "Aimbot",
    Default  = false,
    Callback = function(v) end,
})

AimSection:AddSlider("FOV", {
    Title    = "FOV",
    Min      = 10,
    Max      = 500,
    Default  = 150,
    Rounding = 0,
    Callback = function(v) end,
})

AimSection:AddDropdown("TargetPart", {
    Title    = "Target Part",
    Values   = { "Head", "Torso", "HumanoidRootPart" },
    Default  = "Head",
    Callback = function(v) end,
})

AimSection:AddKeybind("HoldKey", {
    Title    = "Hold Key",
    Default  = "Q",
    Mode     = "Hold",
    Callback = function(v) end,
})

local ESPSec = ESPSub:AddSection("ESP")

ESPSec:AddToggle("ESP", {
    Title    = "ESP",
    Default  = false,
    Callback = function(v) end,
})

ESPSec:AddColorpicker("BoxColor", {
    Title    = "Box Color",
    Default  = Color3.fromRGB(255, 65, 65),
    Callback = function(v) end,
})

ESPSec:AddDropdown("EspMode", {
    Title    = "Mode",
    Values   = { "Box", "Skeleton", "Dot" },
    Default  = "Box",
    Callback = function(v) end,
})

local Look = SettingsTab:AddSection("Aparência")

Look:AddDropdown("Theme", {
    Title    = "Theme",
    Values   = Library.Themes,
    Default  = "Midnight",
    Callback = function(v) Library:SetTheme(v) end,
})

Look:AddToggle("Blur", {
    Title    = "Game Blur",
    Default  = false,
    Callback = function(v) Library:SetAcrylic(v) end,
})

local Brand = SettingsTab:AddSection("Topbar")

Brand:AddInput("HubPhoto", {
    Title       = "Foto do hub",
    Description = "id do asset, link .png ou avatar",
    Default     = "rbxassetid://84198100024860",
    Finished    = true,
    Callback    = function(v) Window:SetIcon(v) end,
})

Brand:AddButton({
    Title    = "Usar minha foto do Roblox",
    Callback = function() Window:SetIcon("avatar") end,
})

SettingsTab:AddSection("Info"):AddParagraph({
    Title   = "Informações",
    Content = "My Hub v1.0\nDiscord: discord.gg/myhub",
})

Library:Notify({
    Title    = "My Hub",
    Content  = "Carregado",
    Duration = 4,
})
```

---

## Notas Finais

- **MiniMessage** é suportado em todos os textos: `<red>texto</red>`, `<gradient:#FF0000:#00FF00>gradiente</gradient>`, `<b>negrito</b>`, `<i>itálico</i>`, `<u>sublinhado</u>`.
- O `SaveManager` só funciona fora do Roblox Studio.
- `Acrylic = true` adiciona efeito de profundidade, mas pode impactar performance.
- No celular a topbar e os botões ficam maiores sozinhos, para caber o dedo.
- A altura da topbar é a constante `TITLEBAR_HEIGHT` no topo do `FluentPro.lua`; o layout inteiro se ajusta se você mudar.
