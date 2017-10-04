--Recreation of Muffet's second to last attack
ourtime = Time.time
endwave = ourtime+7

--Purple arena things
psarn = require "Libraries/purplesoularenas"
arena = psarn.PurpleArena.new( {numRows = 3})
arena.Create()
webs = arena.webs

--Purple bullets things
psbul = require "Libraries/purplesoulbullets"

spiderObj = {}
--stage2
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[1].y, side=false, speed=4, time=ourtime+1.5, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[3].y, side=false, speed=4, time=ourtime+1.5, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[1].y, side=true, speed=4, time=ourtime+1.5, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[3].y, side=true, speed=4, time=ourtime+1.5, spawned=false }))

table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[1].y, side=false, speed=4, time=ourtime+2, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[3].y, side=false, speed=4, time=ourtime+2, spawned=false }))

--stage3
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[2].y, side=true, speed=3.5, time=ourtime+3.5, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[2].y, side=false, speed=3.5, time=ourtime+3.5, spawned=false }))

donutObj = {}
--stage1
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[1].y, side=true, speed=4, time=ourtime+0.2, spawned=false }))
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish", 
  y=webs[3].y, side=false, speed=4, time=ourtime+0.2, spawned=false }))

--Use spider bullets but with the donut sprite (since these ones don't bounce)
table.insert(donutObj, psbul.Spider.new( { sprite="purplesoul/donutbullet", y=webs[2].y, side=false, speed=4, time=ourtime+0.2, spawned=false }))
table.insert(donutObj, psbul.Spider.new( { sprite="purplesoul/donutbullet", y=webs[2].y, side=true, speed=4, time=ourtime+0.2, spawned=false }))

croissantObj = {}
--stage3
table.insert(croissantObj, psbul.Croissant.new( { sprite="purplesoul/croissantr", y=webs[1].y, side=false, time=ourtime+3.1, spawned=false }))
table.insert(croissantObj, psbul.Croissant.new( { sprite="purplesoul/croissantr", y=webs[3].y, side=false, time=ourtime+3.3, spawned=false }))
table.insert(croissantObj, psbul.Croissant.new( { sprite="purplesoul/croissantl", y=webs[1].y, side=true, time=ourtime+3.2, spawned=false }))
table.insert(croissantObj, psbul.Croissant.new( { sprite="purplesoul/croissantl", y=webs[3].y, side=true, time=ourtime+3, spawned=false }))

function Update()
  ourtime = ourtime + Time.dt
  arena.Update()
  
  --spider bullets
  for i=1,#spiderObj do
    if spiderObj[i].spawned == false and (ourtime > spiderObj[i].time) then 
      spiderObj[i].Create()
    end
    if spiderObj[i].spawned then
      spiderObj[i].Update()
    end
  end

  --donut bullets
  for i=1,#donutObj do
    if donutObj[i].spawned == false and (ourtime > donutObj[i].time) then 
      donutObj[i].Create()
    end
    if donutObj[i].spawned then
      donutObj[i].Update()
    end
  end

  --croissant bullets
  for i=1,#croissantObj do
    if croissantObj[i].spawned == false and (ourtime > croissantObj[i].time) then 
      croissantObj[i].Create()
    end
    if croissantObj[i].spawned then
      croissantObj[i].Update()
    end
  end
  
  --[[Blink the heart at 15 fps if hurting
	local heartframe = 0
	if (Player.isHurting) then heartframe = math.floor((Time.time / (1/15)) % 2) end
	soulBullet.sprite.Set("purplesoul/soulBullet" .. heartframe)]]
  
  --End the wave if it is over the designated time
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
  arena.RemoveSprites()
end