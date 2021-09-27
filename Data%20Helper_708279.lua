-- set true to enable debug logging
DEBUG = false

function log(message)
  if DEBUG then
  print(message)
  end
end

--[[
Known locations and clues. We check this to determine if we should
atttempt to spawn clues, first we look for <LOCATION_NAME>_<GUID> and if
we find nothing we look for <LOCATION_NAME>
format is [location_guid -> clueCount]
]]
LOCATIONS_DATA_JSON = [[
{
  "Study": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Study_670914": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Attic_377b20": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Attic": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Cellar_5d3bcc": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Cellar": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Bathroom": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Bedroom": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Far Above Your House": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Deep Below Your House": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Northside_86faac": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Northside": {"type" : "perPlayer", "value": 2, "clueSide": "back"},
  "Graveyard": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Miskatonic University_cedb0a": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Miskatonic University": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Downtown_1aa7cb": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Downtown": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "St. Mary's Hospital": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Easttown_88245c": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Easttown": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Southside": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Rivertown": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Your House_377b20": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Your House_b28633": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Ritual Site": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Arkham Woods_e8e04b": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Arkham Woods": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "New Orleans_5ab18a": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "New Orleans": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Riverside_ab9d69": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Riverside": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Wilderness_3c5ea8": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Wilderness": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Unhallowed Land_552a1d": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Unhallowed Land_15983c": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Flooded Square": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Streets of Venice": {"type": "fixed", "value": 2, "clueSide": "back"},
  "Rialto Bridge": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Venetian Garden": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Guardian": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Canal-side": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Accademia Bridge": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Bridge of Sighs": {"type": "fixed", "value": 2, "clueSide": "back"},

  "Warren Observatory": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Science Building": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Orne Library": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Administration Building": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Student Union": {"type": "fixed", "value": 2, "clueSide": "back"},
  "Humanities Building": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Dormitories": {"type": "perPlayer", "value": 3, "clueSide": "back"},
  "Faculty Offices": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Faculty Offices_1c567d": {"type": "perPlayer", "value": 0, "clueSide": "back"},

  "La Bella Luna": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Back Hall Doorway": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Museum Entrance": {"type": "fixed", "value": 2, "clueSide": "back"},
  "Security Office": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Security Office_fcb3e4": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Administration Office": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Administration Office_d2eb25": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Exhibit Hall": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Exhibit Hall_563240": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Exhibit Hall_f3ffb6": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Exhibit Hall_0b0c58": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Exhibit Hall_2d87e6": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Exhibit Hall_da02ea": {"type": "perPlayer", "value": 0, "clueSide": "back"},

  "Train Car": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Train Car_f3f902": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Train Car_905f69": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Train Car_a3a321": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Train Car_464528": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Train Car_3cfca4": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Train Car_64ffb0": {"type": "fixed", "value": 3, "clueSide": "back"},
  "Train Car_0fb5f0": {"type": "perPlayer", "value": 3, "clueSide": "back"},
  "Engine Car": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "House in the Reeds": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Osborn's General Store": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Congregational Church": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Bishop's Brook": {"type": "fixed", "value": 2, "clueSide": "back"},
  "Burned Ruins": {"type": "fixed", "value": 3, "clueSide": "back"},
  "Schoolhouse": {"type": "fixed", "value": 1, "clueSide": "back"},

  "Dunwich Village": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Dunwich Village_ac4427": {"type": "fixed", "value": 3, "clueSide": "back"},
  "Cold Spring Glen": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Cold Spring Glen_e58475": {"type": "fixed", "value": 2, "clueSide": "back"},
  "Ten-Acre Meadow": {"type": "fixed", "value": 3, "clueSide": "back"},
  "Ten-Acre Meadow_05b0dd": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Blasted Heath": {"type": "fixed", "value": 3, "clueSide": "back"},
  "Blasted Heath_995fe7": {"type": "fixed", "value": 2, "clueSide": "back"},
  "Whateley Ruins": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Devil's Hop Yard": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Devil's Hop Yard_f7dd31": {"type": "fixed", "value": 2, "clueSide": "back"},

  "Base of the Hill": {"type": "fixed", "value": 3, "clueSide": "back"},
  "Base of the Hill_80236e": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Ascending Path": {"type": "fixed", "value": 3, "clueSide": "back"},
  "Ascending Path_d3ae26": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Sentinel Peak": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Diverging Path": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Diverging Path_7239aa": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Altered Path": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "The Edge of the Universe": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Tear Through Time": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Prismatic Cascade": {"type": "fixed", "value": 3, "clueSide": "front"},
  "Towering Luminosity": {"type": "fixed", "value": 4, "clueSide": "front"},
  "Tear Through Space": {"type": "fixed", "value": 1, "clueSide": "front"},
  "Endless Bridge": {"type": "fixed", "value": 2, "clueSide": "front"},
  "Dimensional Doorway": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Steps of Y'hagharl": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Unstable Vortex": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Indecipherable Stairs": {"type": "fixed", "value": 1, "clueSide": "front"},

  "Backstage Doorway": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Backstage Doorway_0797a9": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Lobby Doorway": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Lobby Doorway_7605cf": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Lobby": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Backstage": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Balcony": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Foyer": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Historical Society": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Historical Society_40f79d": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Historical Society_b352f8": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Historical Society_0cf5d5": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Historical Society_abc0cb": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Historical Society_ab6a72": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Hidden Library": {"type": "perPlayer", "value": 3, "clueSide": "back"},

  "Patient Confinement": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Asylum Halls": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Asylum Halls_f99530": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Asylum Halls_576595": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Infirmary": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Basement Hall": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Yard": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Garden": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Kitchen": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Mess Hall": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "Grand Guignol": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Montmartre": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Montmartre_cbaacc": {"type": "perPlayer", "value": 0, "clueSide": "front"},
  "Montparnasse": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Notre-Dame": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Gare d'Orsay": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Opéra Garnier": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Canal Saint-Martin": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Le Marais": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Gardens of Luxembourg": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Père Lachaise Cemetery": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "Catacombs": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Catacombs_29170f": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Catacombs_f1237c": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Catacombs_c3151e": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Catacombs_14b1cb": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Catacombs_81920c": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Catacombs_c14c8b": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Catacombs_ea2a55": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Catacombs_8bcab3": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Catacombs_7c7f4a": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Catacombs_80cf41": {"type": "fixed", "value": 0, "clueSide": "back"},

  "Abbey Church": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Porte de l'Avancée": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Grand Rue": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Cloister": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Knight's Hall": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Chœur Gothique": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Outer Wall": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Outer Wall_014bd6": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "North Tower": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "North Tower_69eae5": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Chapel of St. Aubert": {"type": "perPlayer", "value": 3, "clueSide": "back"},
  "Chapel of St. Aubert_e75ba8": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Abbey Tower": {"type": "perPlayer", "value": 3, "clueSide": "back"},
  "Abbey Tower_2f3d21": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "Shores of Hali": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Dark Spires": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Palace of the King": {"type": "perPlayer", "value": 3, "clueSide": "front"},
  "Palace of the King_60d758": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Ruins of Carcosa": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Dim Streets": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Depths of Demhe": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Bleak Plains": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Recesses of Your Own Mind": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "The Throne Room": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Stage of the Ward Theatre": {"type": "perPlayer", "value": 2, "clueSide": "front"},

  "Serpent’s Haven": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Ruins of Eztli": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Rope Bridge": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Overgrown Ruins": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "River Canyon": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Path of Thorns": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Temple of the Fang": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Circuitous Trail": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Riverside Temple": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Waterfall": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Trail of the Dead": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Cloud Forest": {"type": "perPlayer", "value": 2, "clueSide": "front"},

  "Chamber of Time": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Ancient Hall": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Ancient Hall_b9acb8": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Grand Chamber": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Entryway": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Underground Ruins": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Burial Pit": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Secret Passage": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Snake Pit": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Throne Room": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Mosaic Chamber": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Tomb of the Ancients": {"type": "perPlayer", "value": 1, "clueSide": "front"},

  "Town Hall": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Curiositie Shoppe": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "At the Station": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "At the Station_e0833c": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Missing Persons": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "The Relic is Missing!": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Trial of the Huntress": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Search for the Meaning": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Seeking Trouble": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Seeking Trouble_42f93b": {"type": "perPlayer", "value": 0, "clueSide": "back"},

  "Sacred Woods": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Chapultepec Hill": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Chapultepec Hill_baec21": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Canals of Tenochtitlán": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Lake Xochimilco": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Lake Xochimilco_59bf7d": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Templo Mayor": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Templo Mayor_fb0083": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Temples of Tenochtitlán": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Temples of Tenochtitlán_80cef8": {"type": "perPlayer", "value": 1, "clueSide": "front"},

  "Mouth of K'n-yan_38a3e5": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Stone Altar": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Time-Wracked Woods": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Vast Passages": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Perilous Gulch": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Dark Hollow": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Hall of Idolatry": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Crystal Pillars": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Ruins of K’n-yan": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Chthonian Depths": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Subterranean Swamp": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Treacherous Descent": {"type": "perPlayer", "value": 1, "clueSide": "front"},

  "Interview Room": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Interview Room_b1861c": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Halls of Pnakotus": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Deconstruction Room": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Towers of Pnakotus": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Laboratory of the Great Race": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Yithian Orrery": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Great Library": {"type": "fixed", "value": 4, "clueSide": "back"},
  "Cyclopean Vaults": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Alien Conservatory": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "City of the Serpents": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Bridge over N'kai": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Abandoned Site": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Caverns of Yoth": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Hall of Heresy": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Bright Canyon": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Forked Path": {"type": "perPlayer", "value": 2, "clueSide": "front"},

  "Nexus of N'kai": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "A Pocket in Time": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "City of the Unseen": {"type": "fixed", "value": 1, "clueSide": "front"},
  "Valusia": {"type": "fixed", "value": 2, "clueSide": "front"},
  "Great Hall of Celeano": {"type": "fixed", "value": 3, "clueSide": "front"},
  "Buenos Aires": {"type": "fixed", "value": 3, "clueSide": "front"},
  "Ultima Thule": {"type": "fixed", "value": 2, "clueSide": "front"},

  "Shores of R’lyeh": {"type": "fixed", "value": 2, "clueSide": "front"},
  "Atlantis": {"type": "fixed", "value": 2, "clueSide": "front"},
  "Pnakotus": {"type": "fixed", "value": 3, "clueSide": "front"},
  "Ruins of New York": {"type": "fixed", "value": 3, "clueSide": "front"},
  "Yuggoth": {"type": "fixed", "value": 3, "clueSide": "front"},
  "Mu": {"type": "fixed", "value": 4, "clueSide": "front"},
  "Plateau of Leng_0ab6ff": {"type": "fixed", "value": 1, "clueSide": "front"},

  "Billiards Room": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Billiards Room_33990b": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Trophy Room": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Trophy Room_e9160a": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Master Bedroom": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Balcony_1b5483": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Office": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Office_a1bd9a": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Witch-Haunted Woods_1539ea": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Witch-Haunted Woods_db1663": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Witch-Haunted Woods": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Witch-Haunted Woods_d3f8c3": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Witch-Haunted Woods_eca18e": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Paths into Twilight": {"type": "perPlayer", "value": 3, "clueSide": "back"},

  "The Imperial Entrance": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Dark Stairwell": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Stairway": {"type": "fixed", "value": 1, "clueSide": "back"},
  "The Balcony": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Back Booths": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Lobby": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Backroom Door": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Backroom Door_ed439d": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Dining Area": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "The Dance Floor": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Gateway to the East": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Back Alley": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Mingzhu Laundry": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Dragon's Den": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "The Phoenix's Nest": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Golden Temple of the Heavens": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Flea Market": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Zihao's House of Fighting Arts": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Daiyu's Tea Garden": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "Moldy Halls": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Decrepit Door": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Walter Gilman's Room": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Unknown Places_b538f8": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Unknown Places_7bea34": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Unknown Places": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Unknown Places_9a471d": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Unknown Places_0ac3ea": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Unknown Places_ea7a2b": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Unknown Places_713ec2": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Unknown Places_609112": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Strange Geometry": {"type": "fixed", "value": 1, "clueSide": "front"},
  "Site of the Sacrifice": {"type": "perPlayer", "value": 3, "clueSide": "back"},

  "Hangman's Brook": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Abandoned Chapel": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Haunted Fields": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "Lobby_1c2dfe": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Lobby_bcd556": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Lodge Gates_fa6a29": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Lodge Gates": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Lodge Cellar": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Lodge Cellar_8ea4fd": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Lounge": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Vault": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Inner Sanctum": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Library": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Library_47ccbc": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Sanctum Doorway": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Sanctum Doorway_4da6c3": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Sanctum Doorway_587a15": {"type": "perPlayer", "value": 0, "clueSide": "back"},

  "The Geist-Trap": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Forbidding Shore": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Unvisited Isle": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "Rivertown_92ee68": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Rivertown_db4b20": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Rivertown_ca2443": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Southside_c898a0": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Southside_e7f5fa": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Southside_9fed9d": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Silver Twilight Lodge": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Silver Twilight Lodge_17e686": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Hangman's Hill": {"type": "fixed", "value": 0, "clueSide": "back"},
  "Hangman's Hill_5f4d8a": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Cosmic Ingress": {"type": "fixed", "value": 3, "clueSide": "back"},
  "Cosmos": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Cosmos_a89dbf": {"type": "fixed", "value": 2, "clueSide": "back"},
  "Cosmos_1a0ad2": {"type": "fixed", "value": 2, "clueSide": "back"},
  "Cosmos_30fc53": {"type": "fixed", "value": 2, "clueSide": "back"},
  "Cosmos_8f3e16": {"type": "fixed", "value": 2, "clueSide": "back"},
  "Cosmos_4e8ae3": {"type": "fixed", "value": 2, "clueSide": "back"},
  "Cosmos_a8d84d": {"type": "fixed", "value": 4, "clueSide": "back"},
  "Cosmos_7a3ece": {"type": "fixed", "value": 6, "clueSide": "back"},
  "Cosmos_311eb1": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Cosmos_6bd5ca": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Cosmos_294c00": {"type": "fixed", "value": 2, "clueSide": "back"},

  "Seventy Steps": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Seven Hundred Steps": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Base of the Steps": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Enchanted Woods": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Stairwell": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Basement Door_42fa87": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Basement Door": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Waiting Room": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Emergency Room": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Experimental Therapies Ward": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Records Office": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "Foyer_9a9f9a": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Room 245": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Hotel Roof": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Office_b3ed47": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Room 212": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Basement": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Second Floor Hall": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Room 225": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Restaurant": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Suite Balcony": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Ulthar": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Dylath-Leen": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Mt. Ngranek": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Baharna": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Zulan-Thek": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Sarnath": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "City-Which-Appears-On-No-Map": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Celephaïs": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Nameless Ruins": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Kadatheron": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Ilek-Vad": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Ruins of Ib": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Temple of Unattainable Desires": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Hazuth-Kleg": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Serannian": {"type": "perPlayer", "value": 1, "clueSide": "front"},

  "Mysterious Stairs": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Mysterious Stairs_df1a40": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Attic_10faf9": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Unmarked Tomb": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Upstairs Doorway": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Front Porch": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Downstairs Doorway": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Downstairs Doorway_c93906": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Burial Ground": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Temple of the Moon Lizard": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "City of the Moon-Beasts": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Moon-Forest": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Dark Crater": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Caverns Beneath the Moon": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Black Core": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Light Side of the Moon": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "City of Gugs": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Vaults of Zin": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Plain of the Ghouls": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Sea of Bones": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Vale of Pnath": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Crag of the Ghouls": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Sea of Pitch": {"type": "perPlayer", "value": 1, "clueSide": "front"},

  "Plateau of Leng": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Cold Wastes": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Monastery of Leng": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Onyx Gates": {"type": "fixed", "value": 12, "clueSide": "back"},
  "Forsaken Tower": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "The Crater": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Quarantine Zone": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Quarantine Zone_5f2a9b": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Quarantine Zone_4a8e9c": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Quarantine Zone_5193e9": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Quarantine Zone_b3a920": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "The Great Web": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Great Web_39ace3": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "The Great Web_727790": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "The Great Web_5c5ec4": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "The Great Web_361fd7": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "The Great Web_dfdc8c": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "Expedition Camp": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Desert Oasis": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Untouched Vault": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Sands of Dashur": {"type": "perPlayer", "value": 0, "clueSide": "front"},
  "Sandswept Ruins": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Nile River": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Faceless Sphinx": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Dunes of the Sahara": {"type": "perPlayer", "value": 1, "clueSide": "front"},

  "Streets of Cairo": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Cairo Bazaar": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Temple Courtyard": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Museum of Egyptian Antiquities": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Outskirts of Cairo": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Eldritch Gate": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Mist-Filled Caverns": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Stairway to Sarkomand": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Tunnels under Ngranek": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "The Great Abyss": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "A Dream Betwixt": {"type": "perPlayer", "value": 0, "clueSide": "front"},

  "Velma's Doghouse": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Barkham City Pound": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Barkham Asylum": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Beasttown": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Tailside": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Slobbertown": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Snoutside": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Muttskatonic University": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Boneyard": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "St. Mary's Animal Hospital": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  
  "Arkham": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Streets of New York City": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Penthouse": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Burning Pit": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Streets of Providence": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Athenaeum of the Empty Sky": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Arcade": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Streets of Montréal": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Chateau Ramezay": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Shrine of Magh’an Ark’at": {"type": "perPlayer", "value": 1, "clueSide": "back"},

  "Unfamiliar Chamber": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Tidal Tunnel": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Tidal Tunnel_0f20fc": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Tidal Tunnel_d5566b": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Tidal Tunnel_dc9eb7": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Tidal Tunnel_513d82": {"type": "perPlayer", "value": 0, "clueSide": "back"},

  "First National Grocery": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Marsh Refinery": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Innsmouth Square": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Innsmouth Harbour": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Fish Street Bridge_b6b9b7": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Gilman House": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Little Bookshop": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "Innsmouth Jail_f63738": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "New Church Green_d1ef9c": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Sawbone Alley_899c2c": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "The House on Water Street_e4f53a": {"type": "perPlayer", "value": 2, "clueSide": "front"},
  "Shoreward Slums_24e42d": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Esoteric Order of Dagon_28c301": {"type": "perPlayer", "value": 1, "clueSide": "front"},

  "Esoteric Order of Dagon_ef8cef": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "New Church Green_921a9b": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Marsh Refinery_44c342": {"type": "fixed", "value": 1, "clueSide": "back"},
  "The House on Water Street_104e07": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "The Little Bookshop_a17a82": {"type": "fixed", "value": 1, "clueSide": "back"},
  "First National Grocery_9ae75c": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Fish Street Bridge_a358fc": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Innsmouth Harbour_30b2c0": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Sawbone Alley_e58cff": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Gilman House_e589b8": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Innsmouth Jail_755fc0": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Shoreward Slums_c0d0df": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Desolate Coastline": {"type": "fixed", "value": 1, "clueSide": "back"},

  "Unfathomable Depths_cb5e3e": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Unfathomable Depths_7d180e": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Unfathomable Depths_fdf43f": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Unfathomable Depths_431ca2": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Unfathomable Depths_dfc9b4": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Unfathomable Depths_086743": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Tidal Tunnel_0e611a": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Tidal Tunnel_b1a7f2": {"type": "perPlayer", "value": 2, "clueSide": "back"},

  "Old Innsmouth Road": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Old Innsmouth Road_07ba2e": {"type": "perPlayer", "value": 3, "clueSide": "back"},
  "Old Innsmouth Road_48b819": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Old Innsmouth Road_02e79c": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Old Innsmouth Road_27826a": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Old Innsmouth Road_dd62cc": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Old Innsmouth Road_687b03": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Old Innsmouth Road_eb3303": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Old Innsmouth Road_bebfba": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Old Innsmouth Road_c36e38": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Old Innsmouth Road_175a8a": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Old Innsmouth Road_d2c47a": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Old Innsmouth Road_095dac": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Old Innsmouth Road_fe2e46": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Old Innsmouth Road_f35c3d": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  
  "Falcon Point Cliffside": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Lighthouse Stairwell": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Lantern Room": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Lighthouse Keeper's Cottage": {"type": "perPlayer", "value": 2, "clueSide": "back"},
 
  "Tidal Tunnel_7eba72": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Tidal Tunnel_b4bcd8": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Tidal Tunnel_4ba689": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Tidal Tunnel_ffdbef": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  
  "First Floor Hall": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "First Floor Hall": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Second Floor Hall": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Second Floor Hall_b06d36": {"type": "fixed", "value": 1, "clueSide": "back"},
  "Third Floor Hall": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Lair of Dagon": {"type": "perPlayer", "value": 3, "clueSide": "back"},
  
  "Tidal Tunnel_01c28f": {"type": "fixed", "value": 1, "clueSide": "back"},
  
  "Y'ha-nthlei": {"type": "perPlayer", "value": 0, "clueSide": "back"},
  "Y'ha-nthlei_014f88": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Y'ha-nthlei_eca6a9": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Y'ha-nthlei_3e58ef": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Y'ha-nthlei_ce1a94": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Y'ha-nthlei Sanctum": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Lair of Dagon_819894": {"type": "perPlayer", "value": 3, "clueSide": "back"},
  "Lair of Hydra": {"type": "perPlayer", "value": 3, "clueSide": "back"},
  
  "Arkham Police Station": {"type": "fixed", "value": 4, "clueSide": "back"},
  
  "Senator Nathaniel Rhodes": {"type": "perPlayer", "value": 1, "clueSide": "front"},
  "Wine Cellar": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  "Wine Cellar_9d0410": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Wine Cellar_b882f3": {"type": "perPlayer", "value": 2, "clueSide": "back"},
  "Hidden Passageway": {"type": "perPlayer", "value": 1, "clueSide": "back"},
  
  "XXXX": {"type": "fixed", "value": 2, "clueSide": "back"},
  "xxx": {"type": "perPlayer", "value": 2, "clueSide": "back"}
}
]]
--[[
Player cards with token counts and types
]]
PLAYER_CARD_DATA_JSON = [[
{
  "Flashlight": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Shrivelling": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Shrivelling (3)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Grotesque Statue (4)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Forbidden Knowledge": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  ".45 Automatic": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Shotgun (4)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Liquid Courage": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Song of the Dead (2)": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Cover Up": {
  "tokenType": "clue",
  "tokenCount": 3
  },
  "Roland's .38 Special": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "First Aid": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Scrying": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  ".41 Derringer": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Painkillers": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Smoking Pipe": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Clarity of Mind": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Rite of Seeking": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "M1918 BAR (4)": {
  "tokenType": "resource",
  "tokenCount": 8
  },
  "Ornate Bow (3)": {
  "tokenType": "resource",
  "tokenCount": 1
  },
  ".41 Derringer (2)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Suggestion (4)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Chicago Typewriter (4)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Lupara (3)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "First Aid (3)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Springfield M1903 (4)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Springfield M1903 (4) (Taboo)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  ".32 Colt": {
  "tokenType": "resource",
  "tokenCount": 6
  },
  "Venturer": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Lockpicks (1)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Finn's Trusty .38": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  ".45 Automatic (2)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Lightning Gun (5)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Strange Solution (4)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Strange Solution (4):Acidic Ichor": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Strange Solution (4):Empowering Elixir": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Arcane Insight (4)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Archaic Glyphs (3)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "In the Know (1)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Rite of Seeking (4)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Alchemical Transmutation": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Scrying (3)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Shrivelling (5)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Mists of R'lyeh": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Mists of R'lyeh (4)": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Colt Vest Pocket": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Old Hunting Rifle (3)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Thermos": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Feed the Mind (3)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Seal of the Seventh Sign (5)": {
  "tokenType": "resource",
  "tokenCount": 7
  },
  "Flamethrower (5)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Flamethrower (5) (Taboo)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Pnakotic Manuscripts (5)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Kerosene (1)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Shards of the Void (3)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Try and Try Again (1)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Arcane Initiate": {
  "tokenType": "doom",
  "tokenCount": 1
  },
  "Detective's Colt 1911s": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Extra Ammunition (1)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Rite of Seeking (2)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Arcane Initiate (3)": {
  "tokenType": "doom",
  "tokenCount": 1
  },
  "Clarity of Mind (3)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Fingerprint Kit": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Truth from Fiction": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Enchanted Blade": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Tennessee Sour Mash": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Scroll of Secrets": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Scroll of Secrets (Taboo)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  ".45 Thompson": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Mr. \"Rook\"": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Mr. \"Rook\" (Taboo)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Scroll of Secrets (3):Seeker": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Scroll of Secrets (3) (Taboo):Seeker": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Scroll of Secrets (3):Mystic": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Scroll of Secrets (3) (Taboo):Mystic": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Enchanted Blade (3):Guardian": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Enchanted Blade (3):Mystic": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  ".45 Thompson (3)": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Esoteric Atlas (1)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Tennessee Sour Mash (3):Rogue": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Tennessee Sour Mash (3):Survivor": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Mk 1 Grenades (4)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Dayana Esperence (3)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Pendant of the Queen": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  ".32 Colt (2)": {
  "tokenType": "resource",
  "tokenCount": 6
  },
  "Alchemical Transmutation (2)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Suggestion (1)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Gate Box": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Tony's .38 Long Colt": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Gregory Gry": {
  "tokenType": "resource",
  "tokenCount": 9
  },
  "Scroll of Prophecies": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Healing Words": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Otherworld Codex (2)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  ".35 Winchester": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  ".35 Winchester (Taboo)": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Old Book of Lore (3)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Sawed-Off Shotgun (5)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Mind's Eye (2)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Colt Vest Pocket (2)": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Mists of R'lyeh (2)": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "The Chthonian Stone (3)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Flesh Ward": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Physical Training (4)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Encyclopedia": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Feed the Mind": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Forbidden Tome": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Esoteric Atlas (2)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "The Necronomicon (5)": {
  "tokenType": "resource",
  "tokenCount": 6
  },
  "The Necronomicon (5) (Taboo)": {
  "tokenType": "resource",
  "tokenCount": 6
  },
  "Mauser C96": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Liquid Courage (1)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Mauser C96 (2)": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Beretta M1918 (4)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Scrying Mirror": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Azure Flame": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Clairvoyance": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Ineffable Truth": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Grotesque Statue (2)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Azure Flame (3)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Clairvoyance (3)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Ineffable Truth (3)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Arcane Studies (4)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Azure Flame (5)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Clairvoyance (5)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Ineffable Truth (5)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  ".18 Derringer": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Grimm's Fairy Tales": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Old Keyring": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  ".18 Derringer (2)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Chainsaw (4)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Becky": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Book of Psalms": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Cryptographic Cipher": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  ".25 Automatic": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Obfuscation": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Eldritch Sophist": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Armageddon": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Eye of Chaos": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Shroud of Shadows": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Guided by the Unseen (3)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Eye of Chaos (4)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Shroud of Shadows (4)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Armageddon (4)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Hyperawareness (4)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Hard Knocks (4)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Dig Deep (4)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  ".25 Automatic (2)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Shrine of the Moirai (3)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Archive of Conduits": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Archive of Conduits (4)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Eon Chart (1)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Eon Chart (4)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Brand of Cthugha (1)": {
  "tokenType": "resource",
  "tokenCount": 6
  },
  "Brand of Cthugha (4)": {
  "tokenType": "resource",
  "tokenCount": 9
  },
  "True Magick (5)": {
  "tokenType": "resource",
  "tokenCount": 1
  },
  "Healing Words (3)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Close the Circle (1)": {
  "tokenType": "resource",
  "tokenCount": 1
  },
  "Bangle of Jinxes (1)": {
  "tokenType": "resource",
  "tokenCount": 1
  },
  "Jury-Rig": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Bandages": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Schoffner's Catalogue": {
  "tokenType": "resource",
  "tokenCount": 5
  },
  "Antiquary (3)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Crafty (3)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Bruiser (3)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Sleuth (3)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Prophetic (3)": {
  "tokenType": "resource",
  "tokenCount": 2
  },
  "Earthly Serenity (4)": {
  "tokenType": "resource",
  "tokenCount": 6
  },
  "Earthly Serenity (1)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Enchanted Bow (2)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Blur (4)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Blur (1)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Professor William Webb (2)": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Professor William Webb": {
  "tokenType": "resource",
  "tokenCount": 3
  },
  "Divination (4)": {
  "tokenType": "resource",
  "tokenCount": 6
  },
  "Divination (1)": {
  "tokenType": "resource",
  "tokenCount": 4
  },
  "Cover Up:Advanced": {
  "tokenType": "clue",
  "tokenCount": 4
  },
  
  "xxx": {
  "tokenType": "resource",
  "tokenCount": 3
  }
}
]]

