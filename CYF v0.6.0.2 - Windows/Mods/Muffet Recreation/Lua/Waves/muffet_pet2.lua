--Recreation of Muffet's last attack
ourtime = Time.time
endwave = ourtime+25

--Purple bullet things
psbul = require "Libraries/purplesoulbullets"

--Purple arena things
psarn = require "Libraries/purplesoularenas"
arena = psarn.PurpleArenaManipulatable.new( {arenaSprite = "purplesoul/arenaSpr", arenaCoverSpr = "purplesoul/arenaCover", 
    transparentSprite = "purplesoul/arenaTransparent", numRows = 3, xspeed = 0, yspeed = 0, moveTo = false})
arena.Create()
webs = arena.websInvis

--Stage control vars
create = false
pet = false

--Spider wave vars
moveLeft = true
sine = true

--Pet reveal vars
reveal = false
revealEnter = true
arenaSpr2 = nil
revealPet = nil
revealTimer = 0
shakeTimer = 0

--Arena building vars
buildTimer = 0
buildThreshold = 20
buildNum = 1
tiltTimer = 0
coverNum = 2

--Arena building pet vars
petSpriteTimer = 0
petSpriteNum = 0
petSpriteString = "frame_000001"
petBite = 1
petBiteTimer = 0
petBiteIncrement = 1
petIncrement = 3
petMoveX = 2

--Create purple soul bullets
spiderManipulatableObj = {}
amountmin=1
amountmax=3
createPercent=90
percent=90
stage=false
dubLoc = 3
singLoc = 1
speedS = 4
spawntime = 1

--Stage 1
for i=1, 12 do
  if not stage then
    table.insert(spiderManipulatableObj, psbul.SpiderManipulatable.new( { sprite="purplesoul/spiderbullet", 
      spriteInvis="purplesoul/spiderbulletinvis", y=webs[dubLoc].absy, side=false, speed=speedS, time=ourtime+spawntime, spawned=false }))
    table.insert(spiderManipulatableObj, psbul.SpiderManipulatable.new( { sprite="purplesoul/spiderbullet", 
      spriteInvis="purplesoul/spiderbulletinvis", y=webs[2].absy, side=false, speed=speedS, time=ourtime+spawntime, spawned=false }))
    --Change the web location of the spider for the next batch
    if dubLoc == 1 then
      dubLoc = 3
    elseif dubLoc == 3 then
      dubLoc = 1
    end
  elseif stage then
    table.insert(spiderManipulatableObj, psbul.SpiderManipulatable.new( { sprite="purplesoul/spiderbullet", 
      spriteInvis="purplesoul/spiderbulletinvis", y=webs[singLoc].absy, side=false, speed=speedS, time=ourtime+spawntime, spawned=false }))
    --Change the web location of the spider for the next batch
    if singLoc == 1 then
      singLoc = 3
    elseif dubLoc == 3 then
      singLoc = 1
    end
  end
  stage = not stage
  spawntime = spawntime+0.5

  --Increment speed so they start going faster
  if i > 2 then
    speedS = speedS + 0.25
  end
end

--Stage 2
for i=1, 4 do
  if not stage then
    table.insert(spiderManipulatableObj, psbul.SpiderManipulatable.new( { sprite="purplesoul/spiderbullet", 
      spriteInvis="purplesoul/spiderbulletinvis", y=webs[2].absy, side=false, speed=speedS, time=ourtime+spawntime, spawned=false }))
  elseif stage then
    table.insert(spiderManipulatableObj, psbul.SpiderManipulatable.new( { sprite="purplesoul/spiderbullet", 
      spriteInvis="purplesoul/spiderbulletinvis", y=webs[1].absy, side=false, speed=speedS, time=ourtime+spawntime, spawned=false }))
    table.insert(spiderManipulatableObj, psbul.SpiderManipulatable.new( { sprite="purplesoul/spiderbullet", 
      spriteInvis="purplesoul/spiderbulletinvis", y=webs[3].absy, side=false, speed=speedS, time=ourtime+spawntime, spawned=false }))
  end
  stage = not stage
  spawntime = spawntime+0.4

  --Increment speed so they go faster
  speedS = speedS + 0.25
end

