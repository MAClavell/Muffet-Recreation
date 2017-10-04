--The encounter script for Muffet

--This project was scripted by Michael Clavell
--The Unitale engine was created by lvkuln
--The Create Your Frisk engine was created by RhenaudTheLukark

encountertext = "[novoice]Muffet traps you!"
nextwaves = {"muffet_thirdlast"}
wavetimer = 99
arenasize = {155, 130}
flee = false

--Vanilla vars
stage = 1 --controls wave and dialog selection for muffet
telegram = false --controls when the telegram spider appears
SetGlobal("muffetDown", false)


--Fade in vars
fadeSprite = nil
fadeTimer = 0
fadeIn = true
fadeMusic = 0


--Vars for the sign spider
signBool = true
siAcc = 0
siSpeed = 3
siTimer = 0
siTarget = 600
siEnter = false
siMoving = false
siStationary = false
siNum = 0
signSymbols = {}
createSigns = false

--Vars for displaying player money
moneyCharacters = {}
showMoney = false

--Enemies table
enemies = {
"muffet",
}

--Positions of the enemies
enemypositions = {
{0, 0},
}

--Called once at the very beggining of the encounter
function EncounterStarting()
  --Animation by Travoos (www.reddit.com/u/travoos)
  require "Libraries/Animations/muffet"
  Player.lv = 13
  Player.hp = 68
  Player.name = "Player"

  --Add items
  Inventory.AddCustomItems({"Dog"}, {0})
  Inventory.SetInventory({"Dog"})

  --Audio using the NewAudio object
  Audio.Stop()
  NewAudio.CreateChannel("vanillaMusic")
  NewAudio.PlayMusic("vanillaMusic", "Audio/Spider Dance", true, 1)

  --Sign spider sprite
  siSpider = CreateSprite("PurpleSoul/BattleSpider0", "BelowBullet")
  siSpider.MoveTo(705, 245)

  --Sign sprite
  sign = CreateSprite("PurpleSoul/sign/sign0", "BelowBullet")
  sign.SetPivot(47/94, 0)
  sign.MoveTo(siSpider.x-2, siSpider.y+5)
  sign.SetParent(siSpider)

  --Fade in sprite
  fadeSprite = CreateSprite("blackScreen", "Top")
  fadeSprite.MoveToAbs(320, 240)
end

