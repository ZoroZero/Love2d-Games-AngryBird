Background = Class{}


BACKGROUND_TYPE = {'blue_desert', 'blue_land', 'blue_mushroom', 'blue_grass',
'colored_grass', 'colored_desert', 'colored_land', 'colored_mushroom', 'colored_grass' }
-- INIT
function Background:init()
    self.background = BACKGROUND_TYPE[math.random(#BACKGROUND_TYPE)];
    self.offset_X = 0;
    self.width = game_Textures[self.background]:getWidth(); 
end

-- UPDATE
function Background:update(dt)
    if love.graphics.wasPressed('left') then 
        self.offset_X = self.offset_X - BACKGROUND_SCROLLING_SPEED*dt;
    elseif love.graphics.wasPressed('right') then
        self.offset_X = self.offset_X + BACKGROUND_SCROLLING_SPEED*dt;
    end
    
    self.offset_X = self.offset_X % self.width;
end

-- RENDER
function Background:render()
    -- body
    love.graphics.draw(game_Textures[self.background], self.offset_X, -128);
    love.graphics.draw(game_Textures[self.background], self.offset_X + self.width, -128);
    love.graphics.draw(game_Textures[self.background], self.offset_X - self.width, -128);
end