function Update()
  ourtime = ourtime + Time.dt
  arena.Update()

  --When the arena is moving during the spider wave
  if not create and not pet then
    --Speed setting
    if moveLeft then
      arena.xspeed = -4*Time.mult
    elseif sine then
      arena.moveTo = true
      arena.xspeed = arena.parentSprite.absx + (0.3*Time.mult)
      arena.yspeed = 20*math.sin(((arena.parentSprite.absx)/5)-318.47)+160
    end

    --Position checking
    if moveLeft and arena.parentSprite.absx < 146.5 then
      arena.parentSprite.absx = 146.5
      arena.xspeed = 0
      moveLeft = false
      sine = true
    elseif sine and arena.parentSprite.absx > 320 then
      sine = false
      arena.parentSprite.absx = 320
      arena.parentSprite.absy = 160

      --Set up vars for the pet reveal
      create = true
      reveal = true
      arena.xspeed = 0
      arena.yspeed = 0
      arena.moveTo = false
      arena.sprite.Set("purplesoul/arenaSprNoRight")
      --The second arena sprite
      arenaSpr2 = CreateSprite("purplesoul/arenaSprNoLeft", "arenaLayerMan")
      arenaSpr2.SetPivot(125/400, 70/140)
      arenaSpr2.MoveToAbs(arena.parentSprite.absx, arena.parentSprite.absy)
      arenaSpr2.SendToTop()
      --The pet
      revealPet = CreateSprite("purplesoul/cupcakeMonster1")
      revealPet.MoveToAbs(arena.parentSprite.absx+195, arena.parentSprite.absy-7)
    end

  --When the pet is being revealed and the tilting arena is being built
  elseif create and not pet then
    --When the pet is being revealed
    if reveal then
      --Shaking the pet at 30 fps
      local ogx = arena.parentSprite.absx+195
      local ogy = arena.parentSprite.absy-7
      if (shakeTimer > 1/30) then
        shakeTimer = shakeTimer - 1/30
        local x =-1 + math.random()*3
        local y =-1 + math.random()*3
        revealPet.MoveToAbs(ogx+x, ogy+y)
      end
      shakeTimer = shakeTimer + Time.dt

      --Moving the arena sprites
      if revealEnter and arenaSpr2.absx < arena.parentSprite.absx+120 then
        --Move the right wall of the arena until it completely reveals the pet
        arenaSpr2.MoveToAbs(arenaSpr2.absx + (8*Time.mult), arenaSpr2.absy)
      elseif revealTimer < 2 then
        if revealTimer > 0.8 then
          revealPet.Set("purplesoul/cupcakeMonster2")
        end
        --Timer for controlling how long the pet roars for
        revealTimer = revealTimer + Time.dt
        revealEnter = false
      elseif not revealEnter and arenaSpr2.absx-(8*Time.mult) > 320 then
        --Move the right wall back to the normal arena sprite
        arenaSpr2.MoveToAbs(arenaSpr2.absx - (8*Time.mult), arenaSpr2.absy)
      else
        --Prepare for tilt arena building
        arena.parentSprite.Set("purplesoul/arenatilttransparent")
        arena.parentSprite.absy = arena.parentSprite.absy+85
        arena.sprite.Set("purplesoul/arenatransition/arenabullettrans1")
        for i=1,#arena.webs do arena.webs[i].y = arena.webs[i].y-85 end
        arenaCover2 = CreateSprite("purplesoul/arenaCover", "arenaLayerMan")
        arenaCover2.MoveToAbs(arena.arenaCover.absx, arena.arenaCover.absy)
        arenaCover2.SendToBottom()
        arenaCover3 = CreateSprite("purplesoul/arenaCoverSmall", "arenaLayerMan")
        arenaCover3.MoveToAbs(arena.arenaCover.absx, arena.arenaCover.absy+55)
        arenaCover3.SendToBottom()

        --Remove reveal vars
        arenaSpr2.Remove()
        revealPet.Remove()
        reveal = false

        petBul = CreateProjectileAbs("purplesoul/pet1/frame_000001 (41ms)", Arena.x, Arena.y+45)
        petBul.sprite.layer = "arenaLayerMan"
        petBul.sprite.SetParent(arena.parentSprite)
        petBul.SetVar("deadly", true)
        petBul.SetVar("damage", 4)
        petBul.ppcollision = true
      end

    --When the tilting arena is being built
    elseif not reveal then
      arena.playerSprite.MoveTo(Player.x+arena.sprite.x, Player.y+arena.sprite.y-85)
      arena.parentSprite.rotation = 5*math.sin(3*tiltTimer)
      if buildTimer > 1/30 and buildNum < 172 then
        buildTimer = buildTimer - 1/30

        --Change the arena's sprite
        arena.sprite.Set("purplesoul/arenatransition/arenabullettrans" .. buildNum)
        arena.sprite.rotation = 5*math.sin(3*tiltTimer)

        if arenaCover2.absy < arena.arenaCover.absy+140 then
          arenaCover2.absy = arenaCover2.absy+4
        else arenaCover2.absy = arena.arenaCover.absy+140 end

        if arenaCover3.absy < arena.arenaCover.absy+280 then
          arenaCover3.absy =  arenaCover3.absy+4
        else arenaCover3.absy = arena.arenaCover.absy+280 end

        if buildNum > buildThreshold then
          arena.AddWebBelowNoResize(tiltTimer)
          buildThreshold = buildThreshold + 40
        end

        --Move player, webs, and Muffet's sprite
        for i=1,#arena.websInvis do 
          arena.websInvis[i].absy = arena.websInvis[i].absy+4
          arena.webs[i].y = arena.webs[i].y+4
        end
        Player.MoveTo(Player.x, Player.y+4, true)
        Encounter.GetVar('muffet_legs').y = Encounter.GetVar('muffet_legs').y+4

        --Increment buildNum
        buildNum = buildNum + 4
      elseif buildNum >= 171 then
        --Set up for pet attack
        create = false
        pet = true
        websTransitioned = {}
        for i=1,#arena.websInvis do websTransitioned[i] = arena.websInvis[i].absy end
        arena.RemoveSprites()
        petBul.Remove()
        arenaCover2.Remove()
        arenaCover3.Remove()

        arena = psarn.PurpleArenaPet.new( {speed=2})
        arena.Create(tiltTimer, websTransitioned, petBite, petBiteIncrement, petSpriteNum, petIncrement, petMoveX, petSpriteTimer, petBiteTimer)
      end

      --Adjust pet sprite and send it to top of layer
      --The reason for this super complicated method is that the arena cannot hide sprites outside of it
      --I also did not want to go through the trouble of created a fake UI so this is the solution instead
      if buildNum > 120 and create then
        --Change sprite at 30fps for the majority of the time
        if petSpriteTimer > 1/30 then
          --Increment the number correctly
          if petSpriteNum >= 0 and petSpriteNum < 91 then
            petSpriteNum = petSpriteNum + petIncrement
          end
          --Change the increment if it reaches a bound
          if petSpriteNum == 90 then
            petIncrement = -2
          end
          --Build the sprite name
          if petSpriteNum < 10 then
            petSpriteString = "frame_00000"..petSpriteNum
          else
            petSpriteString = "frame_0000"..petSpriteNum
          end
        end
        petSpriteTimer = petSpriteTimer + Time.dt
        
        --Change the bite if needed
        if petBiteTimer > 0.35 then
          petBiteTimer = petBiteTimer - 0.35
          petBite = petBite + petBiteIncrement
          if petBite == 1 then
            petBiteIncrement = 1
          elseif petBite == 3 then
            petBiteIncrement = -1
          end
        end
        petBiteTimer = petBiteTimer + Time.dt

        --Set the sprite
        petBul.sprite.Set("purplesoul/pet" .. petBite .. "/" .. petSpriteString .. " (41ms)", Arena.x, Arena.y)
        petBul.MoveToAbs(Arena.x, Arena.y+45)
        petBul.sprite.MoveToAbs(Arena.x, Arena.y+45)
        petBul.sprite.rotation = 5*math.sin(3*tiltTimer)
        --Adjust the x value
        if petBul.absx < 9 and petBul.x > -9 then
          petBul.MoveTo(petBul.x+petMoveX, petBul.y)
        end
        --Change the x increment if it reaches a bound
        if petBul.absx > 9 then
          petMoveX = -petMoveX
        elseif petBul.absx < -9 then
          petMoveX = -petMoveX
        end
      end

      tiltTimer = tiltTimer + Time.dt
      buildTimer = buildTimer + Time.dt
    end
  end

  for i=1,#spiderManipulatableObj do
    if spiderManipulatableObj[i].spawned == false and (ourtime > spiderManipulatableObj[i].time) then
      spiderManipulatableObj[i].Create()
    end
    if spiderManipulatableObj[i].spawned then
      spiderManipulatableObj[i].Update()
    end
  end

  if ourtime > endwave then
    EndWave()
  end
end

function OnHit(bullet)
  if bullet.GetVar("deadly") then
    if not GetGlobal("payed") then
      Player.Hurt(bullet.GetVar("damage"))
    else
      Player.hurt(bullet.GetVar("damage")-1)
    end
  end
end

function EndingWave()
  SetGlobal("muffetDown", true)
  arena.RemoveSprites()
end