--Occurs every frame
function Update()
  if Player.hp < 1 then
    NewAudio.StopAll()
  end

  --Update Muffet's sprite
  --Once again, by Travoos (www.reddit.com/u/travoos)
  UpdateMuffet()

  --The fade in at the beggining of the encounter
  if fadeIn then
    --Fades in at 15 fps
    if fadeTimer > 1/15 then
      fadeTimer = fadeTimer-(1/15)
      fadeSprite.alpha32 = fadeSprite.alpha32-3
      NewAudio.SetVolume("vanillaMusic", fadeMusic+(1/255))
    end
    if fadeSprite.alpha32 <= 0 then
      fadeSprite.Remove()
      fadeIn = false
      NewAudio.SetVolume("vanillaMusic", 1)
    end
    fadeTimer = fadeTimer + Time.dt
    fadeMusic = fadeMusic+1/255
  end

  --When the telegram spider appears
  if telegram then
    --Rotation for the telegram
    telegram.rotation = 13*math.sin(3*Time.time)
     --Animating the spider at 7 fps
     telSpider.Set("PurpleSoul/BattleSpider" .. math.floor((Time.time / (1/7)) % 2))

    --Moving the spider
    if telEnter and telSpider.x > telTarget then
      telSpider.x = telSpider.x-telSpeed
    elseif not telEnter and telSpeed+telAcc >= 3 then
      telSpider.x = telSpider.x+telSpeed

    --Decrease/Increase acceleration after the spider reaches a certain point
    elseif telEnter and telSpeed+telAcc > 0 then
      telSpider.x = telSpider.x-(telSpeed+telAcc)*Time.mult
      if telTimer > 1/15 then
        telTimer = telTimer-1/15
        telAcc = telAcc-(3/15)
      end
      telTimer = telTimer + Time.dt
    elseif not telEnter then
      telSpider.x = telSpider.x+(telSpeed+telAcc)*Time.mult
      if telTimer > 1/15 then
        telTimer = telTimer-1/15
        telAcc = telAcc+(3/15)
      end
      telTimer = telTimer + Time.dt
    end

    if not telEnter and telSpider.x > 720 then
      telegram.Remove()
      telSpider.Remove()
      telegram = false
    end
  end

  --When the sign spider appears
  if signBool then
    --If the spider is moving
    if siMoving then
      --Changing the spiders sprite
      siSpider.Set("PurpleSoul/BattleSpider" .. math.floor((Time.time / (1/7)) % 2))
      --Moving the spider
      if siEnter and siSpider.x > siTarget then
        siSpider.x = siSpider.x-siSpeed
      elseif not siEnter and siSpeed+siAcc >= 3 then
        siSpider.x = siSpider.x+siSpeed

      --Decrease/Increase acceleration after the spider reaches a certain point
      elseif siEnter and siSpeed+siAcc > 0 then
        siSpider.x = siSpider.x-(siSpeed+siAcc)
        if siTimer > 1/15 then
          siTimer = siTimer-1/15
          siAcc = siAcc-(3/15)
        end
        siTimer = siTimer + Time.dt
      elseif not siEnter and siSpeed+siAcc < 3 then
        siSpider.x = siSpider.x+(siSpeed+siAcc)
        if siTimer > 1/15 then
          siTimer = siTimer-1/15
          siAcc = siAcc+(3/15)
        end
        siTimer = siTimer + Time.dt
      end

      --Control whether the spider should be putting of the sign or sitting still offscreen
      if siEnter and siSpeed+siAcc <= 0 then
        siMoving = false
        siStationary = true
        siSpider.Set("PurpleSoul/BattleSpider0")
        siTimer = 0
        createSigns = true
      elseif not siEnter and siSpider.x > 705 then
        siMoving = false
        siStationary = false
      end
    --If the spider is stationary
    elseif siStationary then
      --Switch to moving when the sign is done retracting
      if not siEnter and siNum == 0 then
        siMoving = true
        siStationary = false
        siTimer = 0
      end
      --Increment the sprite number to get the correct sprite every 30 frames
      if siEnter and siTimer > 1/30 and siNum < 5 then
        siNum = siNum + 1
        siTimer = siTimer-(1/30)
      elseif not siEnter and siTimer > 1/30 and siNum > 0 then
        siNum = siNum - 1
        siTimer = siTimer-(1/30)
      end
      siTimer = siTimer + Time.dt
      --Set the sprite of the sign
      sign.Set("PurpleSoul/sign/sign" .. siNum)

      --Find what to put on the sign
      if siNum == 5 and siEnter and createSigns then
        --Create the symbols on the sign based on what wave is coming up
        createSigns = false
        --Make sure stage == 3 is first
        --One spider
        if stage == 3 or stage == 4 or stage == 9 or stage == 13 then
          local spider = CreateSprite("purplesoul/spiderbullet", "BelowBullet")
          spider.MoveTo(sign.absx+1, sign.absy+70)
          table.insert(signSymbols, spider)
        --Spider and donut
        elseif stage == 6 or stage == 8 or stage == 10 then
          local spider = CreateSprite("purplesoul/spiderbullet", "BelowBullet")
          local donut = CreateSprite("purplesoul/donutbullet", "BelowBullet")
          donut.MoveTo(sign.absx+16, sign.absy+70)
          spider.MoveTo(sign.absx-14, sign.absy+70)
          table.insert(signSymbols, spider)
          table.insert(signSymbols, donut)
        --One croissant
        elseif stage == 11 then
          local croissant = CreateSprite("purplesoul/croissantl", "BelowBullet")
          croissant.MoveTo(sign.absx+1, sign.absy+70)
          table.insert(signSymbols, croissant)
        --Two spiders
        elseif stage == 5 or stage == 16 then
          local spider1 = CreateSprite("purplesoul/spiderbullet", "BelowBullet")
          local spider2 = CreateSprite("purplesoul/spiderbullet", "BelowBullet")
          spider1.MoveTo(sign.absx+16, sign.absy+70)
          spider2.MoveTo(sign.absx-14, sign.absy+70)
          table.insert(signSymbols, spider1)
          table.insert(signSymbols, spider2)
        --Two donuts
        elseif stage == 14 then
          local donut1 = CreateSprite("purplesoul/donutbullet", "BelowBullet")
          local donut2 = CreateSprite("purplesoul/donutbullet", "BelowBullet")
          donut1.MoveTo(sign.absx+16, sign.absy+70)
          donut2.MoveTo(sign.absx-14, sign.absy+70)
          table.insert(signSymbols, donut1)
          table.insert(signSymbols, donut2)
        --Two croissants
        elseif stage == 15 then
          local croissant1 = CreateSprite("purplesoul/croissantl", "BelowBullet")
          local croissant2 = CreateSprite("purplesoul/croissantl", "BelowBullet")
          croissant1.MoveTo(sign.absx+16, sign.absy+70)
          croissant2.MoveTo(sign.absx-14, sign.absy+70)
          table.insert(signSymbols, croissant1)
          table.insert(signSymbols, croissant2)
        --Spider, donut, and croissant
        elseif stage == 17 then
          local spider = CreateSprite("purplesoul/spiderbullet", "BelowBullet")
          local donut = CreateSprite("purplesoul/donutbullet", "BelowBullet")
          local croissant = CreateSprite("purplesoul/croissantl", "BelowBullet")
          spider.MoveTo(sign.absx-24, sign.absy+70)
          donut.MoveTo(sign.absx+2, sign.absy+70)
          croissant.MoveTo(sign.absx+26, sign.absy+70)
          table.insert(signSymbols, spider)
          table.insert(signSymbols, donut)
          table.insert(signSymbols, croissant)
        --Pet
        elseif stage == 7 or stage == 12 or stage == 18 then
          local pet = CreateSprite("purplesoul/cupcakebullet", "BelowBullet")
          pet.MoveTo(sign.absx, sign.absy+70)
          table.insert(signSymbols, pet)
        end
      end
    end
  end

  if GetGlobal("muffetDown") then
    MoveMuffet(8, 260, true)
    if muffet_legs.absy < 260 then
      muffet_legs.absy = 260
      SetGlobal("muffetDown", false)
    end
  end

  --Remove the players money from the screen when not in the ACT menu
  if showMoney and not (GetCurrentState() == "ACTMENU") then
    for i=1,#moneyCharacters do
      if moneyCharacters[i].isactive then moneyCharacters[i].Remove() end
    end
    moneyCharacters = {}
    showMoney = false
  end
