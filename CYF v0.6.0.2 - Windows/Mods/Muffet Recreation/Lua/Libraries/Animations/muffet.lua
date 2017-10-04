--By Travroos (www.reddit.com/u/travoos)
--I added the eye animation but everything else is their's

--Vars
tea = false

-- Sprite creation
muffet_legs = CreateSprite("muffet/legs")
muffet_arm_bottom_left = CreateSprite("muffet/arm_bottom_left_in")
muffet_arm_bottom_right = CreateSprite("muffet/arm_bottom_right_in")
muffet_arm_middle_left_static = CreateSprite("muffet/arm_middle_left_static")
muffet_arm_middle_left_moving = CreateSprite("muffet/arm_middle_left_moving")
muffet_arm_middle_right_static = CreateSprite("muffet/arm_middle_right_static")
muffet_arm_middle_right_moving = CreateSprite("muffet/arm_middle_right_moving")
muffet_arm_top_left_static = CreateSprite("muffet/arm_top_left_static")
muffet_arm_top_left_moving = CreateSprite("muffet/arm_top_left_moving")
muffet_arm_top_right_static = CreateSprite("muffet/arm_top_right_static")
muffet_arm_top_right_moving = CreateSprite("muffet/arm_top_right_moving")
muffet_bow_left = CreateSprite("muffet/bow_left")
muffet_bow_right = CreateSprite("muffet/bow_right")
muffet_head = CreateSprite("muffet/head")
muffet_body = CreateSprite("muffet/body")
muffet_collar = CreateSprite("muffet/collar")
--Eyes added in by Michael
muffet_eye_big_left = CreateSprite("muffet/left_eyebig_0")
muffet_eye_big_right = CreateSprite("muffet/right_eyebig_0")
muffet_eye_med_left = CreateSprite("muffet/left_eyemed_0")
muffet_eye_med_right = CreateSprite("muffet/right_eyemed_0")
muffet_eye_cen = CreateSprite("muffet/eyecen_0")

-- Sprite scaling
muffet_legs.Scale(2, 2)
muffet_arm_bottom_left.Scale(2, 2)
muffet_arm_bottom_right.Scale(2, 2)
muffet_arm_middle_left_static.Scale(2, 2)
muffet_arm_middle_left_moving.Scale(2, 2)
muffet_arm_middle_right_static.Scale(2, 2)
muffet_arm_middle_right_moving.Scale(2, 2)
muffet_arm_top_left_static.Scale(2, 2)
muffet_arm_top_left_moving.Scale(2, 2)
muffet_arm_top_right_static.Scale(2, 2)
muffet_arm_top_right_moving.Scale(2, 2)
muffet_bow_left.Scale(2, 2)
muffet_bow_right.Scale(2, 2)
muffet_head.Scale(2, 2)
muffet_body.Scale(2, 2)
muffet_collar.Scale(2, 2)
--Eyes added by Michael
muffet_eye_big_left.Scale(2, 2)
muffet_eye_big_right.Scale(2, 2)
muffet_eye_med_left.Scale(2, 2)
muffet_eye_med_right.Scale(2, 2)
muffet_eye_cen.Scale(2, 2)

-- Sprite pivot
muffet_arm_bottom_left.SetPivot(1, 1)
muffet_arm_bottom_right.SetPivot(0, 1)
muffet_arm_middle_left_moving.SetPivot(1, 0.5)
muffet_arm_middle_right_moving.SetPivot(0, 0.5)
muffet_arm_top_left_moving.SetPivot(1, 0)
muffet_arm_top_right_moving.SetPivot(0, 0)

-- Sprite parenting
muffet_arm_bottom_left.SetParent(muffet_legs)
muffet_arm_bottom_right.SetParent(muffet_legs)
muffet_arm_middle_left_static.SetParent(muffet_legs)
muffet_arm_middle_left_moving.SetParent(muffet_arm_middle_left_static)
muffet_arm_middle_right_static.SetParent(muffet_legs)
muffet_arm_middle_right_moving.SetParent(muffet_arm_middle_right_static)
muffet_arm_top_left_static.SetParent(muffet_legs)
muffet_arm_top_left_moving.SetParent(muffet_arm_top_left_static)
muffet_arm_top_right_static.SetParent(muffet_legs)
muffet_arm_top_right_moving.SetParent(muffet_arm_top_right_static)
muffet_bow_left.SetParent(muffet_legs)
muffet_bow_right.SetParent(muffet_legs)
muffet_head.SetParent(muffet_legs)
muffet_body.SetParent(muffet_legs)
muffet_collar.SetParent(muffet_legs)
--Eyes added by Michael
muffet_eye_big_left.SetParent(muffet_head)
muffet_eye_big_right.SetParent(muffet_head)
muffet_eye_med_left.SetParent(muffet_head)
muffet_eye_med_right.SetParent(muffet_head)
muffet_eye_cen.SetParent(muffet_head)

