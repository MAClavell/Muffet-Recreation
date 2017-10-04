--Recreation of Muffet's third to last attack
ourtime = Time.time
endwave = ourtime+8

--Purple arena things
psarn = require "Libraries/purplesoularenas"
arena = psarn.PurpleArena.new( {numRows = 3})
arena.Create()
webs = arena.webs

--Purple bullets things
psbul = require "Libraries/purplesoulbullets"

spiderObj = {}
donutObj = {}
croissantObj = {}
--Donuts
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[3].y, side=false, speed=3, time=ourtime+1, spawned=false }))
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[3].y, side=true, speed=3, time=ourtime+1, spawned=false }))
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[1].y, side=false, speed=3, time=ourtime+1, spawned=false }))
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[1].y, side=true, speed=3, time=ourtime+1, spawned=false }))

--Spiders
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[3].y, side=false, speed=5, time=ourtime+1.5, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[3].y, side=true, speed=5, time=ourtime+2, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[1].y, side=false, speed=5, time=ourtime+2.5, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[1].y, side=true, speed=5, time=ourtime+3, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[2].y, side=false, speed=5, time=ourtime+3.5, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[2].y, side=true, speed=5, time=ourtime+4, spawned=false }))

--Croissant
table.insert(croissantObj, psbul.Croissant.new( { sprite="purplesoul/croissantr", y=webs[2].y, side=true, time=ourtime+4.5, spawned=false }))

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