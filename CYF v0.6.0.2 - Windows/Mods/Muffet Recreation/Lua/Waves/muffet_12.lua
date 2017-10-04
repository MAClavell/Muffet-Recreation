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
local t = 0
--Top and bot slow spiders
for i=1,5 do
	table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[1].y, side=false, speed=2.3, time=ourtime+t, spawned=false }))
	table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[3].y, side=false, speed=2.3, time=ourtime+t, spawned=false }))
	t = t+1
end
--Mid fast spiders
local b = 0.5
for i=1,5 do
	table.insert(spiderObj, psbul.Spider.new( { sprite="purplesoul/spiderbullet", y=webs[2].y, side=true, speed=4, time=ourtime+b, spawned=false }))
	b = b+1
end


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