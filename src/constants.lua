require 'src/Ultil'

-- WINDOW DIMENSIONS
WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

-- VIRTUAL DIMENSIONS
VIRTUAL_WIDTH = 640;
VIRTUAL_HEIGHT = 360;

-- TILE SIZE
TILE_SIZE = 16;

-- BACKGROUND SCROLLING SPEED
BACKGROUND_SCROLLING_SPEED = 50;

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
    ['alien'] = love.graphics.newImage('assets/graphics/aliens.png'),
    ['blue_desert'] = love.graphics.newImage('assets/graphics/blue_desert.png'), 
    ['blue_land'] = love.graphics.newImage('assets/graphics/blue_land.png'), 
    ['blue_mushroom'] = love.graphics.newImage('assets/graphics/blue_shroom.png'),
    ['blue_grass'] = love.graphics.newImage('assets/graphics/blue_grass.png'),
    ['colored_grass'] = love.graphics.newImage('assets/graphics/colored_grass.png'), 
    ['colored_desert'] = love.graphics.newImage('assets/graphics/colored_desert.png'),
    ['colored_land'] = love.graphics.newImage('assets/graphics/colored_land.png'),
    ['colored_mushroom'] = love.graphics.newImage('assets/graphics/colored_shroom.png'),
}


-- GAME FRAMES
game_Frames = {
    ['alien'] = generateQuad(game_Textures['alien'], 35, 35)
}
