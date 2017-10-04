local objects = {}

objects.Object = {}

function objects.Object.new(info)
  local self = info
  return self
end

----------------------------------------------------------------------------------------------

objects.PurpleArena = {}

--PurpleArena.new( {numRows = __})
function objects.PurpleArena.new(info)
  local self = objects.Object.new(info)
  self.webs = {}
  local moving = 0
  local moveUp = false
  local moveDown = false
  local playerSprite = nil

  --Creates the arena object
  function self.Create()
    local yWeb = -40
    local height = Arena.height

    CreateLayer("websLayer", "BelowPlayer", false)

    --Create an inputted amount of webs
   	for i=1,self.numRows do
   		local web = CreateSprite("purplesoul/arenaweb", "websLayer")
      web.absx = Arena.x
      web.absy = Arena.currenty + Arena.height/2 + yWeb
      yWeb = yWeb + 40

      if self.numRows > 3 and i > 3 then
        height = height + 40
      end

      table.insert(self.webs, web)
   	end

    Player.sprite.color = {213/255, 53/255, 217/255}
    Player.SetControlOverride(true)
    playerSprite = CreateSprite("purplesoul/soulbullet0", "websLayer")

    Arena.ResizeImmediate(240, height)
  end

  function self.Update()
    if Player.hp < 1 then
      Player.MoveToAbs(playerSprite.absx, playerSprite.absy)
    end

    --Check if up is pressed
    if Input.Up == 1 and Player.absy < self.webs[self.numRows].absy and moveDown == false then
      moveUp = true --initiate upwards movement
    end
    --Check if down is pressed
    if Input.Down == 1 and Player.absy > self.webs[1].absy+5 and moveUp == false then
      moveDown = true --initiate downwards movement
    end
    
    --If left is pressed, move left
    if Input.Left > 0 and Player.x > -100 then
      Player.MoveTo(Player.x-2, Player.y, false)
    end
    --If right is pressed, move right
    if Input.Right > 0 and Player.x < 100 then
      Player.MoveTo(Player.x+2, Player.y, false)
    end
    
    --Player moves up
    if moveUp then
      if moving < 40 then
        Player.MoveTo(Player.x, Player.y+10, false)
        moving = moving + 10
      else
        moving = 0
        moveUp = false
      end
    end
    --Player moves down
    if moveDown then
      if moving < 40 then
        Player.MoveTo(Player.x, Player.y-10, false)
        moving = moving + 10
      else
        moving = 0
        moveDown = false
      end
    end

    --Update the player sprite's posisition
    playerSprite.MoveToAbs(Player.absx, Player.absy)
    playerSprite.SendToTop()

    --Blink the player at 15 fps if hurting
    local heartframe = 0
    if (Player.isHurting) then heartframe = math.floor((Time.time / (1/15)) % 2) end
    playerSprite.Set("purplesoul/soulBullet" .. heartframe)  
  end

  --Removes every sprite used by the object
  --Use this when removing the arena at the end of a wave
  function self.RemoveSprites()
    for i=1,#self.webs do
      self.webs[i].Remove()
    end
    playerSprite.Remove()
  end

  return self
end