-- Sprite positioning
muffet_legs.MoveTo(320, 260)
function DefaultPositions()
	muffet_arm_bottom_left.MoveTo(-19, 55)
	muffet_arm_bottom_right.MoveTo(19, 55)
	muffet_arm_middle_left_static.MoveTo(-38, 62)
	muffet_arm_middle_left_moving.MoveTo(-21, 14)
	muffet_arm_middle_right_static.MoveTo(38, 62)
	muffet_arm_middle_right_moving.MoveTo(21, 14)
	muffet_arm_top_left_static.MoveTo(-18, 81)
	muffet_arm_top_left_moving.MoveTo(-13, -11)
	muffet_arm_top_right_static.MoveTo(20, 81)
	muffet_arm_top_right_moving.MoveTo(13, -11)
	muffet_bow_left.MoveTo(-45, 160)
	muffet_bow_right.MoveTo(47, 160)
	muffet_head.MoveTo(1, 131)
	muffet_body.MoveTo(0, 45)
	muffet_collar.MoveTo(1, 77)
	--Eyes added by Michael
	muffet_eye_big_left.MoveTo(-15, 2)
	muffet_eye_big_right.MoveTo(15, 2)
	muffet_eye_med_left.MoveTo(-11, 16)
	muffet_eye_med_right.MoveTo(11, 16)
	muffet_eye_cen.MoveTo(0, 22)
end
DefaultPositions()

muffet_animated = true
eye_timer = 0
anim = 0

function UpdateMuffet()
	if muffet_animated then
		muffet_arm_bottom_left.Scale(2, 2)
		muffet_arm_top_left_static.MoveTo(-18, 81 + (math.cos((Time.time + 0.2) * 6) * 1))
		muffet_arm_top_right_static.MoveTo(20, 81 + (math.cos((Time.time + 0.2) * 6) * 1))
		muffet_arm_bottom_left.MoveTo(-19, 55 + (math.cos(Time.time * 6) * 1))
		muffet_arm_bottom_right.MoveTo(19, 55 + (math.cos(Time.time * 6) * 1))
		muffet_body.MoveTo(0,45 + (math.cos(Time.time * 6) * 1))
		muffet_collar.MoveTo(1,77 + (math.cos(Time.time*6) * 2))
		muffet_head.MoveTo(1, 131 + (math.cos(Time.time * 6) * 3))
		muffet_arm_bottom_left.rotation = -10 + math.cos(Time.time * 6) * -10
		muffet_arm_bottom_right.rotation = 10 + math.cos(Time.time * 6) * 10
		muffet_arm_top_left_moving.rotation = math.cos(Time.time * 6) * 6
		muffet_arm_top_right_moving.rotation = math.cos(Time.time * 6) * -6
		muffet_bow_left.rotation = math.cos(Time.time * 6) * 25
		muffet_bow_right.rotation = math.cos(Time.time * 6) * -25

		if not tea then
			MiddleArmUpdate()
		elseif tea then
			MuffetTeaDropUpdate()
		end

		if(muffet_arm_bottom_left.rotation < 350 and muffet_arm_bottom_left.rotation > 300) then
			muffet_arm_bottom_left.Set("muffet/arm_bottom_left_out")
		else
			muffet_arm_bottom_left.Set("muffet/arm_bottom_left_in")
		end
		if(muffet_arm_bottom_right.rotation > 10 and muffet_arm_bottom_right.rotation < 50) then
			muffet_arm_bottom_right.Set("muffet/arm_bottom_right_out")
		else
			muffet_arm_bottom_right.Set("muffet/arm_bottom_right_in")
		end

		--Eye animation added by Michael
		if anim == 0 then
			if eye_timer == 0 then
				muffet_eye_big_left.Set("muffet/left_eyebig_1")
			elseif eye_timer < 0.05 then
				muffet_eye_big_left.Set("muffet/left_eyebig_2")
			elseif eye_timer < 0.1 then
				muffet_eye_big_left.Set("muffet/left_eyebig_3")
			elseif eye_timer < 0.15 then
				muffet_eye_med_left.Set("muffet/left_eyemed_1")
			elseif eye_timer < 0.2 then
				muffet_eye_med_left.Set("muffet/left_eyemed_2")
			elseif eye_timer < 0.25 then
				muffet_eye_med_left.Set("muffet/left_eyemed_3")
			elseif eye_timer < 0.3 then
				muffet_eye_big_left.Set("muffet/left_eyebig_2")
				muffet_eye_cen.Set("muffet/eyecen_1")
			elseif eye_timer < 0.35 then
				muffet_eye_big_left.Set("muffet/left_eyebig_1")
				muffet_eye_cen.Set("muffet/eyecen_2")
			elseif eye_timer < 0.4 then
				muffet_eye_big_left.Set("muffet/left_eyebig_0")
				muffet_eye_cen.Set("muffet/eyecen_3")
			elseif eye_timer < 0.45 then
				muffet_eye_med_left.Set("muffet/left_eyemed_2")
				muffet_eye_med_right.Set("muffet/right_eyemed_1")
			elseif eye_timer < 0.5 then
				muffet_eye_med_left.Set("muffet/left_eyemed_1")
				muffet_eye_med_right.Set("muffet/right_eyemed_2")
			elseif eye_timer < 0.55 then
				muffet_eye_med_left.Set("muffet/left_eyemed_0")
				muffet_eye_med_right.Set("muffet/right_eyemed_3")
			elseif eye_timer < 0.6 then
				muffet_eye_cen.Set("muffet/eyecen_2")
				muffet_eye_big_right.Set("muffet/right_eyebig_1")
			elseif eye_timer < 0.65 then
				muffet_eye_cen.Set("muffet/eyecen_1")
				muffet_eye_big_right.Set("muffet/right_eyebig_2")
			elseif eye_timer < 0.7 then
				muffet_eye_cen.Set("muffet/eyecen_0")
				muffet_eye_big_right.Set("muffet/right_eyebig_3")
			elseif eye_timer < 0.75 then
				muffet_eye_med_right.Set("muffet/right_eyemed_2")
			elseif eye_timer < 0.8 then
				muffet_eye_med_right.Set("muffet/right_eyemed_1")
			elseif eye_timer < 0.85 then
				muffet_eye_med_right.Set("muffet/right_eyemed_0")
			elseif eye_timer < 0.9 then
				muffet_eye_big_right.Set("muffet/right_eyebig_2")
			elseif eye_timer < 0.95 then
				muffet_eye_big_right.Set("muffet/right_eyebig_1")
			elseif eye_timer < 1 then
				muffet_eye_big_right.Set("muffet/right_eyebig_0")
			end
			eye_timer = eye_timer + Time.dt

		--Wait
		elseif anim == 1 then
			eye_timer = eye_timer + Time.dt

		--All eyes close at once
		elseif anim == 2 then
			if eye_timer < 0.1 then
				SetEyes(1)
			elseif eye_timer < 0.15 then
				SetEyes(2)
			elseif eye_timer < 0.6 then
				SetEyes(3)
			elseif eye_timer < 0.65 then
				SetEyes(2)
			elseif eye_timer < 0.7 then
				SetEyes(1)
			elseif eye_timer < 0.75 then
				SetEyes(0)
			end
			eye_timer = eye_timer + Time.dt

		--Wait
		elseif anim == 3 then
			eye_timer = eye_timer + Time.dt
		end

		--Update which eye animation to play
		if eye_timer > 1 then
			eye_timer = eye_timer - 1
			if anim == 3 then
				anim = 0
			else 
				anim = anim+1
			end
		end
	end
