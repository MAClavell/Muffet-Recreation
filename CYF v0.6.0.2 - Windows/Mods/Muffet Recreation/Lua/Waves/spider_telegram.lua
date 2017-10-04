--Wave for when the spider comes out with the telegram
ourtime = Time.time
endwave = ourtime+1
Player.SetControlOverride(true)

--Target is 480, 245

function Update()
  ourtime = ourtime + Time.dt

  if ourtime > endwave then
    State("ENEMYDIALOGUE")
  end

end

function OnHit(bullet)
end