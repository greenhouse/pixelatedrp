DiscordWebhookSystemInfos = 'https://discordapp.com/api/webhooks/483673918620696576/QvIVh49dd5fOJvGVNSXTkQQuohjMVzSbwpp8wtT_VHVn8Y9zO9DkqUncjjkly0Rw6pcy'
DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/483673794364309551/2yYIfE97SF6SBciO69x5kp3exH1nusReijpt8cGbEGiDOPAdAmN8gIssp_v8nuuGwR5M'
DiscordWebhookChat = 'https://discordapp.com/api/webhooks/483674109188898816/ju-2MYKga3vM664G9I2YX-_wf4jQhfZKvZr7XzNO2aomxKeTQG-2HjFvBZ2C8OowIpUU'

SystemAvatar = 'http://145.131.6.71/images/logo_160.png'

UserAvatar = 'https://i.imgur.com/KIcqSYs.png'

SystemName = 'Pixelated RP'


--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]:**'},
				   {'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }


-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '/AnyCommand2',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/AnotherCommand', 'WEBHOOK_LINK_HERE'},
					  {'/AnotherCommand2', 'WEBHOOK_LINK_HERE'},
					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }
