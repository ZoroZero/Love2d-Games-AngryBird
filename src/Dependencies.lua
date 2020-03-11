push = require 'lib/push';

Class = require 'lib/class';

Timer = require 'lib/knife.timer'

Event = require 'lib/knife.event'

-- Constants
require 'src/constants'

-- State 
require 'src/StateMachine'

-- Ultility functions
require 'src/Ultil'

-- Level generation file

-- Game component
require 'src/Alien'
require 'src/Background'
require 'src/Obstacle'
require 'src/Level'
-- Game world


-- Game states
require 'src/states/BaseState'

require 'src/states/StartState'
require 'src/states/PlayState'
-- require 'src/states/game/GameOverState'

