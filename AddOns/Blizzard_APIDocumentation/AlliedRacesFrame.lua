local AlliedRacesFrame =
{
	Name = "AlliedRaces",
	Type = "System",
	Namespace = "C_AlliedRaces",

	Functions =
	{
		{
			Name = "ClearAlliedRaceDetailsGiver",
			Type = "Function",
		},
		{
			Name = "GetAllRacialAbilitiesFromID",
			Type = "Function",

			Arguments =
			{
				{ Name = "raceID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "allDisplayInfo", Type = "table", InnerType = "AlliedRaceRacialAbility", Nilable = false },
			},
		},
		{
			Name = "GetRaceInfoByID",
			Type = "Function",

			Arguments =
			{
				{ Name = "raceID", Type = "number", Nilable = false },
			},

			Returns =
			{
				{ Name = "info", Type = "AlliedRaceInfo", Nilable = false },
			},
		},
	},

	Events =
	{
	},

	Tables =
	{
		{
			Name = "AlliedRaceInfo",
			Type = "Structure",
			Fields =
			{
				{ Name = "raceID", Type = "number", Nilable = false },
				{ Name = "maleModelID", Type = "number", Nilable = false },
				{ Name = "femaleModelID", Type = "number", Nilable = false },
				{ Name = "achievementID", Type = "number", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "description", Type = "string", Nilable = false },
				{ Name = "crestAtlas", Type = "string", Nilable = false },
				{ Name = "modelBackgroundAtlas", Type = "string", Nilable = false },
				{ Name = "raceFileString", Type = "string", Nilable = false },
				{ Name = "bannerColor", Type = "colorRGB", Mixin = "ColorMixin", Nilable = false },
			},
		},
		{
			Name = "AlliedRaceRacialAbility",
			Type = "Structure",
			Fields =
			{
				{ Name = "description", Type = "string", Nilable = false },
				{ Name = "name", Type = "string", Nilable = false },
				{ Name = "icon", Type = "number", Nilable = false },
			},
		},
	},
};

APIDocumentation:AddDocumentationTable(AlliedRacesFrame);