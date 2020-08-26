# Multictrl

Tired of entering commands everytime you want healbot or other addons to start or stop?  Use this to initialze your addons for alts or main and just execute with 1 command.

Using IPC now, don't require entering any alt's names.

Also included is loading addons/commands for Quetz farming.

Current commands:  Use //multi or //mc

================================================================================

ON:  Toggles all addons that are defined under ON function such as healbot/autogeo/roller/singer etc.

OFF:  Toggles all addons to turn off.

night: Turns off Healbot and unloads gearswap for all characters

wake: Reloads Healbot and gearswap on all characters

D2:  Will D2 all members of current party, will rest for MP if low on MP.

fon:  Toggles healbot's follow on function, will follow to the current player executing this command.

foff:  Disable following via healbot's function.

warp:  Warp all chars using myhome addon.

omen:  Warps all chars to omen crag using myomen addon. (See MyOmen repository)

mnt:  Mount all chars using defined mount.

dis:  Dismount all chars.

reload:  Reload healbot or more addons if you defined it.

send {command}:

fight: Sets the follow distance depending on job type

assist {melee | all | on | off}: Directs all members to assist the current player executing this command. Melee: only Melee jobs will assist. All: all jobs will assist. Off: turns assist off.

crystal: Sends a command to all 'toons' to trade crystals to the moogle

fps {30 | 60}: Sets the frame rate to be either 30 or 60 fps

fin: Casts dispel or finale on current target

lotall: Uses the treasury addon to lot everything currently in the pool

ws: Activates Autows

buy {on | off | shield | powder | ss | sp | re}: uses the buy addon to purchase items automatically; On: sets buy to true; Off: sets buy to false; shield: buy must be on, and will purchase shields from npc; powder: buy must be on, and will purchase powder from npc; ss: loads sellnpc shields; sp: loads sellnpc powder; re: reloads

example
  mc buy on
  mc buy shield
  mc buy ss
  mc buy off


buff: Activates 'buffup' for WHM,RDM,GEO,BRD,SMN,BLM,SCH,RUN

gettarget: Gets targetID of the current target

d2: Warps out all party members - must have the warp II spell available

burnset {avatar, avatarname}: sets the avatar to be the defined avatar
burnset {on | off}: Turns the burnset on and OFF
burnset {dia, on | off}: sets burnset to diabolos
burnset{indi, torpor | malaise | refresh | fury} sets burnset for geo indi to specified spell

geoburn
smnburn


---Escha Stuff ---

trib: gets Tribulens for all characters

rads: gets Radialens for all characters

buyalltemps: Purchases all temp items for all characters


htmb {enter | buy}: Will enter HTBF | Will buy all high tier battlefield items

runic: uses runic portals

tag: Gets Assault tags

done: ?

ein: ?
