# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Plot.create! [{
  title: "The Entrance",
  description: "At the beginning there was only one. One Place, this place. You are standing in an open field surrounded with mystery, the grass beneath your feet is a lush green hue, The sky above you is grey and unforgiving, a feeling of uncertainty abounds. A fallen oak tree lies to your left it's trunk is filled with pits an hollows, on its side is written an inscription. 'Welcome to the Abyss', you feel tired.",
  x: 0,
  y: 0
}]

Plot.create! [{ 
  title: "The Forest",
  description: "Leaves crunch underfoot as you enter the forest, you can smell the musty earthy sent of old life. the trees here are tall and sturdy, their permenenace seems beyond reckoning. Tiny squirrels chase each other along the branches and in the distance you can hear the rough bark of a fox. The forest seems active yet peaceful.",
  x: 0,
  y: 1
}]

Plot.create! [{
  title: "The Cave",
  description: "You are standing in the entrance to a cave. The thick stone walls provide shelter from the elements, the filtered sunlight allows tiny motes of sunlight the dance into visibility for fleeting moments, it seems peaceful here.",
  x: 0,
  y: -1
}]

Plot.create! [{
  title: "The Beach",
  description: "Stumbling over the shingle you reach a deserted beach. The sea seems restless, wistful, melancholy and a whole list of other projected emotions that people ascribe to a lifeless body of water. The safety of the water is poor at best. A dead fox lies half in half out of the water, it's bright red fur has been leeched away by time and decay. The puddle of red and brown from the fox slowly diffusses into the grey green of the sea.",
  x: 1,
  y: 0
}]

Plot.create! [{
  title: "The Clearing",
  description: "The trees thin out and give way to a clearing. A hut stands here dwarfed by the old trunks around it. A rudimentary fence has been built around the hut, and within its bounds you can see the remains of a fire. A smell of embers reaches you on the breeze. <br><br>A large tractor is parked behind the hut with a plough attached to the back. On the driver's seat there is a scrap of fox fur, which on closer inspection turns out to be a home-made hat.<br><br>Squinting through the iron talons of the plough you can make out a distant figure among the trees, but when you try to move towards it, it vanishes.<br>",
  x: 1,
  y: 0
}]
