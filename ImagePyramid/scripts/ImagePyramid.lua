--[[----------------------------------------------------------------------------

  Application Name:
  ImagePyramid

  Summary:
  Downsampling images using Pyramid data type.

  How to Run:
  Starting this sample is possible either by running the app (F5) or
  debugging (F7+F10). Setting breakpoint on the first row inside the 'main'
  function allows debugging step-by-step after 'Engine.OnStarted' event.
  Results can be seen in the image viewer on the DevicePage.
  Restarting the Sample may be necessary to show images after loading the webpage.
  To run this Sample a device with SICK Algorithm API and AppEngine >= V2.5.0 is
  required. For example SIM4000 with latest firmware. Alternatively the Emulator
  in AppStudio 2.3 or higher can be used.

  More Information:
  Tutorial "Algorithms - Data Types".

------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

local DELAY = 1000 -- ms between visualization steps

-- Creating viewer
local viewer = View.create()
viewer:setID('viewer2D')

-- Settin up graphical overlay attributes
local textDec1 = View.TextDecoration.create() -- Level
local text1Position = {20, 40}
local text1Size = 35

local textDec2 = View.TextDecoration.create() -- Image size
local text2Position = {20, 105}
local text2Size = 25

local textDecoration = View.ShapeDecoration.create()
textDecoration:setLineColor(0, 0, 230)

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  local img = Image.load('resources/ImagePyramid.bmp')
  local downsamplingLevels = 5
  local imgPyramid = Image.Pyramid.create(img, downsamplingLevels)
  for i = 0, downsamplingLevels - 1 do
    local downsampledImage = imgPyramid:getImage(i)
    viewer:clear()
    local imageID = viewer:addImage(downsampledImage)
    -- Writing pyramid level with scaled text (to fit image size)
    textDec1:setSize(text1Size / (1 ^ i))
    textDec1:setPosition(text1Position[1] / (1 ^ i), text1Position[2] / (1 ^ i))
    viewer:addText('Level: ' .. i, textDec1, nil, imageID)

    local width, height = downsampledImage:getSize()
    textDec2:setSize(text2Size / (1 ^ i))
    textDec2:setPosition(text2Position[1] / (1 ^ i), text2Position[2] / (1 ^ i))
    viewer:addText(width .. 'x' .. height, textDec2, nil, imageID)

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