end

function EnteringState(newstate, oldstate)
  if enemies[1]['hp'] > 0 then
    if not ((stage == 19) or (stage == 20) or (stage == 2))then
      --Deciding what vars to set for the sign spider based on states
      if (oldstate == "DIALOGRESULT" and newstate == "ENEMYDIALOGUE") or (oldstate == "ENEMYSELECT" and newstate == "ATTACKING") then
        if not enemies[1]['canspare'] then
          if signBool then
            siMoving = false
            siStationary = true
            siTimer = 0
            siEnter = false
            --Remove all the sprites on the sign
            for i=1,#signSymbols do
              if signSymbols[i].isactive then signSymbols[i].Remove() end
            end
          end
        end
      elseif newstate == "ACTIONSELECT" and (oldstate == "ENEMYDIALOGUE" or oldstate == "DEFENDING") then
        if signBool then
          siMoving = true
          siStationary = false
          siTimer = 0
          siEnter = true
        end
      end
    end

    --Show the players total money during ACT select
    if oldstate == "ENEMYSELECT" and newstate == "ACTMENU" then
      showMoney = true
      local m = CreateSprite("purplesoul/money", "BelowBullet")
      m.SetPivot(0, 0)
      m.MoveToAbs(196, 114)
      table.insert(moneyCharacters, m)

      --Unnecessarily complicated but its late so w/e
      --Maybe fix later
      local strNum = "" .. enemies[1]['currMoney']
      for i=1,string.len(strNum) do
        local num = CreateSprite("purplesoul/numbers/" .. string.sub(strNum,i,i), "BelowBullet")
        num.SetPivot(0, 0)
        num.color = {1, 1, 0}
        --If the first number, set the position to be 28 after the "Your Money" sprite
        if i == 1 then 
          num.MoveToAbs(m.absx+164+28, 120)
          table.insert(moneyCharacters, num)
        else
        --For every other number set it to be 4 after the previous
          num.MoveToAbs(m.absx+164+28+(16*(i-1)), 120)
          table.insert(moneyCharacters, num)
        end
      end
    end
  end
