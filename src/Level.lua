Level = Class{}


-- INIT
function Level:init()
    -- Physics world
    self.world = love.physics.newWorld(0, 300);

    

    -- begin contact function
    function beginContact(a, b, coll)
        local type = {}
        type[a:getUserData()] = true;
        type[b:getUserData()] = true;

        -- Player and obstacle collision
        if type['Obstacle'] and type['Player'] then 
            if a:getUserData() == 'Player' then 
                local vel_X, vel_Y = a:getBody():getLinearVelocity();
                local vel = math.abs(vel_X) + math.abs(vel_Y)

                if vel > 20 then
                    table.insert(self.destroyed_Bodies, b:getBody())
                end  
            else
                local vel_X, vel_Y = b:getBody():getLinearVelocity();
                local vel = math.abs(vel_X) + math.abs(vel_Y)

                if vel > 20 then
                    table.insert(self.destroyed_Bodies, a:getBody())
                end  
            end
        -- Player and alien collision
        elseif type['Alien'] and type['Player'] then 
            if a:getUserData() == 'Player' then 
                local vel_X, vel_Y = a:getBody():getLinearVelocity();
                local vel = math.abs(vel_X) + math.abs(vel_Y)

                if vel > 20 then
                    table.insert(self.destroyed_Bodies, b:getBody())
                end  
            else
                local vel_X, vel_Y = b:getBody():getLinearVelocity();
                local vel = math.abs(vel_X) + math.abs(vel_Y)

                if vel > 20 then
                    table.insert(self.destroyed_Bodies, a:getBody())
                end  
            end
        
        -- Obstacle and Alien collision
        elseif type['Alien'] and type['Obstacle'] then 
            if a:getUserData() == 'Obstacle' then 
                local vel_X, vel_Y = a:getBody():getLinearVelocity();
                local vel = math.abs(vel_X) + math.abs(vel_Y)

                if vel > 20 then
                    table.insert(self.destroyed_Bodies, b:getBody())
                end  
            else
                local vel_X, vel_Y = b:getBody():getLinearVelocity();
                local vel = math.abs(vel_X) + math.abs(vel_Y)

                if vel > 20 then
                    table.insert(self.destroyed_Bodies, a:getBody())
                end  
            end
        end
    end

    -- end contact
    function endContact(a, b, coll)

    end

    -- pre solve
    function preSolve(a, b, coll)

    end

    -- post solve
    function postSolve(a, b, normalImpulse, tangentImpulse)

    end

    -- set call back function for world
    self.world:setCallbacks(beginContact, endContact,  preSolve, postSolve);


    --Launch pad 
    self.launchPad = PlayerLauncher(self.world); 

    -- Alien in the level
    self.aliens = {};

    table.insert( self.aliens, Alien(self.world, 'square', VIRTUAL_WIDTH - 80, VIRTUAL_HEIGHT - 35 - ALIEN_SIZE/2, 'Alien'));

    -- Obstacles
    self.obstacles = {};

    table.insert(self.obstacles, Obstacle(self.world, 'horizontal',  VIRTUAL_WIDTH - 80, VIRTUAL_HEIGHT - 35 - 110 - 35/2));
    table.insert(self.obstacles, Obstacle(self.world, 'vertical',  VIRTUAL_WIDTH - 80 - 55 + 35/2, VIRTUAL_HEIGHT - 35 - 55));
    table.insert(self.obstacles, Obstacle(self.world, 'vertical',  VIRTUAL_WIDTH - 80 + 55 - 35/2 , VIRTUAL_HEIGHT - 35 - 55));
    -- Background

    self.background = Background();

    -- Ground edge
    self.ground_Edge = love.physics.newEdgeShape(0, 0, VIRTUAL_WIDTH*3, 0);

    -- ground data
    self.ground_Body = love.physics.newBody(self.world, - VIRTUAL_WIDTH, VIRTUAL_HEIGHT - 35, 'static');
    self.ground_Fixture = love.physics.newFixture(self.ground_Body, self.ground_Edge);
    self.ground_Fixture:setFriction(0.5);
    self.ground_Fixture:setUserData('Ground');

    -- Collision
    self.destroyed_Bodies = {}
end

-- UPDATE
function Level:update(dt)
    self.launchPad:update(dt);


    self.world:update(dt);


    -- Delete body
    for k, body in pairs(self.destroyed_Bodies) do 
        if not body:isDestroyed() then
            body:destroy();
        end
    end

    self.destroyed_Bodies = {}

    -- Remove destroy body
    for i = #self.aliens, 1 , -1 do 
        if self.aliens[i].body:isDestroyed() then
            table.remove( self.aliens, i);
        end
    end

    for i = #self.obstacles, 1 , -1 do 
        if self.obstacles[i].body:isDestroyed() then
            table.remove( self.obstacles, i);
        end
    end

    -- Respawn a new launchPad when ailen is destroy
    if self.launchPad.launched then
        local x, y = self.launchPad.alien.body:getPosition()
        local vel_X, vel_Y = self.launchPad.alien.body:getLinearVelocity()
        
        -- if we fired our alien to the left or it's almost done rolling, respawn
        if x < 0 or (math.abs(vel_X) + math.abs(vel_Y) < 1.5) then
            self.launchPad.alien.body:destroy()
            self.launchPad = PlayerLauncher(self.world)

            -- re-initialize level if we have no more aliens
            if #self.aliens == 0 then
                game_State_Machine:change('start')
            end
        end
    end
end

-- RENDER
function Level:render()
    -- render ground tile
    for x = -VIRTUAL_WIDTH, 2*VIRTUAL_WIDTH, 35 do 
        love.graphics.draw(game_Textures['tiles'], game_Frames['tiles'][12], x, VIRTUAL_HEIGHT -35);
    end

    -- render launch pad
    self.launchPad:render();
    
    -- render obstacles
    for k, obstacle in pairs(self.obstacles) do
        obstacle:render()
    end

    -- render aliens
    for k, alien in pairs(self.aliens) do
        alien:render()
    end

    -- render instruction text if we haven't launched bird
    if not self.launchPad.launched then
        love.graphics.setFont(game_Fonts['mediumFont'])
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.printf('Click and drag circular alien to shoot!',
            0, 64, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255, 255, 255, 255)
    end

    -- render victory text if all aliens are dead
    if #self.aliens == 0 then
        love.graphics.setFont(game_Fonts['largeFont'])
        love.graphics.setColor(0, 0, 0, 255)
        love.graphics.printf('VICTORY', 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')
        love.graphics.setColor(255, 255, 255, 255)
    end
end