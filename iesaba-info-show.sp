#pragma semicolon 1

#include <sourcemod>
#include <sdktools>

public Plugin:myinfo =
{
	name        = "iesaba-info-show",
	author      = "k725",
	description = "iesaba Rule, Contact, CommandList show plugin.",
	version     = "1.0",
	url         = ""
};

public OnPluginStart()
{
	AddCommandListener(Command_Say, "say");
	HookEvent("round_start", Event_RoundStart);
}

public Action:Command_Say(client, const String:command[], argc)
{
	decl String:speech[64];
	new startidx = 0;

	if (GetCmdArgString(speech, sizeof(speech)) < 1)
		return Plugin_Continue;

	if (speech[strlen(speech) - 1] == '"')
	{
		speech[strlen(speech) - 1] = '\0';
		startidx = 1;
	}

	// List
	if (strcmp(speech[startidx], "/list", false) == 0)
	{
		ShowMOTDPanel(client, "Title", "http://files.iesaba.com/csmap/html/?f=saycommand.htm", MOTDPANEL_TYPE_URL);
		return Plugin_Handled;
	}

	// Rule
	if (strcmp(speech[startidx], "/rule", false) == 0)
	{
		ShowMOTDPanel(client, "Title", "http://files.iesaba.com/csmap/html/?f=rule.htm", MOTDPANEL_TYPE_URL);
		return Plugin_Handled;
	}

	// Contact
	if (strcmp(speech[startidx], "/contact", false) == 0)
	{
		ShowMOTDPanel(client, "Title", "http://files.iesaba.com/csmap/html/?f=contact.htm", MOTDPANEL_TYPE_URL);
		return Plugin_Handled;
	}

	return Plugin_Continue;
}

public Event_RoundStart(Handle:event, const String:name[], bool:dontBroadcast)
{
	for (new i = 1; i <= MaxClients; i++)
		if(IsValidClient(i))
			PrintHintText(i, "saycommand list ---> /list\nadmin contact ---> /contact\nshow rule ---> /rule");
}

public IsValidClient(client)
{
	if (client == 0)
		return false;

	if (!IsClientConnected(client))
		return false;

	if (IsFakeClient(client))
		return false;

	if (!IsClientInGame(client))
		return false;

	return true;
}
