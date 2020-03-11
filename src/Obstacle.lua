Obstacle = Class{}

-- INIT
function Obstacle:init(world, shape, x, y)
    self.x = x;
    self.y = y; 
    
    -- world
    self.world = world;

    -- shape
    self.shape = shape or 'horizontal';

    -- texture frame
    if self.shape == 'horizontal' then 
        self.frame = 2;
        self.width = 110;
        self.height = 35;
    elseif self.shape == 'vertical' then 
        self.frame = 4;
        self.width = 35;
        self.height = 110;
    end

    -- physics body
    self.body = love.physics.newBody(self.world, self.x, self.y, 'dynamic');


    -- body
    self.physics_shape = love.physics.newRectangleShape(self.width, self.height);

    self.fixture = love.physics.newFixture(self.body, self.physics_shape);

    self.fixture:setUserData('Obstacle');
end

-- UPDATE
function Obstacle:update(dt)

end

-- RENDER
function Obstacle:render()
    love.graphics.draw(game_Textures['wood'], game_Frames['wood'][self.frame], 
    self.body:getX(), self.body:getY(), self.body:getAngle(), 
    1, 1, self.width/2, self.height/2);
end