end

--Update the middle arms
--Used for control during tea pouring wave
--By Michael
function MiddleArmUpdate()
	muffet_arm_middle_left_static.MoveTo(-38, 62 + (math.cos((Time.time + 0.3) * 6) * 2))
	muffet_arm_middle_right_static.MoveTo(38, 62 + (math.cos((Time.time + 0.3) * 6) * 2))
	muffet_arm_middle_left_moving.rotation = math.cos(Time.time * 6) * 20
	muffet_arm_middle_right_moving.rotation = math.cos(Time.time * 6) * 20
end

--Update to point the tea kettles downwards
--By Michael
function MuffetTeaDropUpdate()
	--Left arm
	if muffet_arm_middle_left_moving.rotation < 37 or muffet_arm_middle_left_moving.rotation > 43 then
		muffet_arm_middle_left_moving.rotation = muffet_arm_middle_left_moving.rotation+2
	end

	--Right arm
	if muffet_arm_middle_right_moving.rotation < 317 or muffet_arm_middle_right_moving.rotation > 323 then
		muffet_arm_middle_right_moving.rotation = muffet_arm_middle_right_moving.rotation-2
	end
end

--A transition animation for Muffet
--Sets her to almost exactly the default position
--By Michael
function TransitionMuffet()
	if eye_timer < 0.2 then
	elseif eye_timer < 0.25 then
		SetEyes(1)
	elseif eye_timer < 0.3 then
		SetEyes(2)
	elseif eye_timer < 0.35 then
		SetEyes(3)
	end
	eye_timer = eye_timer + Time.dt


	--Body
	if muffet_body.y > 46 then
		muffet_body.MoveTo(0, muffet_body.y-0.5)
	elseif muffet_head.y < 44 then
		muffet_body.MoveTo(0, muffet_body.y+0.5)
	end

	--Collar
	if muffet_collar.y > 78 then
		muffet_collar.MoveTo(1, muffet_collar.y-0.5)
	elseif muffet_collar.y < 76 then
		muffet_collar.MoveTo(1, muffet_collar.y+0.5)
	end

	--Head
	if muffet_head.y > 132 then
		muffet_head.MoveTo(1, muffet_head.y-0.5)
	elseif muffet_head.y < 130 then
		muffet_head.MoveTo(1, muffet_head.y+0.5)
	end

	--Bow
	if muffet_bow_left.rotation > 334 then
		muffet_bow_left.rotation = muffet_bow_left.rotation+0.5
	elseif muffet_bow_left.rotation > 1 then
		muffet_bow_left.rotation = muffet_bow_left.rotation-0.5
	else
		muffet_bow_left.rotation = 0
	end

	if muffet_bow_right.rotation > 334 then
		muffet_bow_right.rotation = muffet_bow_right.rotation+0.5
	elseif muffet_bow_right.rotation > 1 then
		muffet_bow_right.rotation = muffet_bow_right.rotation-0.5
	else
		muffet_bow_right.rotation = 0
	end

	--Static top arm things
	if muffet_arm_top_left_static.y > 82 then
		muffet_arm_top_left_static.MoveTo(-18, muffet_arm_top_left_static.y-0.5)
	elseif muffet_arm_top_left_static.y < 80 then
		muffet_arm_top_left_static.MoveTo(-18, muffet_arm_top_left_static.y+0.5)
	end

	if muffet_arm_top_right_static.y > 82 then
		muffet_arm_top_right_static.MoveTo(20, muffet_arm_top_right_static.y-0.5)
	elseif muffet_arm_top_right_static.y < 80 then
		muffet_arm_top_right_static.MoveTo(20, muffet_arm_top_right_static.y+0.5)
	end

	--Moving top arm things
	if muffet_arm_top_left_moving.rotation > 353 then
		muffet_arm_top_left_moving.rotation = muffet_arm_top_left_moving.rotation+0.5
	elseif muffet_arm_top_left_moving.rotation > 1 then
		muffet_arm_top_left_moving.rotation = muffet_arm_top_left_moving.rotation-0.5
	else
		muffet_arm_top_left_moving.rotation = 0
	end

	if muffet_arm_top_right_moving.rotation > 353 then
		muffet_arm_top_right_moving.rotation = muffet_arm_top_right_moving.rotation+0.5
	elseif muffet_arm_top_right_moving.rotation > 1 then
		muffet_arm_top_right_moving.rotation = muffet_arm_top_right_moving.rotation-0.5
	else
		muffet_arm_top_right_moving.rotation = 0
	end

	--Static middle arm things
	if muffet_arm_middle_left_static.y > 63 then
		muffet_arm_middle_left_static.MoveTo(-38, muffet_arm_middle_left_static.y-0.5)
	elseif muffet_arm_middle_left_static.y < 61 then
		muffet_arm_middle_left_static.MoveTo(-38, muffet_arm_middle_left_static.y+0.5)
	end

	if muffet_arm_middle_right_static.y > 63 then
		muffet_arm_middle_right_static.MoveTo(38, muffet_arm_middle_right_static.y-0.5)
	elseif muffet_arm_middle_right_static.y < 61 then
		muffet_arm_middle_right_static.MoveTo(38, muffet_arm_middle_right_static.y+0.5)
	end

	--Moving middle arm things
	if muffet_arm_middle_left_moving.rotation > 339 then
		muffet_arm_middle_left_moving.rotation = muffet_arm_middle_left_moving.rotation+0.5
	elseif muffet_arm_middle_left_moving.rotation > 1 then
		muffet_arm_middle_left_moving.rotation = muffet_arm_middle_left_moving.rotation-0.5
	else
		muffet_arm_middle_left_moving.rotation = 0
	end

	if muffet_arm_middle_right_moving.rotation > 339 then
		muffet_arm_middle_right_moving.rotation = muffet_arm_middle_right_moving.rotation+0.5
	elseif muffet_arm_middle_right_moving.rotation > 1 then
		muffet_arm_middle_right_moving.rotation = muffet_arm_middle_right_moving.rotation-0.5
	else
		muffet_arm_middle_right_moving.rotation = 0
	end

	--Bottom arm things
	if muffet_arm_bottom_left.y > 56 then
		muffet_arm_bottom_left.MoveTo(-19, muffet_arm_bottom_left.y-0.5)
	elseif muffet_arm_bottom_left.y < 54 then
		muffet_arm_bottom_left.MoveTo(-19, muffet_arm_bottom_left.y+0.5)
	end

	if muffet_arm_bottom_right.y > 56 then
		muffet_arm_bottom_right.MoveTo(19, muffet_arm_bottom_right.y-0.5)
	elseif muffet_arm_bottom_right.y < 54 then
		muffet_arm_bottom_right.MoveTo(19, muffet_arm_bottom_right.y+0.5)
	end

	if muffet_arm_bottom_left.rotation > 1 and muffet_arm_bottom_left.rotation < 359 then
		muffet_arm_bottom_left.rotation = muffet_arm_bottom_left.rotation+0.5
	else
		muffet_arm_bottom_left.rotation = 0
	end

	if muffet_arm_bottom_right.rotation > 1 and muffet_arm_bottom_right.rotation < 359 then
		muffet_arm_bottom_right.rotation = muffet_arm_bottom_right.rotation-0.5
	else
		muffet_arm_bottom_right.rotation = 0
	end

	if(muffet_arm_bottom_left.rotation < 350 and muffet_arm_bottom_left.rotation > 300) then
		muffet_arm_bottom_left.Set("muffet/arm_bottom_left_out")
	else
		muffet_arm_bottom_left.Set("muffet/arm_bottom_left_in")
	end

	if(muffet_arm_bottom_right.rotation > 10 and muffet_arm_bottom_right.rotation < 50) then
		muffet_arm_bottom_right.Set("muffet/arm_bottom_right_out")
	else
		muffet_arm_bottom_right.Set("muffet/arm_bottom_right_in")
	end
