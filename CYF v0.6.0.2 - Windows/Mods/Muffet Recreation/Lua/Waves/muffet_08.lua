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

croissantObj = {}
--Set 1
table.insert(croissantObj, psbul.Croissant.new( { sprite="purplesoul/croissantr", y=webs[3].y, side=true, time=ourtime+1, spawned=false }))
table.insert(croissantObj, psbul.Croissant.new( { sprite="purplesoul/croissantr", y=webs[1].y, side=true, time=ourtime+1, spawned=false }))
table.insert(croissantObj, psbul.Croissant.new( { sprite="purplesoul/croissantr", y=webs[2].y, side=true, time=ourtime+2, spawned=false }))

--Set 2
table.insert(croissantObj, psbul.Croissant.new( { sprite="purplesoul/croissantr", y=webs[3].y, side=false, time=ourtime+2.5, spawned=false }))
table.insert(croissantObj, psbul.Croissant.new( { sprite="purplesoul/croissantr", y=webs[1].y, side=false, time=ourtime+2.5, spawned=false }))
table.insert(croissantObj, psbul.Croissant.new( { sprite="purplesoul/croissantr", y=webs[2].y, side=false, time=ourtime+3.5, spawned=false }))

function Update()
  ourtime = ourtime + Time.dt
  arena.Update()

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