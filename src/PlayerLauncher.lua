PlayerLauncher = Class{}

-- INIT
function PlayerLauncher:init(world)
    -- world
    self.world = world;

    -- base position
    self.base_X = 90;
    self.base_Y = VIRTUAL_HEIGHT - 100;

    -- shifted x, y
    self.shifted_X = self.base_X;
    self.shifted_Y = self.base_Y;

    -- rotation
    self.rotation = 0

    -- Is aiming or not
    self.aiming = false;

    -- Is launched or not
    self.launched = false;

    -- Alien 
    self.alien = nil;
end

-- UPDATE
function PlayerLauncher:update(dt)
    
    if not self.launched then 
        local x, y = push:toGame(love.mouse.getPosition());


        -- if we click the mouse and haven't launched, show arrow preview
        if love.mouse.wasPressed(1) and not self.launched then
            self.aiming = true

        -- if we release the mouse, launch an Alien
        elseif love.mouse.wasReleased(1) and self.aiming then
            self.launched = true

            -- Spawn new alien 
            self.alien = Alien(self.world, 'round', self.shifted_X, self.shifted_Y, 'Player');

            -- Set velocity
            self.alien.body:setLinearVelocity((self.base_X - self.shifted_X)* 10, 
            (self.base_Y - self.shifted_Y)* 10);

            -- Set bouncing 
            self.alien.fixture:setRestitution(0.4);
            self.alien.body:setAngularDamping(1);

            -- Not in aiming mode
            self.aiming = false;

        elseif self.aiming then 
            self.rotation = self.base_Y - self.shifted_Y* 0.9;
            -- not going to far
            self.shifted_X = math.min(self.base_X + 30, math.max(x, self.base_X - 30))
            self.shifted_Y = math.min(self.base_Y + 30, math.max(y, self.base_Y - 30))
        end
    end


        
end

-- RENDER
function PlayerLauncher:render()
    if not self.launched then 
        -- place holder alien
        love.graphics.draw(game_Textures['alien'], game_Frames['alien'][9], 
            self.shifted_X - 17.5, self.shifted_Y - 17.5);

        -- draw projectory for aiming
        if self.aiming then 

            local impulse_X = (self.base_X - self.shifted_X)* 10;
            local impulse_Y = (self.base_Y - self.shifted_Y)* 10;
            
            -- draw 6 circles simulating trajectory of estimated impulse
            local traj_X, traj_Y = self.shifted_X, self.shifted_Y
            local grav_X, grav_Y = self.world:getGravity()

            -- 
            for i = 1, 90 do
                -- magenta color that starts off slightly transparent
                love.graphics.setColor(1, 80/255, 1, (255 / 12) * i/255);
                
                -- trajectory X and Y for this iteration of the simulation
                traj_X = self.shifted_X + i * 1/60 * impulse_X;
                traj_Y = self.shifted_Y + i * 1/60 * impulse_Y + 0.5 * (i * i + i) * grav_Y * 1/60 * 1/60;

                -- render every fifth calculation as a circle
                if i % 5 == 0 then
                    love.graphics.circle('fill', traj_X, traj_Y, 3);
                end
            end    
        end
        love.graphics.setColor(1,1,1,1);

    else
        self.alien:render();
    end
end