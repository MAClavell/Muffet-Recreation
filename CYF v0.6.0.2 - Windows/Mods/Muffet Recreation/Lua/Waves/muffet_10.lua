--Recreation of Muffet's third to last attack
ourtime = Time.time
endwave = ourtime+6.8

--Purple arena things
psarn = require "Libraries/purplesoularenas"
arena = psarn.PurpleArena.new( {numRows = 3})
arena.Create()
webs = arena.webs

--Purple bullets things
psbul = require "Libraries/purplesoulbullets"

spiderObj = {}
donutObj = {}
--Set 1
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/donutbullet", y=webs[2].y, side=true, speed=4, time=ourtime+1, spawned=false }))
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[3].y, side=true, speed=4, time=ourtime+1, spawned=false }))

--Set 2
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/donutbullet", y=webs[2].y, side=false, speed=4, time=ourtime+1.7, spawned=false }))
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[3].y, side=false, speed=4, time=ourtime+1.7, spawned=false }))

--Set 3
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/donutbullet", y=webs[2].y, side=true, speed=4, time=ourtime+2.4, spawned=false }))
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[1].y, side=true, speed=4, time=ourtime+2.4, spawned=false }))

--Set 4
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/donutbullet", y=webs[2].y, side=false, speed=4, time=ourtime+3.1, spawned=false }))
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[1].y, side=false, speed=4, time=ourtime+3.1, spawned=false }))

--Set 5
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[1].y, side=true, speed=4, time=ourtime+3.8, spawned=false }))
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[3].y, side=true, speed=4, time=ourtime+3.8, spawned=false }))

--Set 6
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[1].y, side=false, speed=4, time=ourtime+4.6, spawned=false }))
table.insert(donutObj, psbul.Donut.new( { sprite="purplesoul/donutbullet", squishSprite="purplesoul/donutbulletsquish",
  y=webs[3].y, side=false, speed=4, time=ourtime+4.6, spawned=false }))

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