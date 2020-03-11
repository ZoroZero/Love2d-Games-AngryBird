Level = Class{}


-- INIT
function Level:init()
    -- Physics world
    self.world = love.physics.newWorld(0, 300);

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

end

-- UPDATE
function Level:update(dt)
    self.world:update(dt);

    for k, body in pairs(self.destroyed_Bodies) do 
        if not body:isDestroyed() then
            body:destroy();
        end
    end

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
end

-- RENDER
function Level:render()
    -- render ground tile
    for x = -VIRTUAL_WIDTH, 2*VIRTUAL_WIDTH, 35 do 
        love.graphics.draw(game_Textures['tiles'], game_Frames['tiles'][12], x, VIRTUAL_HEIGHT -35);
    end

    -- render obstacles
    for k, obstacle in pairs(self.obstacles) do
        obstacle:render()
    end

    -- render aliens
    for k, alien in pairs(self.aliens) do
        alien:render()
    end
end