end


-----------------------------------------------------------
-----------------------------------------------------------
--Below is a new animation for muffet. It works as long as
--you create it and update it
-----------------------------------------------------------
-----------------------------------------------------------


--Create new sprites for the new animation
function CreateNewMuffet()
	DefaultPositions()
	--Remove old sprites
	muffet_arm_middle_left_static.Remove()
	muffet_arm_middle_left_moving.Remove()
	muffet_arm_middle_right_static.Remove()
	muffet_arm_middle_right_moving.Remove()

	muffet_head.Remove()
	muffet_bow_left.Remove()
	muffet_bow_right.Remove()

	muffet_eye_cen.Remove()
	muffet_eye_big_left.Remove()
	muffet_eye_big_right.Remove()
	muffet_eye_med_left.Remove()
	muffet_eye_med_right.Remove()

	--Create new sprites
	muffet_head_back = CreateSprite("muffet/NewAnim/head_transparent")
	muffet_head = CreateSprite("muffet/head")
	muffet_bow_left = CreateSprite("muffet/bow_left")
	muffet_bow_right = CreateSprite("muffet/bow_right")

	muffet_eye_big_left = CreateSprite("muffet/left_eyebig_0")
	muffet_eye_big_right = CreateSprite("muffet/right_eyebig_0")
	muffet_eye_med_left = CreateSprite("muffet/left_eyemed_0")
	muffet_eye_med_right = CreateSprite("muffet/right_eyemed_0")
	muffet_eye_cen = CreateSprite("muffet/eyecen_0")

	muffet_arm_middle_left_static = CreateSprite("muffet/NewAnim/arm_middle_left_static_new")
	muffet_arm_middle_left_moving = CreateSprite("muffet/NewAnim/arm_middle_left_moving_new")
	muffet_arm_middle_left_pot = CreateSprite("muffet/arm_middle_left_moving")
	muffet_arm_middle_right_static = CreateSprite("muffet/NewAnim/arm_middle_right_static_new")
	muffet_arm_middle_right_moving = CreateSprite("muffet/NewAnim/arm_middle_right_moving_new")
	muffet_arm_middle_right_pot = CreateSprite("muffet/arm_middle_right_moving")

	--Scale new sprites
	muffet_head_back.Scale(2, 2)
	muffet_head.Scale(2, 2)
	muffet_bow_left.Scale(2, 2)
	muffet_bow_right.Scale(2, 2)
	muffet_arm_middle_left_static.Scale(2, 2)
	muffet_arm_middle_left_moving.Scale(2, 2)
	muffet_arm_middle_left_pot.Scale(2, 2)
	muffet_arm_middle_right_static.Scale(2, 2)
	muffet_arm_middle_right_moving.Scale(2, 2)
	muffet_arm_middle_right_pot.Scale(2, 2)
	muffet_eye_big_left.Scale(2, 2)
	muffet_eye_big_right.Scale(2, 2)
	muffet_eye_med_left.Scale(2, 2)
	muffet_eye_med_right.Scale(2, 2)
	muffet_eye_cen.Scale(2, 2)

	--Set pivots for new sprites
	muffet_arm_middle_left_static.SetPivot(1, 9/13)
	muffet_arm_middle_right_static.SetPivot(0, 9/13)
	muffet_arm_middle_left_moving.SetPivot(1, 2/13)
	muffet_arm_middle_left_pot.SetPivot(1, 8/15)
	muffet_arm_middle_right_moving.SetPivot(0, 2/13)
	muffet_arm_middle_right_pot.SetPivot(0, 8/15)
	muffet_head.SetPivot(0.5, 0)
	muffet_head_back.SetPivot(0.5, 0)

	--Manage layers
	muffet_head_back.SetParent(muffet_legs)
	muffet_head_back.SendToBottom()

	--Layer new sprites
	muffet_arm_top_left_static.SendToBottom()
	muffet_arm_top_right_static.SendToBottom()

	--Set new parents
	muffet_bow_right.SetParent(muffet_head_back)
	muffet_bow_left.SetParent(muffet_head_back)
	muffet_head.SetParent(muffet_head_back)
	muffet_eye_cen.SetParent(muffet_head)
	muffet_eye_big_left.SetParent(muffet_head)
	muffet_eye_big_right.SetParent(muffet_head)
	muffet_eye_med_left.SetParent(muffet_head)
	muffet_eye_med_right.SetParent(muffet_head)
	muffet_arm_middle_left_static.SetParent(muffet_legs)
	muffet_arm_middle_left_moving.SetParent(muffet_arm_middle_left_static)
	muffet_arm_middle_left_pot.SetParent(muffet_arm_middle_left_moving)
	muffet_arm_middle_right_static.SetParent(muffet_legs)
	muffet_arm_middle_right_moving.SetParent(muffet_arm_middle_right_static)
	muffet_arm_middle_right_pot.SetParent(muffet_arm_middle_right_moving)

	muffet_arm_middle_left_static.SendToBottom()
	muffet_arm_middle_right_static.SendToBottom()

end
--CreateNewMuffet()

--Default positions for Muffet's new animation
function DefaultPositionsNew()
	muffet_legs.MoveTo(320, 260)
	muffet_arm_bottom_left.MoveTo(-19, 55)
	muffet_arm_bottom_right.MoveTo(19, 55)
	muffet_arm_middle_left_static.MoveTo(-17, 67)
	muffet_arm_middle_left_moving.MoveTo(-5, -9)
	muffet_arm_middle_left_pot.MoveTo(-14, 15)
	muffet_arm_middle_right_static.MoveTo(17, 67)
	muffet_arm_middle_right_moving.MoveTo(5, -9)
	muffet_arm_middle_right_pot.MoveTo(14, 15)
	muffet_arm_top_left_static.MoveTo(-18, 81)
	muffet_arm_top_left_moving.MoveTo(-13, -11)
	muffet_arm_top_right_static.MoveTo(20, 81)
	muffet_arm_top_right_moving.MoveTo(13, -11)
	muffet_bow_left.MoveTo(-46, 29) --30
	muffet_bow_right.MoveTo(46, 29)
	muffet_head_back.MoveTo(1, 79)
	muffet_head.MoveTo(0, -52)
	muffet_body.MoveTo(0, 45)
	muffet_collar.MoveTo(1, 77)
	muffet_eye_big_left.MoveTo(-15, 2)
	muffet_eye_big_right.MoveTo(15, 2)
	muffet_eye_med_left.MoveTo(-11, 16)
	muffet_eye_med_right.MoveTo(11, 16)
	muffet_eye_cen.MoveTo(0, 22)
	anim = 3