end

--Before the monster dialog starts
function EnemyDialogueStarting()
  --Dialog while Muffet is performing the vanilla waves
  if not enemies[1]['canspare'] then
    if stage == 1 then
      --enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Don't look so\nblue,[w:5] my deary~", "[next]"})
    elseif stage == 2 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "...I think purple is\na better look on\nyou! Ahuhuhu~", "[next]",
        "[func:SetStage3][func:State,ACTIONSELECT]"})
    elseif stage == 3 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Why so pale?\nYou should be\nproud~", "[next]"})
    elseif stage == 4 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Proud that you're\ngoing to make a\ndelicious cake~\nAhuhuhu~", "[next]"})
    elseif stage == 5 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Let you go?[w:5]\nDon't be silly~", "[next]"})
    elseif stage == 6 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "You're scaring off\nall my customers!", "[next]"})
    elseif stage == 7 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Oh, how rude of me!\nI almost forgot\nto introduce you\nto my pet~",
        "It's breakfast time,\nisn't it?\nHave fun, you two~", "[next]"})
    elseif stage == 8 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "The person who\nwarned us about\nyou...", "[next]"})
    elseif stage == 9 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Looked like a total\nnerd.", "[next]"})
    elseif stage == 10 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "She was very\nadamant I run away\nwith her~~~\nAhuhuhu~~", "[next]"})
    elseif stage == 11 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "She even left a\nroute for me to\nescape from~", "[next]"})
    elseif stage == 12 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Oh, it's lunch time,\nisn't it?\nAnd I forgot to\nfeed my pet~", "[next]"})
    elseif stage == 13 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "She said she would\nblock off the rest\nof Hotland after I\nfollowed her~", "[next]"})
    elseif stage == 14 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Foolish nerd~\nA spider NEVER\nleaves her web~",
        "(Except to sell\npastries~)", "[next]"})
    elseif stage == 15 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Ah,[w:5] but I do feel\na little regret\nover it now...", "[next]"})
    elseif stage == 16 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Yes,[w:5] I should have\nwrapped her up when\nI had the chance~", "[next]"})
    elseif stage == 17 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "She looked like she\nwould have made a\njuicy donut~~~", "[next]"})
    elseif stage == 18 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "But enough of that...\nIt's time for\ndinner, isn't it?\nAhuhuhu~", "[next]"})
    elseif stage == 19 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "You're still alive?\n[w:10]Ahuhuhu~",
        "Oh, my pet~\nLooks like it's\ntime for dessert~", "[next]"})
    elseif stage == 20 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
       "Huh?\nA telegram from\nthe spiders in\nthe RUINS?",
       "They say even if\nyou are a hyper-\nviolent murderer...",
       "You never laid a\nsingle finger on a\nspider!",
       "Oh my, this has\nall been a big\nmisunderstanding~",
       "I thought you\nwere someone that\nhated spiders~",
       "The person who\nwarned me about\nyou...",
       "They really had\nno idea what they\nwere talking about~",
       "Sorry for all the\ntrouble~\nAhuhuhu~",
       "I'll make it up\nto you~",
       "You can come back\nhere any time...\nAnd, for no charge\nat all...",
       "I'll wrap you\nup and let you\nplay with my pet\nagain!",
       "Ahuhuhuhuhuhu~\nJust kidding~",
       "I'll SPARE you\nnow~"})
    end

  --Dialog while Muffet is sparing the player after the vanilla waves
  elseif enemies[1]['canspare'] then
    if stage == 21 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Ahuhuhu~\nWhat are you\ndoing~",
        "[func:State,ACTIONSELECT]"})
      stage = 22
    elseif stage == 22 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "It's time to go~",
        "[func:State,ACTIONSELECT]"})
      stage = 23
    elseif stage == 23 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Feeling comfortable\ntrapped in that\nweb?",
        "[func:State,ACTIONSELECT]"})
      stage = 24
    elseif stage == 24 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Ahuhuhu~\nWell, I don't\nmind keeping\nyou here~",
        "[func:State,ACTIONSELECT]"})
      stage = 25
    elseif stage == 25 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "If you don't mind\nbeing gobbled up~\nAhuhuhu~",
        "[func:State,ACTIONSELECT]"})
      stage = 26
    elseif stage == 26 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "Just kidding,\nof course~",
        "[func:State,ACTIONSELECT]"})
      stage = 27
    elseif stage == 27 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "...\nwell... maybe\nONE little\nnibble~~",
        "[func:State,ACTIONSELECT]"})
      stage = 28
    elseif stage == 28 then
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "No, no, it's\ntime to go~",
        "[func:State,ACTIONSELECT]"})
      stage = 29             
    else
      enemies[1].SetVar('dialogbubble', "rightwide")
      enemies[1].SetVar('currentdialogue', {
        "...",
        "[func:State,ACTIONSELECT]"}) 
    end
  end
