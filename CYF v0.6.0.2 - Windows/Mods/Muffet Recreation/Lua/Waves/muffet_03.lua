--Recreation of Muffet's third to last attack
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
--Set 1
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[2].y, side=false, speed=4.5, time=ourtime+1, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[1].y, side=false, speed=4.5, time=ourtime+1, spawned=false }))

--Set 2
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[3].y, side=false, speed=4.5, time=ourtime+1.5, spawned=false }))

--Set 3
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[3].y, side=false, speed=4.5, time=ourtime+2, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[2].y, side=false, speed=4.5, time=ourtime+2, spawned=false }))

--Set 3
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[1].y, side=false, speed=4.5, time=ourtime+2.5, spawned=false }))

--Set 4
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[2].y, side=true, speed=4.5, time=ourtime+3, spawned=false }))

--Set 5
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[1].y, side=true, speed=4.5, time=ourtime+3.5, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[3].y, side=true, speed=4.5, time=ourtime+3.5, spawned=false }))

--Set 4
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[2].y, side=false, speed=4.5, time=ourtime+4, spawned=false }))

--Set 5
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[1].y, side=false, speed=4.5, time=ourtime+4.5, spawned=false }))
table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[3].y, side=false, speed=4.5, time=ourtime+4.5, spawned=false }))

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