end
--DefaultPositionsNew()


--Muffet's new animation
--By Michael
animTimer = 0
function UpdateMuffetNew()
	if muffet_animated then
		--muffet_arm_middle_left_moving.SetPivot(1, 9/15)

		muffet_arm_top_left_static.MoveTo(-18, 81 + (math.sin((animTimer + 0.2) * 6) * 1))
		muffet_arm_top_right_static.MoveTo(20, 81 + (math.sin((animTimer + 0.2) * 6) * 1))
		muffet_arm_middle_left_static.MoveTo(-17, 67 + (math.sin((animTimer + 0.3) * 6) * 2))
		muffet_arm_middle_right_static.MoveTo(17, 67 + (math.sin((animTimer + 0.3) * 6) * 2))
		muffet_arm_bottom_left.MoveTo(-19, 55 + (math.sin(animTimer * 6) * 1))
		muffet_arm_bottom_right.MoveTo(19, 55 + (math.sin(animTimer * 6) * 1))
		muffet_body.MoveTo(0,45 + (math.sin(animTimer * 6) * 1))
		muffet_collar.MoveTo(1,77 + (math.sin(animTimer*6) * 2))
		muffet_head_back.MoveTo(1, 79 + (math.sin(animTimer * 6) * 3))
		muffet_head.MoveTo(0, -52)

		muffet_arm_bottom_left.rotation = -10 + math.sin(animTimer * 6) * -10
		muffet_arm_bottom_right.rotation = 10 + math.sin(animTimer * 6) * 10
		muffet_arm_middle_left_static.rotation = -10 + math.sin(-animTimer * 3) * 5
		muffet_arm_middle_left_moving.rotation = math.sin(animTimer * 3) * 10
		muffet_arm_middle_left_pot.rotation = -math.sin(animTimer * 3) * 15
		muffet_arm_middle_right_static.rotation = 10 + math.sin(-animTimer * 3) * 5
		muffet_arm_middle_right_moving.rotation = -math.sin(-animTimer * 3) * 10
		muffet_arm_middle_right_pot.rotation = math.sin(-animTimer * 3) * 15
		muffet_arm_top_left_static.rotation = -math.sin(-animTimer * 3) * 4
		muffet_arm_top_right_static.rotation = math.sin(animTimer * 3) * 4
		muffet_arm_top_left_moving.rotation = math.sin(animTimer * 6) * 6
		muffet_arm_top_right_moving.rotation = math.sin(animTimer * 6) * -6
		muffet_bow_left.rotation = math.sin(animTimer * 6) * 25
		muffet_bow_right.rotation = math.sin(animTimer * 6) * -25
		muffet_head_back.rotation =  math.sin(animTimer*3)*5

		if(muffet_arm_bottom_left.rotation < 350 and muffet_arm_bottom_left.rotation > 300) then
			muffet_arm_bottom_left.Set("muffet/arm_bottom_left_out")
		else
			muffet_arm_bottom_left.Set("muffet/arm_bottom_left_in")
		end
		if(muffet_arm_bottom_right.rotation > 10 and muffet_arm_bottom_right.rotation < 50) then
			muffet_arm_bottom_right.Set("muffet/arm_bottom_right_out")
		else
			muffet_arm_bottom_right.Set("muffet/arm_bottom_right_in")
		end
		animTimer = animTimer+Time.dt

		--Wait
		if anim == 0 then
			eye_timer = eye_timer + Time.dt

		--Eyes close in a pattern
		elseif anim == 1 then

			if eye_timer == 0 then
				muffet_eye_big_left.Set("muffet/left_eyebig_1")
				muffet_eye_big_right.Set("muffet/right_eyebig_1")
			elseif eye_timer < 0.05 then
				muffet_eye_big_left.Set("muffet/left_eyebig_2")
				muffet_eye_big_right.Set("muffet/right_eyebig_2")
			elseif eye_timer < 0.1 then
				muffet_eye_big_left.Set("muffet/left_eyebig_3")
				muffet_eye_big_right.Set("muffet/right_eyebig_3")
			elseif eye_timer < 0.15 then
				muffet_eye_med_left.Set("muffet/left_eyemed_1")
				muffet_eye_med_right.Set("muffet/right_eyemed_1")
			elseif eye_timer < 0.2 then
				muffet_eye_med_left.Set("muffet/left_eyemed_2")
				muffet_eye_med_right.Set("muffet/right_eyemed_2")
			elseif eye_timer < 0.25 then
				muffet_eye_med_left.Set("muffet/left_eyemed_3")
				muffet_eye_med_right.Set("muffet/right_eyemed_3")
			elseif eye_timer < 0.3 then
				muffet_eye_big_left.Set("muffet/left_eyebig_2")
				muffet_eye_big_right.Set("muffet/right_eyebig_2")
				muffet_eye_cen.Set("muffet/eyecen_1")
			elseif eye_timer < 0.35 then
				muffet_eye_big_left.Set("muffet/left_eyebig_1")
				muffet_eye_big_right.Set("muffet/right_eyebig_1")
				muffet_eye_cen.Set("muffet/eyecen_2")
			elseif eye_timer < 0.4 then
				muffet_eye_big_left.Set("muffet/left_eyebig_0")
				muffet_eye_big_right.Set("muffet/right_eyebig_0")
				muffet_eye_cen.Set("muffet/eyecen_3")
			elseif eye_timer < 0.45 then
				muffet_eye_med_left.Set("muffet/left_eyemed_2")
				muffet_eye_med_right.Set("muffet/right_eyemed_2")
			elseif eye_timer < 0.5 then
				muffet_eye_med_left.Set("muffet/left_eyemed_1")
				muffet_eye_med_right.Set("muffet/right_eyemed_1")
			elseif eye_timer < 0.55 then
				muffet_eye_med_left.Set("muffet/left_eyemed_0")
				muffet_eye_med_right.Set("muffet/right_eyemed_0")
			elseif eye_timer < 0.6 then
				muffet_eye_cen.Set("muffet/eyecen_2")
			elseif eye_timer < 0.65 then
				muffet_eye_cen.Set("muffet/eyecen_1")
			elseif eye_timer < 0.7 then
				muffet_eye_cen.Set("muffet/eyecen_0")
			end
			eye_timer = eye_timer + Time.dt

		--Wait
		elseif anim == 2 then
			eye_timer = eye_timer + Time.dt

		--All eyes close at once
		elseif anim == 3 then
			if eye_timer < 0.1 then
				SetEyes(1)
			elseif eye_timer < 0.15 then
				SetEyes(2)
			elseif eye_timer < 0.6 then
				SetEyes(3)
			elseif eye_timer < 0.65 then
				SetEyes(2)
			elseif eye_timer < 0.7 then
				SetEyes(1)
			elseif eye_timer < 0.75 then
				SetEyes(0)
			end
			eye_timer = eye_timer + Time.dt
		end

		--Update which eye animation to play
		if eye_timer > 1 then
			eye_timer = eye_timer - 1
			if anim == 3 then
				anim = 0
			else 
				anim = anim+1
			end
		end
	end
