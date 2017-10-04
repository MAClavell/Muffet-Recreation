--A completely blank wave
--Used so that encountertext can update properly

ourtime = Time.time
endwave = ourtime

function Update()
	ourtime = ourtime+Time.dt
	if ourtime > endwave then
		EndWave()
	end
end

function OnHit(bullet)
end