-- Encounter Cards with Hidden.
HIDDEN_CARD_DATA = {
  "Visions in Your Mind (Death)",
  "Visions in Your Mind (Failure)",
  "Visions in Your Mind (Hatred)",
  "Visions in Your Mind (Horrors)",
  "Gift of Madness (Misery)",
  "Gift of Madness (Pity)",
  "Possession (Murderous)",
  "Possession (Torturous)",
  "Possession (Traitorous)",
  
  "Whispers in Your Head (Anxiety)",
  "Whispers in Your Head (Dismay)",
  "Whispers in Your Head (Doubt)",
  "Whispers in Your Head (Dread)",
  "Delusory Evils",
  "Hastur's Gaze",
  "Hastur's Grasp",
  
  "Law of 'Ygiroth (Chaos)",
  "Law of 'Ygiroth (Discord)",
  "Law of 'Ygiroth (Pandemonium)",
  "Nyarlathotep",
  "Restless Journey (Fallacy)",
  "Restless Journey (Hardship)",
  "Restless Journey (Lies)",
  "Whispering Chaos (East)",
  "Whispering Chaos (North)",
  "Whispering Chaos (South)",
  "Whispering Chaos (West)"
}

LOCATIONS_DATA = JSON.decode(LOCATIONS_DATA_JSON)
PLAYER_CARD_DATA = JSON.decode(PLAYER_CARD_DATA_JSON)