end


--Sets all eyes to a specific number
--By Michael
function SetEyes(num)
	muffet_eye_big_left.Set("muffet/left_eyebig_"..num)
	muffet_eye_big_right.Set("muffet/right_eyebig_"..num)
	muffet_eye_med_left.Set("muffet/left_eyemed_"..num)
	muffet_eye_med_right.Set("muffet/right_eyemed_"..num)
	muffet_eye_cen.Set("muffet/eyecen_"..num)
end

--Sets all eyes to the hurt version
--By Michael
function SetHurtEyes()
	muffet_eye_big_left.Set("muffet/left_eyebig_hurt")
	muffet_eye_big_right.Set("muffet/right_eyebig_hurt")
	muffet_eye_med_left.Set("muffet/left_eyemed_hurt")
	muffet_eye_med_right.Set("muffet/right_eyemed_hurt")
	muffet_eye_cen.Set("muffet/eyecen_hurt")
end

--Move Muffet sprite
--By Michael
function MoveMuffet(speed, target, lessthan)
	if lessthan and muffet_legs.absy > target then
		muffet_legs.MoveTo(muffet_legs.x, muffet_legs.y-speed)
	elseif not lessthan and muffet_legs.absy < target then
		muffet_legs.MoveTo(muffet_legs.x, muffet_legs.y-speed)
	end
