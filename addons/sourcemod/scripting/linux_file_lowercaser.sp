// SPDX-License-Identifier: GPL-3.0-or-later

public Plugin myinfo =
{
	name = "linux_file_lowercaser",
	author = "rtldg",
	description = "patches server-side for https://github.com/ValveSoftware/source-sdk-2013/issues/865",
	version = "1",
	url = "https://github.com/rtldg/linux_file_lowercaser"
}

#include <dhooks>

#pragma newdecls required
#pragma semicolon 1

public void OnPluginStart()
{
	GameData gamedata = new GameData("linux_file_lowercaser");
	if (gamedata == null) SetFailState("Couldn't load gamedata for linux_file_lowercaser");
	DynamicDetour.FromConf(gamedata, "CUtlFilenameSymbolTable::FindFileName").Enable(Hook_Pre, Hook_CUtilFilenameSymbolTable_FileName_Stuff);
	DynamicDetour.FromConf(gamedata, "CUtlFilenameSymbolTable::FindOrAddFileName").Enable(Hook_Pre, Hook_CUtilFilenameSymbolTable_FileName_Stuff);
}

MRESReturn Hook_CUtilFilenameSymbolTable_FileName_Stuff(DHookReturn ret, DHookParam params)
{
	char filename[PLATFORM_MAX_PATH];
	params.GetString(1, filename, sizeof(filename));
	LowercaseString(filename);
	params.SetString(1, filename);
	return MRES_ChangedHandled;
}

// i love reusing my wonderful stock in a million plugins
stock void LowercaseString(char[] str)
{
	int i, x;
	while ((x = str[i]) != 0)
	{
		if ('A' <= x <= 'Z')
			str[i] += ('a' - 'A');
		++i;
	}
}