end

--When the monster dialog ends
function EnemyDialogueEnding()
  --Vanilla wave selection
  if enemies[1]['hp'] < 1 then
    nextwaves = {"muffet_dead"}
  elseif stage == 1 then
    nextwaves = {"muffet_purpleChange"}
    stage = 2
  elseif stage == 3 then
    nextwaves = {"muffet_01"}
    stage = 4
  elseif stage == 4 then
    nextwaves = {"muffet_02"}
    stage = 5
  elseif stage == 5 then
    nextwaves = {"muffet_03"}
    stage = 6
  elseif stage == 6 then
    nextwaves = {"muffet_04"}
    stage = 7
  elseif stage == 7 then
    nextwaves = {"muffet_pet1"}
    stage = 8
  elseif stage == 8 then
    nextwaves = {"muffet_05"}
    stage = 9
  elseif stage == 9 then
    nextwaves = {"muffet_06"}
    stage = 10
  elseif stage == 10 then
    nextwaves = {"muffet_07"}
    stage = 11
  elseif stage == 11 then
    nextwaves = {"muffet_08"}
    stage = 12
  elseif stage == 12 then
    nextwaves = {"muffet_pet2"}
    stage = 13
  elseif stage == 13 then
    nextwaves = {"muffet_09"}
    stage = 14
  elseif stage == 14 then
    nextwaves = {"muffet_10"}
    stage = 15
  elseif stage == 15 then
    nextwaves = {"muffet_11"}
    stage = 16
  elseif stage == 16 then
    nextwaves = {"muffet_12"}
    stage = 17
  elseif stage == 17 then
    nextwaves = {"muffet_13"}
    stage = 18
  elseif stage == 18 then
    nextwaves = {"muffet_pet3"}
    stage = 19
  elseif stage == 19 then
    nextwaves = {"spider_telegram"}
    stage = 20
    telegram = true

    --Vars for telegram spider
    telAcc = 0
    telSpeed = 3
    telTimer = 0
    telTarget = 580
    telEnter = true

    --Telegram spider
    telSpider = CreateSprite("PurpleSoul/BattleSpider0", "Top")
    telSpider.MoveTo(705, 245)

    --Telegram
    telegram = CreateSprite("PurpleSoul/telegram", "Top")
    telegram.SetAnchor(19/20, 0)
    telegram.SetPivot(19/20, 0)
    telegram.Scale(2, 2)
    telegram.MoveTo(telSpider.x-8, telSpider.y+7)
    telegram.SetParent(telSpider)
  elseif stage == 20 then
    nextwaves = {"blank"}
    enemies[1].SetVar('canspare', true)
    stage = 21
    telEnter = false
    telTimer = 0
    enemies[2].Call('SetActive', true)
  end
end

--When the defense wave ends
function DefenseEnding()
  --Get a random encounter text from muffet.lua
  if stage == 21 then
    encountertext = "Muffet is sparing you."
  else
    encountertext = RandomEncounterText()
  end

  --Set payed to false if the player payed Muffet before the wave
  if GetGlobal("payed") then
    SetGlobal("payed", false)
  end
end

function HandleSpare()
  BattleDialog({"You are tied up in Muffet's web."})
end

function HandleItem(ItemID)
  BattleDialog({"How... how did this even get\nhere?"})
end