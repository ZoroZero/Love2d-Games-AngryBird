StartState = Class {__includes = BaseState}


-- INIT
function StartState:init()
    -- Back ground
    self.background = Background();
    -- world
    self.world = love.physics.newWorld(0,300);

    -- alien 
    self.aliens = {};

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


    -- INIT ALIENS
    for i = 1,100 do 
        table.insert(self.aliens, Alien(self.world));
    end
end

-- UPDATE
function StartState:update(dt)
    self.world:update(dt);

    if love.mouse.wasPressed(1)then 
        game_State_Machine:change('play');
    end
end

-- RENDER
function StartState:render()
    -- render background
    self.background:render();

    -- render aliens
    for k, alien in pairs(self.aliens) do 
        alien:render()
    end
    
    -- render title
    love.graphics.setFont(game_Fonts['largeFont']);
    drawShadowText("Angry Z", VIRTUAL_HEIGHT/2 - 30);
    love.graphics.setColor(1,0,0,1);
    love.graphics.printf("Angry Z", 0,  VIRTUAL_HEIGHT/2 - 30, VIRTUAL_WIDTH, 'center');

    -- Press enter
    love.graphics.setColor(1,1,1,1);
    love.graphics.setFont(game_Fonts['mediumFont']);
    drawShadowText("Click to start ...", VIRTUAL_HEIGHT/2 + 50);
    love.graphics.printf("Click to start ...", 2, VIRTUAL_HEIGHT/2 + 50, VIRTUAL_WIDTH, 'center');
end

-- Print shadow function
function drawShadowText(text, y)
    love.graphics.setColor(0, 0, 0, 255);
    love.graphics.printf(text, 2, y + 1, VIRTUAL_WIDTH, 'center');
    love.graphics.printf(text, 1, y + 1, VIRTUAL_WIDTH, 'center');
    love.graphics.printf(text, 0, y + 1, VIRTUAL_WIDTH, 'center');
    love.graphics.printf(text, 1, y + 2, VIRTUAL_WIDTH, 'center');
    love.graphics.setColor(255, 255, 255, 255)
end