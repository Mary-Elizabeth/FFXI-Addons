-- Add items to existing profiles or create your own to sell groups of items using alias commands
local profiles = {}

profiles['furrow'] = S{
	'Acorn',
	'Arrowwood Log',
	'Ash Log',
	'Dryad Root',
	'Ether',
	'Faerie Apple',
	'Little worm',
	'Rolanberry',
	'date',
	'Eggplant',
	'Lacquer Tree Log',
	'Maple Log',
	'Ronfaure Chestnut',
	'Stone II',
	'Earth Spirit',
	--'Stone', -- [Scroll of Stone] can't be sold to NPC's
	'Wind Crystal',
	--'Ice Crystal',
	--'Dark Crystal',
	--'Light Crystal',
	--'Fire Crystal',
	--'Water Crystal',
	--'Earth Crystal',
	--'Lightng. Crystal',
}

profiles['void'] = S{
	'Mythril Ore',
	'Darksteel Ore',
	'Turquoise',
	'Humus',
	'Garnet',
	'Pro-ether',
	'Lycopodium flower',
	'Ram horn',
	'x-potion +3',
	'Demon horn',
	'Platinum Ore',
	'Peridot',
	'Purple rock',
	'Black rock',
	'Blue Rock',
	'Red Rock',
	'Green Rock',
	'White Rock',
	'Lapis lazuli',
	'Black pearl',
	'Ebony log',
	'Mythril beastcoin',
	'Ram skin',
	'goshenite',
	'Rosewood log',
	'Painite',
	'King Truffle',
	'Ancient Beast Horn',
	'Ebony Log',
	'Chrysoberyl',
	'Moonstone',
	'Fluorite',
	'Mahogany Log',
	'Zircon',
	'Pro-Ether',
	'Pro-Ether +1',
	'Ruszor Meat',
	'Hi-Elixir',
	'Hydra Scale',
	'Steel Ingot',
	'Darksteel Ingot',
	'Mythril Ingot',
	'Jadeite',
	'Petrified log',
	'Aquamarine',
	'Coral Fragment',
	'Phrygian ore',
	'Gold ore',
	'Durium Ore',
	'Wyvern Scales',
	'Vitality Potion',
	'Dexterity Potion',
	'Malboro Vine',
	'Clot Plasma',
	'Sphene',
	'Gold Beastcoin',
	'Oak Log',
	'Copper Ore',
	'Granite',
	'Silver Ingot',
	'Light Opal',
	'Ametrine',
	'Slime oil',
	'Chestnut log',
	'Zinc ore',
	'Rock Salt',
	'Crab Shell',
	'Amethyst',
	'Sunstone',
	'Persikos',
	'Beech Log',
	'Gold Ingot',
	'Gold Thread',
	'Icarus Wing',
	'Light Crystal',
	'Flocon-de-mer',
	'Jacaranda log',
	'Translucent Rock',
	'Emperor Fish',
	'Fiendish skin',
	'Wyvern Skin',
	'Int. Potion',
	'Elixir',
	'Hi-Potion +2',
	'Teak Log',
	'Light Cluster',
	'Breeze Geode',
	'Magic Pot Shard',
	'Yellow Rock',
	'Hi-potion +3',
	'Khimaira Mane',
	'Kejusu Satin',
	'W. Spiders Web',
	'Wyvern Tailskin',
	'Agility Potion',
	'Mind Potion',


}
profiles['shield'] = S{
	'Acheron shield',

	--'Stone', -- [Scroll of Stone] can't be sold to NPC's
	--'Wind Crystal',
	--'Ice Crystal',
	--'Dark Crystal',
	--'Light Crystal',
	--'Fire Crystal',
	--'Water Crystal',
	--'Earth Crystal',
	--'Lightng. Crystal',
}
profiles['junk'] = S{
	'Ahriman Lens',
	'Porxie Pork',
	'light crystal',
	'Shadow Geode',
	'Ahriman Wing',
	'Herb Seeds',
	'Fiend Blood',
	'Durium Sheet',
	'Ahriman Tears',
	'Snow Geode',
	'Soil Geode',
	'Light Geode',
	'Breeze Geode',
	'Thunder Geode',
	'Aqua Geode',
	'Flame Geode',
	'Voidsnapper',
	'void crystal',
	'porxie wing',
	'wind crystal',
	'Water lily',
	'eschalixir',
	'Shivite',
	'Garudite',
	'Leviatite',
	'Fenrite',
	'Ifritite',
	'Carbite',
	'Ramuite',
	'Titanite',
	'Colibri beak',
	'Colibri Feather',
	'Velkk Necklace',
	'Iron Sand',
	'Airlixir',
	'Winterflower',
	'Veydal Wrasse',
	'Ryugu Titan',
	'Yagudo Cherry',
	'Shakudo Ingot',
	'Apple Pie',
	'Kopparnickel Ore',
	'Zinc Ore',
	'Aht Urhgan Brass',
	'Ogre Pumpkin',
	'Kazham pineapple',
	'Faded Crystal',
	'Carrier Crab Carapace',
	'Kazham Peppers',
	'Mhaura Garlic',
	'Vanilla',
	'Sage',
	'Deathball',
	'Voay Sword -1',
	'Black Pepper',
	'Habaneros',
	'Bay Leaves',
	'Fire Fewell',
	'Earth Fewell',
	'Water Fewell',
	'Wind Fewell',
	'Ice Fewell',
	'Lightning Fewell',
	'Dark Fewell',
	'Light Fewell',
	'Potion',
	'Potion +2',
	'Cobalt Jellyfish',
	'Shall Shell',
	'Dragon Fruit',
	'Gigant Squid',
	'Bluetail',
	'Mackerel',
	'Moorish Idol',
	'Grimmonite',
	'Millioncorn',
	'Kukuru Bean',
	'Puffball',
	'Sunflower Seeds',
	'Poison Flour',
	'Blue Peas',
	'Pugil Scales',
	'Uragnite Shell',
	'Ram Horn',
	'Dragon Bone',
	'Turtle Shell',
	'Fish Bones',
	'Pebble',
	'H.Q. Scp. Shell',
	'Bone Chip',
	'Meteorite',
	'Elshimo Newt',
	'Moat Carp',
	'Copper Frog',
	'Gavial Fish',
	'Crescent Fish',
	'Giant Catfish',
	'Ca Cuong',
	'Yorchete',
	'Bat Wing',
	'Pamamas',
	'Walnut',
	'Arrowwood Log',
	'King Locust',
	'El. Pachira Fruit',
	'Flax Flower',
	'Skull Locust',
	'Wijnruit',
	'Red Rose',
	'Watermelon',
	'Red Moko Grass',
	'Dark Bass',
	'Gold Carp',
	'Black Eel',
	'Igneous Rock',
	'Snapping Mole',
	'Tin Ore',
	'Scorpion Shell',
	'H.Q. Crab Shell',
	'Scorpion Claw',
	'Marguerite',
	'Ulbukan Lobster',
	'Yayinbaligi',
	'Pipira',
	'Ruddy Seema',
	'Eggplant',
	'Saruta Cotton',
	'Ulbuconut',
	'Antlion Jaw',
	'Copper Ore',
	'Auric Sand',
	'Voay Staff -1',
	'Contortopus',
	'Adoulinian Kelp',
	'Black Prawn',
	'Black Sole',
	'Dragon Talon',
	'Beetle Jaw',
	'Crab Shell',
	'Brass Loach',
	'Rusty Bucket',
	'Ash Log',
	'Spider Web',
	'Fresh Marjoram',
	'Yagudo Drink',
	'Three-eyed Fish',
	'Cone Calamary',
	'Zebra Eel',
	'Quus',
	'Bastore Bream',
	'Titanictus',
	'Rye Flour',
	'Crayfish',
	'Insect Wing',
	'Rolanberry',
	'Napa',
	'Bloodblotch',
	'Bat Fang',
	'Fresh Mugwort',
	'Pine Nuts',
	'Crawler Cocoon',
	'Acorn',
	'Black Ghost',
	'Faerie Apple',
	'Red Terrapin',
	'Barnacle',
	'Little Worm',
	'Vegetable Seeds',
	'Chestnut',
	'Coral Fungus',
	'Dwarf Remora',
	'Win. Tea Leaves',
	'Blk. Tiger Fang',
	'Bugard Tusk',
	'Loc. Elutriator',
	'Senroh Sardine',
	'Giant Stinger',
	'Burdock',
	'La Theine Cbg.',
	'Grain Seeds',
	'Pumpkin Pie',
	'Nopales',
	'Dryad Root',
	'Crawler Egg',
	'Semolina',
	'Tiny Goldfish',
	'Woozyshroom',
	'Dragonfish',
	'Flint Stone',
	'Velkk Necklace',
	'Velkk Mask',
	'Matamata Shell',
	'Moko Grass',
	'Emperor Fish',
	'Isleracea',
	'Cactus Stems',
	'Wivre Maul',
	'Raptor Skin',
	'Peiste Skin',
	'Slime Juice',
	'Infinity Core',
	'Acheron Shield',
	'Prism Powder'
}
profiles['garden'] = S{
'Winterflower',
'Veydal Wrasse',
'Burdock',
'Herb Seeds',
'Ogre Pumpkin',
'Kazham pineapple',
'Eggplant',
'Date',
'Little worm',
'Rolanberry',
'Eggplant',
'Potion',
'Gugru Tuna',
'Cobalt Jellyfish',
'Shall Shell',
'Dragon Fruit',
'Gigant Squid',
'Bluetail',
'Mackerel',
'Moorish Idol',
'Grimmonite',
'Millioncorn',
'Kukuru Bean',
'Puffball',
'Sunflower Seeds',
'Poison Flour',
'Blue Peas',
'Kopparnickel Ore',
'Pugil Scales',
'Uragnite Shell',
'Ram Horn',
'Dragon Bone',
'Turtle Shell',
'Swamp Ore',
'Fish Bones',
'Aht Urhgan Brass',
'Iron Ore',
'Gold Ore',
'Pebble',
'Platinum Ore',
'H.Q. Scp. Shell',
'Bone Chip',
'Meteorite',
'Phrygian Ore',
'Zinc Ore',
'Elshimo Newt',
'Moat Carp',
'Copper Frog',
'Gavial Fish',
'Crescent Fish',
'Giant Catfish',
'Ca Cuong',
'Yorchete',
'Pamamas',
'Walnut',
'Guatambu Log',
'Chestnut Log',
'Arrowwood Log',
'Maple Log',
'Grove Cuttings',
'Walnut Log',
'Elm Log',
'Urunday Log',
'Dogwood Log',
'Mahogany Log',
'King Locust',
'Yagudo Cherry',
'Divine Log',
'Oak Log',
'El. Pachira Fruit',
'Flax Flower',
'Skull Locust',
'Wijnruit',
'Red Rose',
'Watermelon',
'Red Moko Grass',
'Dark Bass',
'Gold Carp',
'Black Eel',
'Igneous Rock',
'Snapping Mole',
'Darksteel Ore',
'Khroma Ore',
'Tin Ore',
'Scorpion Shell',
'H.Q. Crab Shell',
'Scorpion Claw',
'Marguerite',
'Ulbukan Lobster',
'Yayinbaligi',
'Pipira',
'Ruddy Seema',
'Eggplant',
'Saruta Cotton',
'Ulbuconut',
'Antlion Jaw',
'Copper Ore',
'Auric Sand',
'Dst. Nugget',
'Orichalcum Ore',
'Vanadium Ore',
'Voay Staff -1',
'Contortopus',
'Adoulinian Kelp',
'Black Prawn',
'Black Sole',
'Dragon Talon',
'Mythril Ore',
'Beetle Jaw',
'Crab Shell',
'Brass Loach',
'Rusty Bucket',
'Tree Cuttings',
'Ash Log',
'Spider Web',
'Fresh Marjoram',
'Yagudo Drink',
'Three-eyed Fish',
'Cone Calamary',
'Zebra Eel',
'Quus',
'Bastore Bream',
'Titanictus',
'Tarutaru Rice',
'Rye Flour',
'Adaman Ore',
'Crayfish',
'Lacquer Tree Log',
'Insect Wing',
'Rolanberry',
'Napa',
'Lesser Chigoe',
'Bloodblotch',
'Bat Fang',
'Ebony Log',
'Fresh Mugwort',
'Pine Nuts',
'Crawler Cocoon',
'Acorn',
'Black Ghost',
'Faerie Apple',
'Red Terrapin',
'Barnacle',
'Little Worm',
'Vegetable Seeds',
'Chestnut',
'Coral Fungus',
'Dwarf Remora',
'Win. Tea Leaves',
'Blk. Tiger Fang',
'Wootz Ore',
'Bugard Tusk',
'Loc. Elutriator',
'Senroh Sardine',
'Silver Ore',
'Green Rock',
'Giant Stinger',
'Burdock',
'La Theine Cbg.',
'Grain Seeds',
'Pumpkin Pie',
'Nopales',
'Dryad Root',
'Crawler Egg',
'Semolina',
'Tiny Goldfish',
'Woozyshroom',
'Dragonfish',
'Flint Stone',
'Velkk Necklace',
'Velkk Mask',
'Matamata Shell',
'Titanium Ore',
'Moko Grass',
'Emperor Fish',
'Isleracea',
'Cactus Stems',
'Wivre Maul',
'Bismuth Ore'}

return profiles
