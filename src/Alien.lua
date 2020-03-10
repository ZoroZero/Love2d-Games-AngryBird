Alien = Class {};

-- INIT
function Alien:init(world, type, x, y, userData)
    self.world = world;
    self.rotation = 0;

    -- INIT body
    self.body = love.physics.newBody(self.world, 
    x or math.random(VIRTUAL_WIDTH), y or math.random(VIRTUAL_HEIGHT - 50), 'dynamic');

    -- SHAPE
    self.type = type or 'square';
    if self.type == 'square' then 
        self.shape = love.physics.newRectangleShape(35,35);
        self.frame = math.random(5);
    else
        self.shape = love.physics.newCircleShape(17);
        self.frame = math.random(9,10);
    end

    -- FIXTURE
    self.fixture = love.physics.newFixture(self.body, self.shape);

    self.fixture:setUserData(userData);

    -- IF launched or not

    self.launched = false;
end

-- UPDATE
function Alien:update(dt)
    -- body
end

-- RENDER
function Alien:render()
    love.graphics.draw(game_Textures['alien'], game_Frames['alien'][self.frame], 
    self.body:getX(), self.body:getY(), self.body:getAngle(), 
    1, 1, 17.5, 17.5);
end