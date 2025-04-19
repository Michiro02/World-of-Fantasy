function EncounterData(){
	
global.encounter_data = {
    "Field": {
        enemies: [
           	[global.enemies.slimeG,global.enemies.slimeG,global.enemies.bat],
			[global.enemies.slimeG,global.enemies.slimeG],
			[global.enemies.slimeG,global.enemies.bat,global.enemies.bat,global.enemies.bat,global.enemies.bat],
			[global.enemies.slimeG,global.enemies.slimeG,global.enemies.slimeG,global.enemies.slimeG,global.enemies.slimeG],
			[global.enemies.slimeG,global.enemies.bat],
			[global.enemies.slimeG,global.enemies.slimeG, global.enemies.slimeG, global.enemies.bat],
        ],
        background: sBgField
    },
    "Mushroom_Forest": {
        enemies: [
            [global.enemies.mush, global.enemies.mush, global.enemies.bat],
            [global.enemies.mush, global.enemies.mush, global.enemies.mush, global.enemies.mush],
            [global.enemies.Gatoris, global.enemies.mush],
			[global.enemies.Gatoris, global.enemies.Skyhawk],
			[global.enemies.behemoth, global.enemies.behemoth, global.enemies.mush],
			[global.enemies.behemoth, global.enemies.behemoth, global.enemies.behemoth]
        ],
        background: sBgMush
    },
    "Desert": {
        enemies: [
            [global.enemies.tonberry],
            [global.enemies.tonberry, global.enemies.tonberry],
            [global.enemies.Tuskbreaker, global.enemies.Blazefang],
			[global.enemies.centipede, global.enemies.centipede],
			[global.enemies.Blazefang, global.enemies.tonberry],
			[global.enemies.Tuskbreaker, global.enemies.Lynxara]
        ],
        background: sBgNewDesert
		},
	"Tower": {
        enemies: [
            [global.enemies.IronGiant, global.enemies.IronGiant],
            [global.enemies.IronGiant],
            [global.enemies.IronGiant, global.enemies.RedGiant],
			[global.enemies.RedGiant],
			[global.enemies.RedGiant, global.enemies.RedGiant],
			[global.enemies.RedGiant, global.enemies.IronGiant]
        ],
        background: sBgNewBoss
		}
	};
}