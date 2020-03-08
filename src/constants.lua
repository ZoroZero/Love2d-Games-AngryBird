require 'src/Ultil'

-- WINDOW DIMENSIONS
WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

-- VIRTUAL DIMENSIONS
VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216;

-- TILE SIZE
TILE_SIZE = 16;



-- SOUND
game_Sounds = {
    -- ['door'] = love.audio.newSource('assets/sounds/door.wav', 'static'),
    -- ['hit_enemy'] = love.audio.newSource('assets/sounds/hit_enemy.wav', 'static'),
    -- ['hit_player'] = love.audio.newSource('assets/sounds/hit_player.wav', 'static'),
    -- ['music'] = love.audio.newSource('assets/sounds/music.mp3', 'static'),
    -- ['sword'] = love.audio.newSource('assets/sounds/sword.wav', 'static'),
    -- ['death'] = love.audio.newSource('assets/sounds/death.wav', 'static'),
    -- ['pickup'] = love.audio.newSource('assets/sounds/pickup.wav', 'static'),
    -- ['confirm'] = love.audio.newSource('assets/sounds/confirm.wav', 'static')
}

-- FONT
game_Fonts = {
    ['smallFont'] = love.graphics.newFont('assets/fonts/font.ttf', 8),
    ['mediumFont'] = love.graphics.newFont('assets/fonts/font.ttf', 16),
    ['largeFont'] = love.graphics.newFont('assets/fonts/font.ttf', 24),
}

-- TEXTURE
game_Textures = {
    -- ['background'] = love.graphics.newImage('assets/graphics/background.png'),
}


-- GAME FRAMES
game_Frames = {
}