----------------------------------------------------------------------------------------------
--[[
objects.PurpleArenaMoving = {}

--PurpleArenaMoving.new( {numRows=____, xspeed=____, yspeed=____, moveTo=____})
function objects.PurpleArenaMoving.new(info)
  local self = objects.Object.new(info)
  self.webs = {}
  local moving = 0
  local moveUp = false
  local moveDown = false

  --Creates the arena object
  function self.Create()
    local yWeb = -40
    local height = Arena.height

    CreateLayer("websLayer", "BelowPlayer", false)

    --Create an inputted amount of webs
    for i=1,self.numRows do
      local web = CreateSprite("purplesoul/arenaweb", "websLayer")
      web.absx = Arena.x
      web.absy = Arena.currenty + Arena.height/2 + yWeb
      yWeb = yWeb + 40

      if self.numRows > 3 and i > 3 then
        height = height + 40
      end

      table.insert(self.webs, web)
    end

    Player.sprite.color = {213/255, 53/255, 217/255}
    Player.SetControlOverride(true)

    Arena.ResizeImmediate(240, height)
  end

  --Updates the arena's position and player movement
  function self.Update()
    --Check if up is pressed
    if Input.Up == 1 and Player.absy < self.webs[self.numRows].absy and moveDown == false then
      moveUp = true --initiate upwards movement
    end
    --Check if down is pressed
    if Input.Down == 1 and Player.absy > self.webs[1].absy+5 and moveUp == false then
      moveDown = true --initiate downwards movement
    end
    
    --If left is pressed, move left
    if Input.Left > 0 and Player.x > -100 then
      Player.MoveTo(Player.x-2, Player.y, false)
    end
    --If right is pressed, move right
    if Input.Right > 0 and Player.x < 100 then
      Player.MoveTo(Player.x+2, Player.y, false)
    end
    
    --Player moves up
    if moveUp then
      if moving < 40 then
        Player.MoveTo(Player.x, Player.y+10, false)
        moving = moving + 10
      else
        moving = 0
        moveUp = false
      end
    end
    --Player moves down
    if moveDown then
      if moving < 40 then
        Player.MoveTo(Player.x, Player.y-10, false)
        moving = moving + 10
      else
        moving = 0
        moveDown = false
      end
    end

    if self.moveTo then
      Arena.MoveTo(self.xspeed*Time.mult, self.yspeed*Time.mult, true, false)
      local c = 0
      for i=1,#self.webs do
        local web = self.webs[i]
        web.MoveToAbs(Arena.currentx+120, Arena.currenty+25+(40*c))
        c=c+1
      end
    else
      Arena.Move(self.xspeed*Time.mult, self.yspeed*Time.mult, true, false)
      local c = 0
      for i=1,#self.webs do
        local web = self.webs[i]
        web.MoveToAbs(Arena.currentx+120, Arena.currenty+25+(40*c))
        c=c+1
      end 
    end
  end

  --Removes every sprite used by the object
  --Use this when removing the arena at the end of a wave
  function self.RemoveSprites()
    for i=1,#webs do
      self.webs[i].Remove()
    end
  end

  return self
end ]]--

----------------------------------------------------------------------------------------------

objects.PurpleArenaManipulatable = {}

