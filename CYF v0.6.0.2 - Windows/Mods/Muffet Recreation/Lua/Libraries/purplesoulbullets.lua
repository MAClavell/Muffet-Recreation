-------------------------------------------------------------------------------
-----------------THESE BULLETS ONLY WORK WITH THE NORMAL ARENA-----------------
-------------------------------------------------------------------------------

local objects = {}

objects.Object = {}

function objects.Object.new(info)
  local self = info
  return self
end
---------------------------------SPIDER BULLET---------------------------------

--spider bullet table
objects.Spider = {}
CreateProjectileLayer("spiderBullets", "", false)

--How to create::
--spiderObj = {}
--table.insert(spiderObj, "requireName".Spider.new( { sprite=____, y=____, side=____, speed=____, time=___, spawned=false })

--requireName = the name of the variable designated in the require
--Creates a spider projectile that moves straight across the screen
--sprite = string name of the sprite
--side = bool direction (true is left, false is right)
--y = int starting y position
--time = double when the bullet should spawn in seconds
--speed = int how fast to move in terms of pixels/frame

--Place in the wave's Update method
--[[
  for i=1,#spiderObj do
    if spiderObj[i].spawned == false and (ourtime > spiderObj[i].time) then 
      spiderObj[i].Create()
    end
    if spiderObj[i].spawned then
      spiderObj[i].Update()
    end
  end
]]--
function objects.Spider.new(info)
  local self = objects.Object.new(info)
  
  function self.Create()
    --find starting x position
    local x = 0
    if self.side then
      x = Arena.x-(Arena.width/2)-100
    else
      x = Arena.x+(Arena.width/2)+100
      self.speed = -self.speed
    end
    self.spider = CreateProjectileAbs(self.sprite, x, self.y, "spiderBullets")
    self.spider.SetVar("deadly", true)
    self.spider.SetVar("damage", 6)
    self.spawned = true
  end
  
  function self.Update()
    local bullet = self.spider
    if bullet.isactive then
      bullet.MoveToAbs(bullet.absx+(self.speed*Time.mult), self.y)

      if bullet.x > (Arena.width/2)+100 or bullet.x < (-Arena.width/2)-100 then
        bullet.remove()
      end
    end
  end
  
  return self
    
end

---------------------------------DONUT BULLET---------------------------------

--donut bullet table
objects.Donut = {}
CreateProjectileLayer("donutBullets", "", false)

--How to create::
--donutObj = {}
--table.insert(donutObj, "requireName".Donut.new( { sprite=____, squishSprite=____, y=____, side=____, speed=____, time=___, spawned=false })

--requireName = the name of the variable designated in the require
--sprite = string name of the sprite
--squishSprite = name of sprite when bullet is squished
--y = int starting y position
--side = bool direction (true is left, false is right)
--speed = int how fast to move in terms of pixels/frame
--time = double when the bullet should spawn in seconds

--Place in the wave's Update method
--[[
  for i=1,#donutObj do
    if donutObj[i].spawned == false and (ourtime > donutObj[i].time) then 
      donutObj[i].Create()
    end
    if donutObj[i].spawned then
      donutObj[i].Update()
    end
  end
]]--
function objects.Donut.new(info)
  --Fields
  local self = objects.Object.new(info)
  local xspeed
  local yspeed
  local bounce = false
  local setBounce = false
  local bounceTimer = 0
  local upperBound = Arena.height/2 - 12
  local lowerBound = -Arena.height/2 + 12

  --Constructor
  function self.Create()
    --find starting x position
    local x = 0
    if self.side then
      x = Arena.x-(Arena.width/2)-100
      xspeed = self.speed
    else
      x = Arena.x+(Arena.width/2)+100
      xspeed = -self.speed
    end

    --find y position and speed at which to move on the y-axis
    local height = 0
    if self.y<Arena.y+Arena.height/2 then
      height = Arena.y+(Arena.height) --top of arena
    elseif self.y>Arena.y+Arena.height/2 then
      height = Arena.y --bottom of arena
    end
    local ydifference = height - self.y
    local length = math.abs(math.sqrt(220^2 + ydifference^2))
    yspeed = (ydifference/length)*self.speed

    self.donut = CreateProjectileAbs(self.sprite, x, self.y, "donutBullets")
    self.donut.SetVar("deadly", true)
    self.donut.SetVar("damage", 6)
    self.spawned = true
  end
  
  --Methods
  --Updates the position of the donut bullet
  function self.Update()
    local bullet = self.donut
    if bullet.isactive then --Check if bullet is removed
      --Move bullet
      bullet.MoveTo(bullet.x+(xspeed*Time.mult), bullet.y+(yspeed*Time.mult))

      --Reverse yspeed if it hits an arena boundary
      if bullet.y > Arena.height/2 - 12 then
        local newy =(lowerBound-bullet.y)
        local ydifference = newy - bullet.y
        local length = math.abs(math.sqrt(220^2 + ydifference^2))  
        yspeed = (ydifference/length)*self.speed
        bounce = true
      elseif bullet.y < (-Arena.height/2) + 12 then
        local newy =(upperBound-bullet.y)
        local ydifference = newy - bullet.y
        local length = math.abs(math.sqrt(220^2 + ydifference^2))  
        yspeed = (ydifference/length)*self.speed
        bounce = true
      end
        
      --Check if the bullet is bouncing
      if bounce == true then
        if not setBounce then
          bullet.sprite.Set(self.squishSprite)
          setBounce = true
        elseif bounceTimer > 0.1 and setBounce == true then
          bullet.sprite.Set(self.sprite)
          setBounce = false
          bounce = false
          bounceTimer = 0
        end
        bounceTimer = bounceTimer + Time.dt
      end

      --Remove bullets if out of bounds
      if bullet.x > (Arena.width/2)+100 or bullet.x < (-Arena.width/2)-100 then
        bullet.remove()
      end
    end
  end
  
  return self
    
end

---------------------------------CROISSANT BULLET---------------------------------

--croissant object table
objects.Croissant = {}
CreateProjectileLayer("croissantBullets", "", false)

--How to create::
--croissantObj = {}
--table.insert(croissantObj, "requireName".Croissant.new( { sprite=____, y=____, side=____, time=____, spawned=false }))

--requireName = the name of the variable designated in the require
--sprite = string name of the sprite
--y = int starting y position
--side = bool direction (true is left, false is right)
--speed = int how fast to move in terms of pixels/frame
--time = double when the bullet should spawn in seconds

--Place in the wave's Update method
--[[
  for i=1,#croissantObj do
    if croissantObj[i].spawned == false and (ourtime > croissantObj[i].time) then 
      croissantObj[i].Create()
    end
    if croissantObj[i].spawned then
      croissantObj[i].Update()
    end
  end
]]--
function objects.Croissant.new(info)
  local self = objects.Object.new(info)
  local timer = 0

  function self.Create()
    --find starting x position
    local x = 0
    if self.side then
      x = Arena.x-(Arena.width/2)-100
    else
      x = Arena.x+(Arena.width/2)+100
    end
    self.croissant = CreateProjectileAbs(self.sprite, x, self.y, "croissantBullets")
    self.croissant.SetVar("deadly", true)
    self.croissant.SetVar("damage", 6)
    self.spawned = true
  end
  
  function self.Update()
    local bullet = self.croissant
    if bullet.isactive then
      if self.side then
        bullet.MoveTo(bullet.x+((5.1*math.cos(timer))*Time.mult), bullet.y)
        bullet.sprite.rotation = (timer*360)/2
      else
        bullet.MoveTo(bullet.x-((5.1*math.cos(timer))*Time.mult), bullet.y)
        bullet.sprite.rotation = -(timer*360)/2
      end
      if bullet.x > (Arena.width/2)+100 or bullet.x < (-Arena.width/2)-100 then
        bullet.remove()
      end
      timer = timer + Time.dt
    end
  end
  
  return self
    
end


---------------------------------MOVING ARENA SPIDER BULLET---------------------------------
--NOTE: USE WITH MANIPULATABLE ARENAS ONLY

--spider bullet table
objects.SpiderManipulatable = {}

--How to create::
--spiderMovingObj = {}
--table.insert(spiderManipulatableObj, "requireName".SpiderManipulatable.new( { sprite=____, spriteInvis=____, y=____, side=____, speed=____, time=___, spawned=false }))

--requireName = the name of the variable designated in the require
--Creates a spider projectile that moves straight across the screen
--sprite = string name of the sprite
--side = bool direction (true is left, false is right)
--y = int starting y position
--time = double when the bullet should spawn in seconds
--speed = int how fast to move in terms of pixels/frame

--Place in the wave's Update method
--[[
  for i=1,#spiderManipulatableObj do
    if spiderManipulatableObj[i].spawned == false and (ourtime > spiderManipulatableObj[i].time) then
      spiderManipulatableObj[i].Create()
    end
    if spiderManipulatableObj[i].spawned then
      spiderManipulatableObj[i].Update()
    end
  end
]]--

function objects.SpiderManipulatable.new(info)
  local self = objects.Object.new(info)
  local y = Arena.y
  
  function self.Create()
    --find starting x position
    local x = 0
    if self.side then
      x = 320-(Arena.width/2)-100

    else
      x = 320+(Arena.width/2)+100
      self.speed = -self.speed
    end
    self.spiderInvis = CreateProjectileAbs(self.spriteInvis, x, self.y, "spiderBullets")
    self.spiderInvis.SetVar("deadly", true)
    self.spiderInvis.SetVar("damage", 6)

    self.spider = CreateSprite(self.sprite, "Top")
    self.spider.MoveTo(arena.parentSprite.x+self.spiderInvis.x, arena.parentSprite.x+self.spiderInvis.y)

    self.spawned = true
  end
  
  function self.Update()
    local bullet = self.spider
    local bulletInvis = self.spiderInvis
    if bullet.isactive and bulletInvis.isactive then
      bulletInvis.MoveToAbs(bulletInvis.absx+(self.speed*Time.mult), bulletInvis.absy)

      --Move bullet in relation to the arena
      bullet.MoveTo(bulletInvis.x+arena.parentSprite.x, bulletInvis.y+arena.parentSprite.y)

      if bulletInvis.absx > 320+(Arena.width/2)+100 or bulletInvis.absx < 320-(Arena.width/2)-100 then
        bullet.Remove()
        bulletInvis.Remove()
      end
    end
  end
  
  return self
    
end


---------------------------------MOVING ARENA SPIDER BULLET---------------------------------
--NOTE: USE WITH MOVING ARENAS ONLY

--spider bullet table
objects.SpiderMoving = {}
CreateProjectileLayer("spiderMovingBullets", "", false)

--How to create::
--spiderMovingObj = {}
--table.insert(spiderMovingObj, "requireName".SpiderMoving.new( { sprite=____, spriteInvis=____, y=____, side=____, speed=____, time=___, spawned=false }))

--requireName = the name of the variable designated in the require
--Creates a spider projectile that moves straight across the screen
--sprite = string name of the sprite
--side = bool direction (true is left, false is right)
--y = int starting y position
--time = double when the bullet should spawn in seconds
--speed = int how fast to move in terms of pixels/frame

--Place in the wave's Update method
--[[
  for i=1,#spiderMovingObj do
    if spiderMovingObj[i].spawned == false and (ourtime > spiderMovingObj[i].time) then
      spiderMovingObj[i].Create()
    end
    if spiderMovingObj[i].spawned then
      spiderMovingObj[i].Update()
    end
  end
]]--
--[[
function objects.SpiderMoving.new(info)
  local self = objects.Object.new(info)
  local y = Arena.y
  
  function self.Create()
    --find starting x position
    local x = 0
    if self.side then
      x = 320-(Arena.width/2)-100

    else
      x = 320+(Arena.width/2)+100
      self.speed = -self.speed
    end
    self.spider = CreateProjectileAbs(self.sprite, x, self.y, "spiderBullets")
    self.spiderInvis = CreateProjectileAbs(self.spriteInvis, x, self.y, "spiderBullets")
    self.spider.SetVar("deadly", true)
    self.spider.SetVar("damage", 6)
    self.spawned = true
  end
  
  function self.Update()
    local bullet = self.spider
    local bulletInvis = self.spiderInvis
    if bullet.isactive and bulletInvis.isactive then
      bulletInvis.MoveToAbs(bulletInvis.absx+(self.speed*Time.mult), bulletInvis.absy)

      --Move bullet in relation to the arena
      bullet.MoveTo(bulletInvis.x+(Arena.x-320), bulletInvis.y+((Arena.y+Arena.height/2)-(y+Arena.height/2)))

      if bulletInvis.absx > 320+(Arena.width/2)+100 or bulletInvis.absx < 320-(Arena.width/2)-100 then
        bullet.Remove()
        bulletInvis.Remove()
      end
    end
  end
  
  return self
    
end ]]--

---------------------------------PET ARENA SPIDER BULLET---------------------------------
--NOTE: USE WITH PET ARENAS ONLY

--spider object table
objects.SpiderPet = {}


--table.insert(spiderMovingObj, "requireName".SpiderPet.new( { sprite=____, spriteInvis=____, y=____, xspeed=____, yspeed=____, tilt=___}))
function objects.SpiderPet.new(info)
  local self = objects.Object.new(info)
  
  function self.Create()
    --Get the x direction
    local direction = 0
    while direction == 0 do
      direction = math.random(-1, 1)
    end
    self.xspeed = self.xspeed*direction

    --Get the starting x position
    local xpos = math.random(Arena.x-100, Arena.x+100)

    self.spiderInvis = CreateProjectileAbs(self.spriteInvis, xpos, self.y)
    self.spiderInvis.SetVar("deadly", true)
    self.spiderInvis.SetVar("damage", 6)

    self.spider = CreateSprite(self.sprite, "Top")
    self.spider.MoveToAbs(self.spiderInvis.absx, self.spiderInvis.absy)
    self.spider.SetParent(arena.arenaParent)
    self.spider.rotation = 5*math.sin(3*self.tilt)
  end

  function self.Update()
    if self.spider.isactive and self.spiderInvis.isactive then
      --If the bullet reaches the edge of a web
      if self.spiderInvis.x > 100 or self.spiderInvis.x < -100 then
        self.xspeed = -self.xspeed
        self.spiderInvis.MoveTo(self.spiderInvis.x+(self.xspeed*Time.mult), self.spiderInvis.y-(self.yspeed*Time.mult))
      --Else move normally
      else self.spiderInvis.MoveTo(self.spiderInvis.x+(self.xspeed*Time.mult), self.spiderInvis.y-(self.yspeed*Time.mult)) end

      --Update the sprit's position
      self.spider.MoveTo(self.spiderInvis.x+arena.arenaSprite.x, self.spiderInvis.y+arena.arenaSprite.y)

      if self.spiderInvis.absy < Arena.y then
        self.spiderInvis.Remove()
        self.spider.Remove()
      end
    end
  end

  function self.Remove()
    self.spiderInvis.Remove()
    self.spider.Remove()
  end

  return self
  
end

return objects