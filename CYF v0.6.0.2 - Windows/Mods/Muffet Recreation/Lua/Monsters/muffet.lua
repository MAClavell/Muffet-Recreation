--The monster script for Muffet

comments = {
"All the spiders clap along to\rthe music.",
"Muffet does a synchronized\rdance with the other spiders.",
"Muffet tidies up the web\raround you.",
"Muffet pours you a cup of\rspiders.",
"Smells like freshly baked\rcobwebs."
}
randomdialogue = {""}

sprite = "blank"

--Basic vars
name = "Muffet"
hp = 1250
atk = 38.8
def = 18.8
xp = 300
gold = 1780
dialogbubble = "rightwide"
canspare = false
cancheck = false

--Struggle vars
struggle = 1

--Pay command vars
payStage = 1
currMoney = 26739
cost = 10
discount = 0

--Commands
commands = {"Check", "Struggle", "Pay " .. cost-discount .. "G"}

SetGlobal("payed", false)

-- Happens after the slash animation but before 
function HandleAttack(attackstatus)
    if attackstatus == -1 then
        -- player pressed fight but didn't press Z afterwards
    else
        -- player did actually attack
        SetSprite("spr_muffethurt_0")
        Encounter['muffet_animated'] = false
        Encounter.Call('RemoveMuffet')
        Move(0, 5, false)
        NewAudio.CreateChannel("laugh")
        NewAudio.PlaySound("laugh", "Sounds/Muffet 2", false, 0.80)
    end
end

function BeforeDamageCalculation()
    SetDamage(22354)
end

function OnDeath()
    NewAudio.Stop("vanillaMusic")
    Encounter['enemies'][2].Call('SetActive',true)
    Encounter['nextwaves'] = {"muffet_dead"}
    Kill()
    State("DEFENDING")
end

function OnSpare()
    gold = 0
    Spare()
    Encounter.Call('AlphaMuffet', 0.5)
    Encounter['muffet_animated'] = false
    BattleDialog({"YOU WON!\nYou earned 300 XP and 0 gold.", "[func:State, DONE]"})
end
 
--Commands
function HandleCustomCommand(command)
    if command == "CHECK" then
        BattleDialog({"MUFFET 8 ATK 0 DEF\nIf she invites you into her\nparlor,[w:10] excuse yourself."})
    elseif command == "STRUGGLE" then --STRUGGLE command
        --Normal usage for "Struggle" during the vanilla waves
        if not canspare and struggle == 1 then
            BattleDialog({"You struggle to escape the web.\nMuffet covers her mouth\rand giggles at you."})
            struggle = struggle + 1
        elseif not canspare and struggle == 2 then
            BattleDialog({"You struggle to escape the web.\nMuffet laughs and claps\rher hands."})
            struggle = struggle + 1
        elseif not canspare and struggle == 3 then
            BattleDialog({"You struggle to escape the web.",
                "Muffet is so amused by your\rantics that she gives you a\rdiscount!"})
            struggle = false
            discount = cost/2
            commands = {"Check", "Struggle", "Pay " .. cost-discount .. "G"}

        --For every other occasion
        else
            BattleDialog({"You struggle to escape the web.\n[w:10]Nothing happened."})
        end
    elseif command == "PAY " .. cost-discount .. "G" then --PAY command
        --Normal usage for "Pay"
        if not canspare and currMoney > cost-discount then
            --Subtract money from player total
            currMoney = currMoney - (cost-discount)
            gold = gold + (cost-discount)
            
            --Dialog
            BattleDialog({"You pay " .. cost-discount .. "G.\n[w:10]Muffet reduces her ATTACK\rfor this turn!"})
            SetGlobal("payed", true)

            --Adjust proper cost price
            if payStage == 1 then
                cost = cost + 30
            elseif payStage == 2 then
                cost = cost+ 40
            elseif payStage == 3 then
                cost = cost + 70
            elseif payStage == 4 then
                cost = cost + 50
            else
                cost = cost + 300
            end
            payStage = payStage + 1
            commands = {"Check", "Struggle", "Pay " .. cost-discount .. "G"}

        --Player can't afford to pay
        elseif not canspare then
            BattleDialog({"You empty your pockets, but you\rdon't have enough money.\n[w:10]Muffet lowers the price."})
            cost=cost/10
            commands = {"Check", "Struggle", "Pay " .. cost-discount .. "G"}
        
        --Muffet is currently sparing the player
        elseif canspare then
            BattleDialog({"Muffet refuses your money."})
        end
    end
end

function CreateNewMuffet()
  Encounter.Call('CreateNewMuffet')
  Encounter.Call('DefaultPositionsNew')
  Encounter['transitionAnim'] = false
  Encounter['muffet_animated'] = true
end

function SetStage3()
    Encounter['stage'] = 3
end