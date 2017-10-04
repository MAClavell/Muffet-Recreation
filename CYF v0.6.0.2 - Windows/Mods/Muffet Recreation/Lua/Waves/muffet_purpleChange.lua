--Recreation of Muffet's second to last attack
ourtime = Time.time
endwave = ourtime+9.5
dropTime = ourtime + 1

--Wave vars
changed = false
timer = 0
drops = 0
tea = {}
teaPos = 0
level = 0
dropsL = {}
dropsR = {}
speeds = {}
acceleration = 0.015
--17 drops

--Resize the arena
Arena.ResizeImmediate(240, Arena.height)

--Purple arena things
psarn = require "Libraries/purplesoularenas"

function Update()
	ourtime = ourtime + Time.dt

	--Tilt kettles
	if not Encounter['tea'] then
		Encounter['tea'] = true
	end

	--Before the arena chances
	if not changed then
		--Slight delay at the start
		if ourtime > dropTime then
			--Create tea drops
			timer = timer + Time.dt
			if timer > 0.2 and drops < 18 then
				--Create left droplet
				local pourL = CreateSprite("purplesoul/spiderPourL", "BelowBullet")
				pourL.Scale(0.2, 0.2)
				pourL.MoveToAbs(Encounter['muffet_arm_middle_left_moving'].absx-35, Encounter['muffet_arm_middle_left_moving'].absy-40)
				table.insert(dropsL, pourL)

				--Create right droplet
				local pourR = CreateSprite("purplesoul/spiderPourR", "BelowBullet")
				pourR.Scale(0.2, 0.2)
				pourR.MoveToAbs(Encounter['muffet_arm_middle_right_moving'].absx+35, Encounter['muffet_arm_middle_right_moving'].absy-40)
				table.insert(dropsR, pourR)

				--Speeds table to control acceleration per teadrop
				table.insert(speeds, 0)

				--Add to drops value
				drops = drops+1

				--Reset timer
				timer = timer - 0.2
			end

			--Go through drops
			--Move, resize, and delete each
			--Left drops
			for i=1,#dropsL do
				local pour = dropsL[i]
				if pour.isactive then
					pour.absx = pour.absx + (speeds[i]*Time.mult)
					pour.absy = pour.absy - (3*Time.mult)
					pour.Scale(pour.xscale + (0.02*Time.mult), pour.xscale+(0.01*Time.mult))
					pour.rotation = -(pour.absy - 297)/7

					--Destroy teadrop if it reaches a certain point
					if pour.absy < Arena.y + 20 then
						pour.Remove()
						if level < 17 then
							IncreaseTeaLevel()
						end
					end
				end
			end

			--Right drops
			for i=1,#dropsR do
				local pour = dropsR[i]
				if pour.isactive then
					pour.absx = pour.absx - (speeds[i]*Time.mult)
					pour.absy = pour.absy - (3*Time.mult)
					pour.Scale(pour.xscale + (0.01*Time.mult), pour.xscale+(0.01*Time.mult))
					pour.rotation = (pour.absy - 297)/7

					--Destroy teadrop if it reaches a certain point
					if pour.absy < Arena.y + 20 then
						pour.Remove()
					end
				end
			end

			--Set speeds based on how far down the drop is
			for i=1,#speeds do
				--Set the new speed based off of acceleration
				speeds[i] = speeds[i] + acceleration
			end
		end

	--After arena changes
	elseif changed then
		arena.Update()
		timer = timer + Time.dt
		if timer > 1 then
			--Fade the tea level
			for i=1,#tea do
				tea[i].alpha = tea[i].alpha - (1/5)
			end
			timer = timer - 0.3
		end
	end

 	--End the wave if it is over the designated time
  	if ourtime > endwave then
    	EndWave()
  	end
end

--Add a new level to the purple tea
function IncreaseTeaLevel()
	local teaLevel = CreateSprite("purplesoul/tea", "Top")
	teaLevel.absx = Arena.x
	teaLevel.absy = Arena.y + 9 + teaPos

	--Special case cause the arena is resized weird. Thanks Toby
	if level == 16 then
		teaLevel.yscale = 0.2
		teaLevel.absy = Arena.y + 6 + teaPos
		ChangeArena()
	end
	teaPos = teaPos + 8
	level = level + 1
	table.insert(tea, teaLevel)
end

function ChangeArena()
	--Create the 
	changed = true
	timer = 0
	arena = psarn.PurpleArena.new( {numRows = 3})
	arena.Create()
	Player.MoveTo(0, 0, false)

	--Left drops
	for i=1,#dropsL do
		if dropsL[i].isactive then
			dropsL[i].Remove()
		end
	end

	--Right drops
	for i=1,#dropsR do
		if dropsR[i].isactive then
			dropsR[i].Remove()
		end
	end
end

function EndingWave()
  arena.RemoveSprites()
  for i=1,#tea do
  	tea[i].Remove()
  end
  Encounter['tea'] = false
  State("ENEMYDIALOGUE")
 end