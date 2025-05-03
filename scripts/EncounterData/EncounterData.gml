function EncounterData(){
	
global.encounter_data = {
    "Field": {
        enemies: [
			[global.enemies.goblin,global.enemies.goblin],
			[global.enemies.goblin,global.enemies.goblin,global.enemies.karnak],
			[global.enemies.goblin,global.enemies.karnak,global.enemies.karnak],
			[global.enemies.goblin,global.enemies.goblin,global.enemies.goblin,global.enemies.karnak],
			[global.enemies.goblin,global.enemies.karnak],
			[global.enemies.goblin,global.enemies.goblin, global.enemies.goblin],
			[global.enemies.karnak, global.enemies.karnak],
			[global.enemies.goblin],
			[global.enemies.karnak]
        ],
        background: sBgField
    },
    "Mushroom_Forest": {
        enemies: [
            [global.enemies.mush, global.enemies.mush, global.enemies.karnak],
            [global.enemies.Mammon, global.enemies.mush, global.enemies.mush],
            [global.enemies.Gatoris, global.enemies.Mandrake],
			[global.enemies.Gatoris, global.enemies.Skyhawk],
			[global.enemies.behemoth, global.enemies.behemoth, global.enemies.Mandrake],
			[global.enemies.behemoth, global.enemies.behemoth, global.enemies.behemoth],
			[global.enemies.Skyhawk, global.enemies.Skyhawk],
			[global.enemies.behemoth],
			[global.enemies.Skyhawk]	
        ],
        background: sBgMush
    },
    "Desert": {
        enemies: [
            [global.enemies.tonberry],
            [global.enemies.SandCrawler, global.enemies.tonberry],
            [global.enemies.Tuskbreaker, global.enemies.Blazefang],
			[global.enemies.centipede, global.enemies.centipede],
		    [global.enemies.Tuskbreaker, global.enemies.Lynxara],
			[global.enemies.golem, global.enemies.golem],
			[global.enemies.Lamia, global.enemies.Doublizard],
			[global.enemies.TerraDrake],
			[global.enemies.Chimera]
        ],
        background: sBgNewDesert
		},
	"Tower": {
        enemies: [
            [global.enemies.IronGiant, global.enemies.IronGiant],
            [global.enemies.IronGiant],
			[global.enemies.RedGiant],
			[global.enemies.RedGiant, global.enemies.RedGiant],
			[global.enemies.RedGiant, global.enemies.IronGiant],
			[global.enemies.Imp, global.enemies.Imp],
			[global.enemies.Warlock],
			[global.enemies.Hexmire],
			[global.enemies.Warlock, global.enemies.Hexmire]
        ],
        background: sBgNewBoss
		}
	};
}