--PurpleArenaManipulatable.new( {arenaSprite=____, arenaCover=____, arenaTransparent=____, numRows=____, xspeed=____, yspeed=____, moveTo=____})
--The Manipulatable arena allows manipulation of the arena sprite as well as movement
--This is because everything is going on invisibly underneath
function objects.PurpleArenaManipulatable.new(info)
  local self = objects.Object.new(info)
  self.webs = {}
  self.websInvis = {}
  local moving = 0
  local moveUp = false
  local moveDown = false
  local arenaCover = nil
  self.playerSprite = nil
  self.parentSprite = nil

  --Creates the arena object
  function self.Create()
    local yWeb = -40
    local height = Arena.height

    --Get height for the arena
    for i=1,self.numRows do 
      if i > 3 then
        height = height + 40
      end
    end

    --Resize the arena
    Arena.ResizeImmediate(240, height)

    CreateLayer("arenaLayerMan", "BelowBullet", false)
    CreateLayer("websLayerMan", "BelowBullet", false)

    --Cover the arena
    self.arenaCover = CreateSprite(self.arenaCoverSpr, "arenaLayerMan")
    self.arenaCover.MoveToAbs(Arena.x, Arena.currenty+(Arena.height/2))

    --Create transparent parent sprite
    self.parentSprite = CreateSprite(self.transparentSprite, "arenaLayerMan")
    self.parentSprite.MoveToAbs(Arena.x, Arena.currenty+(Arena.height/2))

    --Create the arena's sprite
    self.sprite = CreateSprite(self.arenaSprite, "arenaLayerMan")
    self.sprite.MoveToAbs(Arena.x, Arena.currenty+(Arena.height/2))
    self.sprite.SetParent(self.parentSprite)

    --Create an inputted amount of webs
    for i=1,self.numRows do
      local web = CreateSprite("purplesoul/arenaweb", "websLayerMan")
      local webInvis = CreateSprite("purplesoul/arenawebtransparent", "websLayerMan")
      webInvis.absx = Arena.x
      web.absx = webInvis.absx
      webInvis.absy = Arena.currenty + Arena.height/2 + yWeb
      web.absy = webInvis.absy
      yWeb = yWeb + 40

      --Parent the visible webs to the arena sprite
      web.SetParent(self.parentSprite)

      table.insert(self.websInvis, webInvis)
      table.insert(self.webs, web)
    end

    --Set sprite colors
    Player.sprite.color = {213/255, 53/255, 217/255}
    Player.SetControlOverride(true)

    --Create Player sprite
    self.playerSprite = CreateSprite("purplesoul/soulbullet0", "websLayerMan")
    self.playerSprite.SetParent(self.parentSprite)
  end

  --Updates the arena's position and player movement
  function self.Update()
    if Player.hp < 1 then
      Player.MoveToAbs(self.playerSprite.absx, self.playerSprite.absy)
    end

    --Check if up is pressed
    if Input.Up == 1 and Player.absy < self.websInvis[self.numRows].absy and moveDown == false then
      moveUp = true --initiate upwards movement
    end
    --Check if down is pressed
    if Input.Down == 1 and Player.absy > self.websInvis[1].absy+5 and moveUp == false then
      moveDown = true --initiate downwards movement
    end
    
    --If left is pressed, move left
    if Input.Left > 0 and Player.x > -100 then
      Player.MoveTo(Player.x-2, Player.y, true)
    end
    --If right is pressed, move right
    if Input.Right > 0 and Player.x < 100 then
      Player.MoveTo(Player.x+2, Player.y, true)
    end
    
    --Player moves up
    if moveUp then
      if moving < 40 then
        Player.MoveTo(Player.x, Player.y+10, true)
        moving = moving + 10
      else
        moving = 0
        moveUp = false
      end
    end
    --Player moves down
    if moveDown then
      if moving < 40 then
        Player.MoveTo(Player.x, Player.y-10, true)
        moving = moving + 10
      else
        moving = 0
        moveDown = false
      end
    end

    if self.moveTo then
      self.parentSprite.MoveToAbs(self.xspeed, self.yspeed)
    else
      self.parentSprite.MoveToAbs(self.parentSprite.absx+self.xspeed, self.parentSprite.absy+self.yspeed)
    end

    --Update the player sprite's posisition
    self.playerSprite.MoveTo(Player.x+self.sprite.x, Player.y+self.sprite.y)
    self.playerSprite.SendToTop()

    --Blink the player at 15 fps if hurting
    local heartframe = 0
    if (Player.isHurting) then heartframe = math.floor((Time.time / (1/15)) % 2) end
    self.playerSprite.Set("purplesoul/soulBullet" .. heartframe)  
  end

  function self.AddWeb()
      Arena.ResizeImmediate(240, Arena.height+40)

      local web = CreateSprite("purplesoul/arenaweb", "websLayerMan")
      local webInvis = CreateSprite("purplesoul/arenawebtransparent", "websLayerMan")
      webInvis.absx = self.websInvis[self.numRows].absx
      web.absx = self.webs[self.numRows].absx
      webInvis.absy = self.websInvis[self.numRows].absy + 40
      web.absy = self.webs[self.numRows].absy + 40

      --Parent the visible webs to the arena sprite
      web.SetParent(self.parentSprite)

      table.insert(self.websInvis, webInvis)
      table.insert(self.webs, web)

      self.numRows = self.numRows + 1
  end

  --Adds a web to the bottom of the table and does not resize the arena
  --Custom made for Muffet's pet attack
  --tiltTimer = rotation of the arena
  function self.AddWebBelowNoResize(tiltTimer)
    local web = CreateSprite("purplesoul/arenaweb", "websLayerMan")
    local webInvis = CreateSprite("purplesoul/arenawebtransparent", "websLayerMan")
    webInvis.absx = self.websInvis[1].absx
    web.absx = self.webs[1].absx
    webInvis.absy = self.websInvis[1].absy - 40
    web.absy = self.webs[1].absy - 40

    web.rotation = 5*math.sin(3*tiltTimer)

    --Parent the visible webs to the arena sprite
    web.SetParent(self.parentSprite)

    table.insert(self.websInvis, 1, webInvis)
    table.insert(self.webs, 1, web)

    self.numRows = self.numRows + 1
  end

  --Removes every sprite used by the object
  --Use this when removing the arena at the end of a wave
  function self.RemoveSprites()
    for i=1,#self.webs do
      self.webs[i].Remove()
      self.websInvis[i].Remove()
    end
    self.playerSprite.Remove()
    self.sprite.Remove()
    self.parentSprite.Remove()
    self.arenaCover.Remove()
  end

  return self