PLAYER_CARD_TOKEN_OFFSETS = {
  [1] = {
  { 0, 3, -0.2 },
  },
  [2] = {
  { 0.4, 3, -0.2 },
  { -0.4, 3, -0.2 },
  },
  [3] = {
  { 0, 3, -0.9 },
  { 0.4, 3, -0.2 },
  { -0.4, 3, -0.2 },
  },
  [4] = {
  { 0.4, 3, -0.9 },
  { -0.4, 3, -0.9 },
  { 0.4, 3, -0.2 },
  { -0.4, 3, -0.2 }
  },
  [5] = {
  { 0.7, 3, -0.9 },
  { 0, 3, -0.9 },
  { -0.7, 3, -0.9 },
  { 0.4, 3, -0.2 },
  { -0.4, 3, -0.2 }
  },
  [6] = {
  { 0.7, 3, -0.9 },
  { 0, 3, -0.9 },
  { -0.7, 3, -0.9 },
  { 0.7, 3, -0.2 },
  { 0, 3, -0.2 },
  { -0.7, 3, -0.2 },
  },
  [7] = {
  { 0.7, 3, -0.9 },
  { 0, 3, -0.9 },
  { -0.7, 3, -0.9 },
  { 0.7, 3, -0.2 },
  { 0, 3, -0.2 },
  { -0.7, 3, -0.2 },
  { 0, 3, 0.5 },
  },
  [8] = {
  { 0.7, 3, -0.9 },
  { 0, 3, -0.9 },
  { -0.7, 3, -0.9 },
  { 0.7, 3, -0.2 },
  { 0, 3, -0.2 },
  { -0.7, 3, -0.2 },
  { -0.35, 3, 0.5 },
  { 0.35, 3, 0.5 },
  },
  [9] = {
  { 0.7, 3, -0.9 },
  { 0, 3, -0.9 },
  { -0.7, 3, -0.9 },
  { 0.7, 3, -0.2 },
  { 0, 3, -0.2 },
  { -0.7, 3, -0.2 },
  { 0.7, 3, 0.5 },
  { 0, 3, 0.5 },
  { -0.7, 3, 0.5 },
  },
  [12] = {
  { 0.7, 3, -0.9 },
  { 0, 3, -0.9 },
  { -0.7, 3, -0.9 },
  { 0.7, 3, -0.2 },
  { 0, 3, -0.2 },
  { -0.7, 3, -0.2 },
  { 0.7, 3, 0.5 },
  { 0, 3, 0.5 },
  { -0.7, 3, 0.5 },
  { 0.7, 3, 1.2 },
  { 0, 3, 1.2 },
  { -0.7, 3, 1.2 },
  }

}

