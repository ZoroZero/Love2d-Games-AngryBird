PlayState = Class{__includes = BaseState}

-- INIT
function PlayState:init() 
    self.level = Level();
    self.level_Translate_X = 0;
end


-- UPDATE
function PlayState:update(dt) 
    if love.keyboard.isDown('left') then 
        self.level_Translate_X = self.level_Translate_X - BACKGROUND_SCROLLING_SPEED*dt
        if self.level_Translate_X < -VIRTUAL_WIDTH then 
            self.level_Translate_X = -VIRTUAL_WIDTH;
        else
            self.level.background:update(dt);
        end
    elseif  love.keyboard.isDown('right') then 
        self.level_Translate_X = self.level_Translate_X + BACKGROUND_SCROLLING_SPEED*dt
        if self.level_Translate_X > VIRTUAL_WIDTH then 
            self.level_Translate_X = VIRTUAL_WIDTH;
        else
            self.level.background:update(dt);
        end
    end 

    self.level:update(dt)
end

-- RENDER
function PlayState:render() 


    -- render level back ground
    self.level.background:render();

    love.graphics.translate(-math.floor(self.level_Translate_X), 0)
    -- render level
    self.level:render();
end