end

--Remove Muffet's sprite
--By Michael
function RemoveMuffet()
	--Remove eyes
	muffet_eye_big_left.Remove()
	muffet_eye_big_right.Remove()
	muffet_eye_med_left.Remove()
	muffet_eye_med_right.Remove()
	muffet_eye_cen.Remove()

	--Remove children of not legs
	muffet_arm_middle_left_moving.Remove()
	muffet_arm_top_left_moving.Remove()
	muffet_arm_middle_right_moving.Remove()
	muffet_arm_top_right_moving.Remove()

	--Remove children of legs
	muffet_arm_middle_left_static.Remove()
	muffet_arm_top_left_static.Remove()
	muffet_arm_middle_right_static.Remove()
	muffet_arm_top_right_static.Remove()
	muffet_arm_bottom_left.Remove()
	muffet_arm_bottom_right.Remove()
	muffet_bow_left.Remove()
	muffet_bow_right.Remove()
	muffet_head.Remove()
	muffet_body.Remove()
	muffet_collar.Remove()

	--Remove legs
	muffet_legs.Remove()
end

--Set all of Muffet's sprite to a certain alpha value
--By Michael
function AlphaMuffet(value)
	muffet_legs.alpha = value
	muffet_arm_bottom_left.alpha = value
	muffet_arm_bottom_right.alpha = value
	muffet_arm_middle_left_static.alpha = value
	muffet_arm_middle_left_moving.alpha = value
	muffet_arm_middle_right_static.alpha = value
	muffet_arm_middle_right_moving.alpha = value
	muffet_arm_top_left_static.alpha = value
	muffet_arm_top_left_moving.alpha = value
	muffet_arm_top_right_static.alpha = value
	muffet_arm_top_right_moving.alpha = value
	muffet_bow_left.alpha = value
	muffet_bow_right.alpha = value
	muffet_head.alpha = value
	muffet_body.alpha = value
	muffet_collar.alpha = value
	muffet_eye_big_left.alpha = value
	muffet_eye_big_right.alpha = value
	muffet_eye_med_left.alpha = value
	muffet_eye_med_right.alpha = value
	muffet_eye_cen.alpha = value
end

-- Debug controls
modify = muffet_legs
function DebugMuffet()
	local speed = 2
	if(Input.Cancel == 1) then
		muffet_animated = not muffet_animated
		if not muffet_animated then
			DefaultPositions()
			muffet_bow_left.rotation = 0
			muffet_bow_right.rotation = 0
			muffet_arm_top_left_moving.rotation = 0
			muffet_arm_top_right_moving.rotation = 0
			muffet_arm_middle_left_moving.rotation = 0
			muffet_arm_middle_right_moving.rotation = 0
			muffet_arm_bottom_left.rotation = 0
			muffet_arm_bottom_right.rotation = 0
			muffet_arm_bottom_left.Set("muffet/arm_bottom_left_in")
			muffet_arm_bottom_right.Set("muffet/arm_bottom_right_in")
		end
	end
	if(Input.Up == 1) then
		modify.y = modify.y + speed
	elseif(Input.Down == 1) then
		modify.y = modify.y - speed
	end
	if(Input.Right == 1) then
		modify.x = modify.x + speed
	elseif(Input.Left == 1) then
		modify.x = modify.x - speed
	end
	if(Input.Menu == 1) then
		DefaultPositions()
	end
	if(Input.Confirm == 1) then
		BattleDialog({"X: " .. modify.x .. "\nY: " .. modify.y .. "[w:999999999][next]"})
	end
end