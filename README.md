## WHAT IS THIS
linux games and servers have problems with loading packed file assets (and loose files sometimes!) due to recent changes

relevant issue here: https://github.com/ValveSoftware/Source-1-Games/issues/6868

i tracked the problem down [here](https://github.com/ValveSoftware/source-sdk-2013/issues/865) and @shavitush made a [client-side hook](https://github.com/ValveSoftware/Source-1-Games/issues/6868#issuecomment-2707662934) to fix it (which requires `-insecure`), but servers still encounter the issue so here's a sourcemod plugin to fix it too


## HOW ARE SERVERS BROKEN
bsps that pack models will possibly have collision problems so that's the most visible place

an example map that's somehow broken without this plugin:
- bhop_friendsjump @ `setpos -10239.424805 8130.023438 -2911.968750 ; setang 18.701771 0.225578 0.000000`


## DOES IT SUPPORT TF2/HL2DM/DODS
probably but i haven't checked. lemme know if it does/doesn't

