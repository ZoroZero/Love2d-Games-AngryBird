PlayState = Class{__includes = BaseState}

-- INIT
function PlayState:init() 
    self.background = Background();
    -- world
    self.world = love.physics.newWorld(0,300);

    self.obstacles = {};
    table.insert( self.obstacles, Obstacle(self.world, 'horizontal', 0 , 100));
    table.insert( self.obstacles, Obstacle(self.world, 'vertical', 0 , 136));
    table.insert( self.obstacles, Obstacle(self.world, 'vertical', 85 , 136));

    -- ground and wall
    -- ground
    self.groundBody = love.physics.newBody(self.world, 0, VIRTUAL_HEIGHT, 'static');

    -- shape that we will attach using a fixture to our body for collision detection
    self.groundShape = love.physics.newEdgeShape(0, 0, VIRTUAL_WIDTH, 0);
 
    -- fixture that attaches a shape to our body
    self.groundFixture = love.physics.newFixture(self.groundBody, self.groundShape);
 
    -- wall
    self.leftWallBody = love.physics.newBody(self.world, 0, 0, 'static');
    self.rightWallBody = love.physics.newBody(self.world, VIRTUAL_WIDTH, 0, 'static');
 
    -- shape that we will attach using a fixture to our body for collision detection
    self.wallShape = love.physics.newEdgeShape(0, 0, 0, VIRTUAL_HEIGHT);
 
    -- fixture that attaches a shape to our body
    self.leftWallFixture = love.physics.newFixture(self.leftWallBody, self.wallShape);
    self.rightWallFixture = love.physics.newFixture(self.rightWallBody, self.wallShape);
end


-- UPDATE
function PlayState:update(dt) 
    self.world:update(dt)
end

-- RENDER
function PlayState:render() 
    for k, obstacle in pairs(self.obstacles) do 
        obstacle:render()
    end
end
