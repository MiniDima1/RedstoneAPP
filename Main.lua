local component = require("component")
local event = require("event")
local GUI = require("GUI")
local system = require("System")

-- Создание нового рабочего пространства с окном
local workspace, window = system.addWindow(GUI.filledWindow(1, 1, 50, 20, 0x262626))

-- Добавление кнопки для переключения состояния Redstone
local toggleButton = window:addChild(GUI.button(15, 2, 20, 3, 0x3366CC, 0xFFFFFF, 0x3366CC, 0xFFFFFF, "Проверка..."))

-- Компонент Redstone
local redstone = component.redstone

-- Функция для обновления текста и цвета кнопки
local function updateButton()
  local state = redstone.getOutput(0) > 0 or redstone.getOutput(1) > 0 or redstone.getOutput(2) > 0 or redstone.getOutput(3) > 0 or redstone.getOutput(4) > 0 or redstone.getOutput(1) > 0 or redstone.getOutput(0) > 0
  if state then
    toggleButton.text = "Деактивировать"
    toggleButton.colors.default.background = 0xCC3333
    toggleButton.colors.default.text = 0xFFFFFF
  else
    toggleButton.text = "Активировать"
    toggleButton.colors.default.background = 0x3366CC
    toggleButton.colors.default.text = 0xFFFFFF
  end
  toggleButton:draw()
end

-- Обработчик события нажатия на кнопку
toggleButton.onTouch = function()
  local state = redstone.getOutput(0) > 0 or redstone.getOutput(1) > 0 or redstone.getOutput(2) > 0 or redstone.getOutput(3) > 0 or redstone.getOutput(4) > 0 or redstone.getOutput(1) > 0 or redstone.getOutput(0) > 0
  if state then
    for side = 0, 5 do
      if side ~= 5 then  -- Исключаем правую сторону
        redstone.setOutput(side, 0)
      end
    end
    GUI.alert("Выключено")
  else
    for side = 0, 5 do
      if side ~= 5 then  -- Исключаем правую сторону
        redstone.setOutput(side, 15)
      end
    end
    GUI.alert("Активировано")
  end
  updateButton()
end

-- Начальная инициализация текста кнопки
updateButton()

-- Отрисовка окна и запуск основного цикла событий
workspace:draw()
workspace:start()