modeData = {
  ['Core Set'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } }
  },
  ['The Devourer Below'] = {
  easy = { parent = 'Core Set', append = { 'elder' }, message = 'An additional token for the preparation of this scenario has been added to the bag.' },
  normal = { parent = 'Core Set', append = { 'elder' }, message = 'An additional token for the preparation of this scenario has been added to the bag.' },
  hard = { parent = 'Core Set', append = { 'elder' }, message = 'An additional token for the preparation of this scenario has been added to the bag.' },
  expert = { parent = 'Core Set', append = { 'elder' }, message = 'An additional token for the preparation of this scenario has been added to the bag.' }
  },
  -----------------The Dunwich Legacy

  ['The Dunwich Legacy'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'cultist', 'red', 'blue' } }
  },
  ['The Miskatonic Museum'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['The Essex County Express'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Blood on the Altar'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Undimensioned and Unseen'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Where Doom Awaits'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Lost in Time and Space'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  -----------------The Path to Carcosa

  ['The Path to Carcosa'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'skull', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'skull', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'skull', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'skull', 'red', 'blue' } }
  },
  ['The Last King'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'skull', 'red', 'blue' }, random = { {'cultist', 'cultist'}, {'tablet', 'tablet'}, {'elder', 'elder'} } }
  },
  ['Echoes of the Past'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'skull', 'red', 'blue' }, random = { {'cultist', 'cultist'}, {'tablet', 'tablet'}, {'elder', 'elder'} } }
  },
  ['The Unspeakable Oath'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'skull', 'skull', 'skull', 'red', 'blue' }, random = { {'cultist', 'cultist'}, {'tablet', 'tablet'}, {'elder', 'elder'} } }
  },
  ['A Phantom of Truth'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'skull', 'skull', 'skull', 'red', 'blue' }, random = { {'cultist', 'cultist'}, {'tablet', 'tablet'}, {'elder', 'elder'} } }
  },
  ['The Pallid Mask'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'skull', 'skull', 'skull', 'red', 'blue' }, random = { {'cultist', 'cultist'}, {'tablet', 'tablet'}, {'elder', 'elder'} } }
  },
  ['Black Stars Rise'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'skull', 'red', 'blue' }, random = { {'cultist', 'cultist'}, {'tablet', 'tablet'}, {'elder', 'elder'} } }
  },
  ['Dim Carcosa'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'skull', 'red', 'blue' } }
  },
  -----------------The Forgotten Age

  ['The Forgotten Age'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm3', 'skull', 'skull', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm2', 'm2', 'm3', 'm5', 'skull', 'skull', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', 'm1', 'm2', 'm3', 'm3', 'm4', 'm6', 'skull', 'skull', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm6', 'm8', 'skull', 'skull', 'elder', 'red', 'blue' } }
  },
  ['The Doom of Eztli'] = {
  standalone = { token = { 'p1', '0', '0', '0','m1', 'm2', 'm2', 'm3', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Threads of Fate'] = {
  standalone = { token = { 'p1', '0', '0', '0','m1', 'm2', 'm2', 'm3', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['The Boundary Beyond'] = {
  standalone = { token = { 'p1', '0', '0', '0','m1', 'm2', 'm2', 'm3', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['The City of Archives'] = {
  standalone = { token = { 'p1', '0', '0', '0','m1', 'm2', 'm2', 'm3', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['The Depths of Yoth'] = {
  standalone = { token = { 'p1', '0', '0', '0','m1', 'm2', 'm2', 'm3', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Heart of the Elders'] = {
  standalone = { token = { 'p1', '0', '0', '0','m1', 'm2', 'm2', 'm3', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Shattered Aeons'] = {
  standalone = { token = { 'p1', '0', '0', '0','m1', 'm2', 'm2', 'm3', 'm4', 'm5', 'skull', 'skull', 'elder', 'red', 'blue' } }
  },

  -----------------The Circle Undone

  ['The Circle Undone'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm3', 'skull', 'skull', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'red', 'blue' } },
  hard = { token = { '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'skull', 'skull', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm6', 'm8', 'skull', 'skull', 'red', 'blue' } }
  },
  ["At Death's Doorstep"] = {
  standalone = { token = { 'p1', '0', '0', 'm1','m1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['The Secret Name'] = {
  standalone = { token = { 'p1', '0', '0', 'm1','m1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['The Wages of Sin'] = {
  standalone = { token = { 'p1', '0', '0', 'm1','m1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['For the Greater Good'] = {
  standalone = { token = { 'p1', '0', '0', 'm1','m1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Union and Disillusion'] = {
  standalone = { token = { 'p1', '0', '0', 'm1','m1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['In the Clutches of Chaos'] = {
  standalone = { token = { 'p1', '0', '0', 'm1','m1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Before the Black Throne'] = {
  standalone = { token = { 'p1', '0', '0', 'm1','m1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },


  -----------------The Dream-Eaters

  ['TDE_A'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'cultist', 'tablet', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'cultist', 'tablet', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'cultist', 'tablet', 'tablet', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'cultist', 'tablet', 'tablet', 'red', 'blue' } }
  },
  ['TDE_B'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'elder', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'elder', 'elder', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'elder', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'cultist', 'elder', 'elder', 'red', 'blue' } }
  },
  ['The Search For Kadath'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'tablet', 'red', 'blue' } }
  },
  ['A Thousand Shapes of Horror'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'elder', 'elder', 'red', 'blue' } }
  },
  ['Dark Side of the Moon'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'tablet', 'red', 'blue' } }
  },
  ['Point of No Return'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'skull', 'cultist', 'elder', 'elder', 'red', 'blue' } }
  },
  ['Where the Gods Dwell'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'tablet', 'red', 'blue' } }
  },
  ['Weaver of the Cosmos'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'skull', 'cultist', 'elder', 'elder', 'red', 'blue' } }
  },


  -----------------The Innsmouth Conspiracy
  ['The Innsmouth Conspiracy'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'elder', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'elder', 'elder', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'elder', 'elder', 'red', 'blue' } } ,
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'elder', 'elder', 'red', 'blue' } }
  },
  ['TIC_Standalone'] = {
  standalone = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'elder', 'elder', 'red', 'blue' } }
  },

  -----------------The Side Missions
  --official
  ['Curse of the Rougarou'] = {
  normal = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm5', 'm6', 'm8', 'skull', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Carnevale of Horrors'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm3', 'm4', 'm6', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm3', 'm4', 'm5', 'm6', 'm7', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['The Labyrinths of Lunacy'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'skull', 'skull', 'red', 'blue' } },
  hard = { token = { 'p1', '0','m1', 'm1', 'm1', 'm2', 'm2', 'm2', 'm3', 'm4', 'm5', 'm6', 'skull', 'skull', 'red', 'blue' } }
  },
  ['Guardians of the Abyss'] = {
  normal = { token = { 'p1', 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm6', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm7', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  },
  ['Excelsior'] = {
  normal = { token = { 'p1', '0', 'm1', 'm1', 'm2', 'm3', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', 'm1', 'm2', 'm3', 'm4', 'm4', 'm5', 'm6', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  },
  ['Read or Die'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'm6', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm7', 'm8', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['All or Nothing'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'm6', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm7', 'm8', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },

  ['Meowlathotep'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  
  ['WotOG'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'skull', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'skull', 'red', 'blue' } },
  hard = { token = { '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'm6', 'skull', 'skull', 'skull', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm7', 'm8', 'skull', 'skull', 'skull', 'red', 'blue' } }
  },
  
  ['Bad Blood'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'm6', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm7', 'm8', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },

  --fan-made
  ['Carnevale of Spiders'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm3', 'm4', 'm6', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm3', 'm4', 'm5', 'm6', 'm7', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },

  ['The Nephew Calls'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['The Outsider'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Stranger Things'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Winter Winds'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm3', 'skull', 'cultist', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'cultist', 'red', 'blue' } },
  hard = { token = { '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'm6', 'skull', 'cultist', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm7', 'm8', 'skull', 'cultist', 'red', 'blue' } }
  },
  ['The Festival'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm3', 'm4', 'm6', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm3', 'm4', 'm5', 'm6', 'm7', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Forbidding Desert'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'tablet', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'tablet', 'red', 'blue' } }
  },
  ['Happys Funhouse'] = {
  normal = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', '0', 'm1', 'm2', 'm3', 'm3', 'm5', 'm7', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Knightfall'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm5', 'm6', 'm8', 'cultist', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Last Call at Roxies'] = {
  easy = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm3', 'skull', 'elder', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'elder', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm7', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'elder', 'elder', 'red', 'blue' } }
  },
  ['The Limens of Belief'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'red', 'blue' } }
  },
  ['Blood Spilled in Salem'] = {
  normal = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm7', 'skull', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Bread and Circuses'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } }
  },
  ['Bridge of Sighs'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } }
  },
  ['The Collector'] = {
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } }
  },
  ['The Colour out of Space'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm5', 'm6', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['The Curse of Amultep'] = {
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } }
  },
  ['The Dying Star'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'blue', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm7', 'skull', 'skull', 'cultist', 'tablet', 'tablet', 'blue', 'red', 'blue' } }
  },
  ['Against the Wendigo'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm7', 'm8', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['The Pensher Wyrm'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'm6', 'skull', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm5', 'm6', 'm8', 'skull', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'elder', 'red', 'blue' } }
  },
  ['Approaching Storm'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', 'm1', 'm1', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Into the Shadowlands'] = {
  easy = { token = { 'p1', 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm3', 'm3', 'm4', 'm5', 'm6', 'm7', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } }
  },
  ['London Set 1'] = {
  easy = { token = { 'p2', 'p1', '0', '0', '0', 'm1', 'm2', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm2', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', 'm2', 'm4', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'tablet', 'red', 'blue' } },
  },
  ['London Set 2'] = {
  normal = { token = { 'p1', '0', '0', 'm1', 'm2', 'm3', 'skull', 'skull', 'elder', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', 'm1', 'm2', 'm3', 'skull', 'skull', 'elder', 'elder', 'tablet', 'red', 'blue' } },
  },
  ['London Set 3'] = {
  normal = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  },
  ['Delta Green'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm2', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  },
  ['Jennys Choice'] = {
  easy = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4','skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', 'm1', 'm2', 'm2', 'm3', 'm3', 'm5', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['The Blob'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  },
  ['The Initiation'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm3', 'skull', 'skull', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm2', 'm2', 'm3', 'm5', 'skull', 'skull', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', 'm1', 'm2', 'm3', 'm3', 'm4', 'm6', 'skull', 'skull', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm6', 'm8', 'skull', 'skull', 'elder', 'red', 'blue' } }
  },
  ['Consternation'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm4', 'm5', 'm6', 'skull', 'skull', 'skull', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm4', 'm5', 'm6', 'm7', 'skull', 'skull', 'skull', 'red', 'blue' } },
  },
  ['Of Sphinx'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'skull', 'elder', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'elder', 'cultist', 'cultist', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'skull', 'elder', 'cultist', 'cultist', 'tablet', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'elder', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } }
  },
  ['Ordis'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'elder', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'elder', 'cultist', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'elder', 'cultist', 'tablet', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'elder', 'cultist', 'tablet', 'red', 'blue' } }
  },
  ['Darkness Falls'] = {
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } }
  },
  ['War of the Worlds'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'm6', 'skull', 'skull', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'elder', 'red', 'blue' } }
  },
  ['Alice in Wonderland'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'm5', 'm6', 'skull', 'skull', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm7', 'm8', 'skull', 'skull', 'elder', 'red', 'blue' } }
  },
  ['Pokemon'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm3', 'skull', 'skull', 'tablet', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm2', 'm2', 'm3', 'm5', 'skull', 'skull', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', 'm1', 'm2', 'm3', 'm3', 'm4', 'm6', 'skull', 'skull', 'tablet', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm6', 'm8', 'skull', 'skull', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Safari'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm2', 'm2', 'm3', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', 'm1', 'm2', 'm3', 'm3', 'm4', 'm6', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  },
  ['Cerulean'] = {
  normal = { token = { 'p1', '0', '0', '0', 'm1', 'm2', 'm2', 'm3', 'm5', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', 'm1', 'm2', 'm3', 'm3', 'm4', 'm6', 'skull', 'skull', 'cultist', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  },
  ['Erich Zann'] = {
  easy = { token = { 'p1', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  normal = { token = { 'p1', '0', 'm1', 'm1', 'm2', 'm3', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', 'm1', 'm2', 'm3', 'm4', 'm4', 'm5', 'm6', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } }
  },
  ['Kaimonogatari'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'skull', 'skull', 'cultist', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm2', 'm2', 'm3', 'm4', 'm4', 'm5', 'skull', 'skull', 'cultist', 'red', 'blue' } },
  expert = { token = { '0', '0', 'm1', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm6', 'm8', 'skull', 'skull', 'cultist', 'red', 'blue' } }
  },
  ['Sleepy Hollow'] = {
  normal = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  },
  ['Flesh'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm3', 'skull', 'skull', 'cultist', 'tablet', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', 'm1', 'm1', 'm2', 'm3', 'm3', 'm4', 'm4', 'm6', 'skull', 'skull', 'cultist', 'tablet', 'tablet', 'red', 'blue' } },
  },
  ['Dark Matter'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'cultist', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'cultist', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'cultist', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'cultist', 'cultist', 'red', 'blue' } }
  },
  ['Dont Starve'] = {
  normal = { token = { 'p1', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  hard = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm5', 'm7', 'skull', 'skull', 'cultist', 'tablet', 'elder', 'red', 'blue' } },
  },
  ['XXXX'] = {
  easy = { token = { 'p1', 'p1', '0', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  normal = { token = { 'p1', '0', '0', 'm1', 'm1', 'm1', 'm2', 'm2', 'm3', 'm4', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  hard = { token = { '0', '0', '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm5', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } },
  expert = { token = { '0', 'm1', 'm1', 'm2', 'm2', 'm3', 'm3', 'm4', 'm4', 'm5', 'm6', 'm8', 'skull', 'skull', 'cultist', 'tablet', 'red', 'blue' } }
  },

}

function onSave()
  local globalState = JSON.encode(SPAWNED_PLAYER_CARD_GUIDS)
  log('saving global state:  ' .. globalState)
  self.script_state = globalState
end

function onload(save_state)
  if save_state ~= '' then
  log('loading global state:  ' .. save_state)
  SPAWNED_PLAYER_CARD_GUIDS = JSON.decode(save_state)
  else
  SPAWNED_PLAYER_CARD_GUIDS = {}
  end
end

function getSpawnedPlayerCardGuid(params)
  local guid = params[1]
  if SPAWNED_PLAYER_CARD_GUIDS == nil then
  return nil
  end
  return SPAWNED_PLAYER_CARD_GUIDS[guid]
end

function setSpawnedPlayerCardGuid(params)
  local guid = params[1]
  local value = params[2]
  if SPAWNED_PLAYER_CARD_GUIDS ~= nil then
  SPAWNED_PLAYER_CARD_GUIDS[guid] = value
  return true
  end
  return false
end

function checkHiddenCard(name)
  for _, n in ipairs(HIDDEN_CARD_DATA) do
    if name == n then
      return true
    end
  end
  return false
end

function updateHiddenCards(args)
    local custom_data_helper = getObjectFromGUID(args[1])
    local data_hiddenCards = custom_data_helper.getTable("HIDDEN_CARD_DATA")
    for k, v in ipairs(data_hiddenCards) do
        table.insert(HIDDEN_CARD_DATA, v)
    end
end