end

----------------------------------------------------------------------------------------------
--Warning: Below is a whole mess of code
--I tried my best to replicate things from Undertale and comment how they work, but the way I did things is
--definetly not the best. It would work a lot better in a true object based programming language.
--If you want to see how to use this arena look at the muffet_pet# waves, it is a complete recreation of
--the pet attacks.

objects.PurpleArenaPet = {}

--PurpleArenaPet.new( {speed=____})
function objects.PurpleArenaPet.new(info)
  local self = objects.Object.new(info)
  self.webs = {}
  local tWeb = nil
  local bWeb = nil
  local cWebInd = nil
  local arenaCover = nil
  self.arenaParent = nil
  self.arenaSprite = nil
  local moving = 0
  local moveUp = false
  local moveDown = false
  local tiltTimer = 0
  local playerSprite = nil
  self.spiderObj = {}
  local hasSpiders = {}
  local petTimer = nil
  local petNum = nil
  local petBiteNum = nil
  local biteTimer = 0
  local biteIncrement = nil
  local petSprite = nil
  local increment = nil
  local petMX = nil

  --Creates the arena object
  function self.Create(tilt, websTransitioned, petBite, petBiteIncrement, petSpriteNum, petIncrement, petMoveX, timer, petBiteTimer)
    Arena.ResizeImmediate(240, 300)

    --Cover the real arena
    CreateLayer("coverLayer", "BelowBullet", true)
    arenaCover = CreateSprite("purplesoul/arenatiltcover", "coverLayer")
    arenaCover.MoveToAbs(Arena.x, 5+Arena.y+Arena.height/2)

    --Create the parent sprite
    CreateLayer("arenaLayer", "BelowBullet", false)
    self.arenaParent = CreateSprite("purplesoul/arenatilttransparent", "arenaLayer")
    self.arenaParent.MoveToAbs(Arena.x, 5+Arena.y+Arena.height/2)

    --Create the visible arena sprite
    self.arenaSprite = CreateSprite("purplesoul/arenatilt", "arenaLayer")
    self.arenaSprite.SetParent(self.arenaParent)
    self.arenaSprite.MoveToAbs(Arena.x, 5+Arena.y+Arena.height/2)

    --Create pet bullet
    petNum = petSpriteNum
    petBiteNum = petBite
    biteIncrement = petBiteIncrement
    increment = petIncrement
    petTimer = timer
    biteTimer = petBiteTimer
    petMX = petMoveX
    if petNum < 10 then
      petSprite = "frame_00000"..petNum
    else
      petSprite = "frame_0000"..petNum
    end

    self.pet = CreateProjectileAbs("purplesoul/pet" .. petBiteNum .. "/" .. petSprite .. " (41ms)", Arena.x, Arena.y+45)
    self.pet.sprite.layer = "arenaLayer"
    self.pet.sprite.SetParent(self.arenaParent)
    self.pet.SetVar("deadly", true)
    self.pet.SetVar("damage", 4)
    self.pet.ppcollision = true

    --Create visible sprites for each web
    for i=1,8 do
      --Create web
      local web = CreateSprite("purplesoul/arenaweb", "arenaLayer")

      web.SetParent(self.arenaParent)

      --Get positions
      web.absx = Arena.x
      if i<8 then web.absy = websTransitioned[i]
        else web.absy = websTransitioned[i-1]+40 end

      --The created webs don't have spiders on them
      hasSpiders[i] = false

      --Find top web and bottom web
      if i==8 then tWeb = web end
      if i == 1 then bWeb = web end

      --Determine if this web is the web the player is on.
      --While this seems unncessary, the player slowly gets offset from the webs as the wave goes on
      --This is to ensure the player is always ontop of a web
      if Player.absy > web.absy-5 and Player.absy < web.absy+5 then
        cWebInd = i
      end

      table.insert(self.webs, web)
    end

    --Set sprite colors
    Player.sprite.color = {213/255, 53/255, 217/255}
    Player.SetControlOverride(true)

    --Create Player sprite
    playerSprite = CreateSprite("purplesoul/soulbullet0", "arenaLayer")
    playerSprite.SetParent(self.arenaParent)

    tiltTimer = tilt
    self.arenaParent.rotation = 5*math.sin(3*tiltTimer)

    --Initial layering
    self.pet.sprite.SendToTop()
    self.arenaSprite.SendToTop()
  end

  --Updates the arena's position and player movement
  function self.Update()
    if Player.hp < 1 then
      Player.MoveToAbs(playerSprite.absx, playerSprite.absy)
    end

    --Check if up is pressed
    if Input.Up == 1 and Player.absy < tWeb.absy-5 and moveDown == false then
      moveUp = true --initiate upwards movement
    end
    --Check if down is pressed
    if Input.Down == 1 and Player.absy > bWeb.absy+5 and moveUp == false then
      moveDown = true --initiate downwards movement
    end
    
    --If left is pressed, move left
    if Input.Left > 0 and Player.x > -100 then
      Player.MoveToAbs(Player.absx-2, Player.absy, true)
    end
    --If right is pressed, move right
    if Input.Right > 0 and Player.x < 100 then
      Player.MoveToAbs(Player.absx+2, Player.absy, true)
    end
    
    --Update downwards movement
    for i=1,#self.webs do
      self.webs[i].y = self.webs[i].y-(self.speed)
     
      --If a web is below the arena
      if(self.webs[i].absy < Arena.y) then

        --Adjust web y values
        self.webs[i].y = tWeb.y+40

        --Create spider bullets
        local percent = 90
        local result = math.random(1, 100)
        if i==1 then
          if not hasSpiders[8] or (hasSpiders[8] and result > percent) then
            self.CreateSpiders(self.webs[i].absy, 3, 3)
            hasSpiders[i] = true
          else
            hasSpiders[i] = false
          end
        else
          if not hasSpiders[i-1] or (hasSpiders[i-1] and result > percent) then
            self.CreateSpiders(self.webs[i].absy, 3, 3)
            hasSpiders[i] = true
          else
            hasSpiders[i] = false
          end
        end

        --Get new top webs and bottom webs
        tWeb = self.webs[i]
        if i==8 then bWeb = self.webs[1]
        else bWeb = self.webs[i+1] end

        --Adjust player y values if out of the arena
        if cWebInd == i then 
          if cWebInd == 8 then cWebInd = 1
            else cWebInd = cWebInd+1 end
        end
      end
    end

    --Player moves up
    if moveUp then
      if moving < 40 then
        Player.MoveToAbs(Player.absx, Player.absy+8, true)
        moving = moving + 10
      else
        moving = 0
        moveUp = false
        if cWebInd == 8 then cWebInd = 1
          else cWebInd = cWebInd+1 end
      end
    --Player moves down
    elseif moveDown then
      if moving < 40 then
        Player.MoveToAbs(Player.absx, Player.absy-8, true)
        moving = moving + 10
      else
        moving = 0
        moveDown = false
        if cWebInd == 1 then cWebInd = 8
          else cWebInd = cWebInd-1 end
      end
    --Player is not moving between webs
    else Player.MoveToAbs(Player.absx, self.webs[cWebInd].absy, true) end

    --Spider updating
    for i=1,#self.spiderObj do
      self.spiderObj[i].Update()
    end

    --Update the player sprite's posisition
    playerSprite.MoveTo(Player.x+self.arenaSprite.x, Player.y+self.arenaSprite.y)

    --Update the arena's tilt
    self.arenaParent.rotation = 5*math.sin(3*tiltTimer)
    tiltTimer = tiltTimer+Time.dt

    --Blink the player at 15 fps if hurting
    local heartframe = 0
    if (Player.isHurting) then heartframe = math.floor((Time.time / (1/15)) % 2) end
    playerSprite.Set("purplesoul/soulBullet" .. heartframe)


    --Adjust pet sprite and send it to top of layer
    --The reason for this super complicated method is that the arena cannot hide sprites outside of it
    --I also did not want to go through the trouble of created a fake UI so this is the solution instead

    --Change sprite at 30fps for the majority of the time
    if petNum > 41 and petNum < 84 and petTimer > 1/30 then
      petTimer = petTimer - 1/30
      --Increment the number correctly
      if petNum > 0 and petNum < 91 then
        petNum = petNum + increment
      end
      --Change the increment if it reaches a bound
      if petNum == 36 then
        increment = 2
      elseif petNum == 90 then
        increment = -2
      end

    --Change sprite at 15fps so that it looks like it slows down near the highs and lows
    elseif petNum > 35 and petNum < 91 and petTimer > 1/15 then
      petTimer = petTimer - 1/15
      --Increment the number correctly
      if petNum > 0 and petNum < 91 then
        petNum = petNum + increment
      end
      --Change the increment if it reaches a bound
      if petNum == 36 then
        increment = 2
      elseif petNum == 90 then
        increment = -2
      end
    end
    --Build the sprite name
    if petNum < 10 then
      petSprite = "frame_00000"..petNum
    else
      petSprite = "frame_0000"..petNum
    end
    petTimer = petTimer + Time.dt

    --Change the bite if needed
    if biteTimer > 0.35 then
      biteTimer = biteTimer - 0.35
      petBiteNum = petBiteNum + biteIncrement
      if petBiteNum == 1 then
        biteIncrement = 1
      elseif petBiteNum == 3 then
        biteIncrement = -1
      end
    end
    biteTimer = biteTimer + Time.dt


    --Set the sprite
    self.pet.sprite.Set("purplesoul/pet" .. petBiteNum .. "/" .. petSprite .. " (41ms)", Arena.x, Arena.y)
    self.pet.MoveToAbs(Arena.x, Arena.y+45)
    self.pet.sprite.MoveToAbs(Arena.x, Arena.y+45)
    self.pet.sprite.rotation = 5*math.sin(3*tiltTimer)
    --Adjust the x value
    if self.pet.absx < 9 and self.pet.x > -9 then
      self.pet.MoveTo(self.pet.x+petMX, self.pet.y)
    end
    --Change the x increment if it reaches a bound
    if self.pet.absx > 9 then
      petMX = -petMX
    elseif self.pet.absx < -9 then
      petMX = -petMX
    end
  end

  --Create a min to max amount of spiders at an absolute y position
  function self.CreateSpiders(y, min, max)
    local amount = math.random(min, max)
    while amount > 0 do
      local spider = psbul.SpiderPet.new( { sprite="purplesoul/spiderbullet", spriteInvis = "purplesoul/spiderbulletinvis",
      y=y, xspeed=0.5, yspeed=self.speed, tilt=tiltTimer})
      table.insert(self.spiderObj, spider)
      spider.Create()
      amount = amount - 1
    end
  end

  --Removes every sprite used by the object
  --Use this when removing the arena at the end of a wave
  function self.RemoveSprites()
    for i=1,#self.webs do
      self.webs[i].Remove()
    end
    arenaCover.Remove()
    self.arenaParent.Remove()
    self.arenaSprite.Remove()
    playerSprite.Remove()
  end

  return self
end

return objects