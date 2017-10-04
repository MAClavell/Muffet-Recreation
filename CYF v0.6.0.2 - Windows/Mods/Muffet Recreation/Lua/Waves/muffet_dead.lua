--Wave for when the spider comes out with the telegram
ourtime = Time.time
start = ourtime+1.5
Player.SetControlOverride(true)

Arena.ResizeImmediate(565, 130)

cover = CreateSprite("purplesoul/soulCover", "BelowBullet")
cover.MoveToAbs(Player.absx, Player.absy)

spiderSpr = CreateSprite("purplesoul/battleSpider0")
spiderSpr.MoveToAbs(660, 245)

enter = true
flower = false
wait = 0
timer = 0

function Update()
	ourtime = ourtime + Time.dt

	if ourtime > start then

		--Spider enters without flower
		if not flower and enter then
			if spiderSpr.absx > 400 then
				spiderSpr.Set("PurpleSoul/BattleSpider" .. math.floor((Time.time / (1/7)) % 2))
				spiderSpr.absx = spiderSpr.absx-(1.5*Time.mult)
	  		elseif spiderSpr.absx > 360 then
	  			--Slow down
	  			spiderSpr.Set("PurpleSoul/BattleSpider" .. math.floor((Time.time / (1/4)) % 2))
				spiderSpr.absx = spiderSpr.absx-(0.5*Time.mult)
	  		elseif spiderSpr.absx <= 360 then
	  			spiderSpr.absx = 360
	  			spiderSpr.Set("purplesoul/battleSpider0")
	  			enter = false
	  		end

	  	--Spider exits without flower
	  	elseif not flower and not enter then
	  		if wait < 3 then
	  			wait = wait + Time.dt
	  		elseif spiderSpr.absx < 670 then
	  			spiderSpr.Set("PurpleSoul/BattleSpider" .. math.floor((Time.time / (1/10)) % 2))
				spiderSpr.absx = spiderSpr.absx+(3*Time.mult)
			elseif spiderSpr.absx >= 670 then
				wait = 0
				flowerSpr = CreateSprite("purplesoul/spider_flower")
				flowerSpr.Scale(2, 2)
				flowerSpr.MoveToAbs(spiderSpr.absx+2, spiderSpr.absy+16)
				flowerSpr.SetParent(spiderSpr)
				flower = true
				enter = true
			end


	  	--Spider enters with flower
	  	elseif flower and enter then
	  		if wait < 2 then
	  			wait = wait + Time.dt
	  		elseif spiderSpr.absx > 360 then 
	  			spiderSpr.Set("PurpleSoul/BattleSpider" .. math.floor((Time.time / (1/7)) % 2))
				spiderSpr.absx = spiderSpr.absx-(1.5*Time.mult)
			elseif spiderSpr.absx > 350 then
	  			spiderSpr.Set("PurpleSoul/BattleSpider" .. math.floor((Time.time / (1/7)) % 2))
				spiderSpr.absx = spiderSpr.absx-(1*Time.mult)
			elseif spiderSpr.absx > 345 then
				spiderSpr.Set("PurpleSoul/BattleSpider" .. math.floor((Time.time / (1/7)) % 2))
				spiderSpr.absx = spiderSpr.absx-(0.5*Time.mult)
			elseif spiderSpr.absx > 340 then
				spiderSpr.Set("PurpleSoul/BattleSpider" .. math.floor((Time.time / (1/7)) % 2))
				spiderSpr.absx = spiderSpr.absx-(0.2*Time.mult)	
	       	elseif spiderSpr.absx <= 340 then
	       		spiderSpr.absx = 340
	       		enter = false
	       		wait = 0
	       	end

	  	--Spider puts down the flower then exits
	  	elseif flower and not enter then
	  		if wait < 2 then
	  			wait = wait + Time.dt
	  		elseif wait < 4 then
	  			if timer > 1/15 then
	  				timer = timer-1/15
	  				flowerSpr.MoveToAbs(flowerSpr.absx-1.3, flowerSpr.absy-0.5)
	  			end
	  			timer = timer + Time.dt
	  			wait = wait + Time.dt
	  		elseif wait < 7 then
	  			wait = wait + Time.dt
	  		elseif spiderSpr.absx < 400 then
	  			spiderSpr.Set("PurpleSoul/BattleSpider" .. math.floor((Time.time / (1/7)) % 2))
				spiderSpr.absx = spiderSpr.absx+(1.5*Time.mult)
				flowerSpr.absx = flowerSpr.absx-(1.5*Time.mult)
			elseif wait < 9 then
				wait = wait + Time.dt
			elseif spiderSpr.absx < 650 then
				spiderSpr.Set("PurpleSoul/BattleSpider" .. math.floor((Time.time / (1/10)) % 2))
				spiderSpr.absx = spiderSpr.absx+(3*Time.mult)
				flowerSpr.absx = flowerSpr.absx-(3*Time.mult)
			elseif spiderSpr.absx >= 650 then
				EndWave()
			end
	  	end
	end
end

function OnHit(bullet)
end

function EndingWave()
	cover.Remove()
	BattleDialog({"YOU WON!\nYou earned 300 XP and " .. Encounter['enemies'][1].GetVar('gold') .. " gold.", "[func:State, DONE]"})
end