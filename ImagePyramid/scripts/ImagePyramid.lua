
--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

local DELAY = 1000 -- ms between visualization steps

-- Creating viewer
local viewer = View.create()

-- Settin up graphical overlay attributes
-- Level:
local textDec1 = View.TextDecoration.create():setSize(35):setPosition(20, 40)
--Image size:
local textDec2 = View.TextDecoration.create():setSize(25):setPosition(20, 105)

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  local img = Image.load('resources/ImagePyramid.bmp')

  local downsamplingLevels = 5
  local imgPyramid = Image.Pyramid.create(img, downsamplingLevels)

  for i = 0, downsamplingLevels - 1 do
    local downsampledImage = imgPyramid:getImage(i)
    local width, height = downsampledImage:getSize()

    -- Displaying pyramid level with scaled text (to fit image size)
    viewer:clear()
    viewer:addImage(downsampledImage)
    viewer:addText('Level: ' .. i, textDec1)
    viewer:addText(width .. 'x' .. height, textDec2)
    viewer:present()
    print('Pyramid level ' .. i .. ', width: ' .. width .. ', height: ' .. height)
    Script.sleep(DELAY)
  end

  print('App finished.')
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--End of Function and Event Scope--------------------------------------------------
