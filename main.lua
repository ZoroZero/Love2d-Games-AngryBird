require 'src/Dependencies'

-- LOAD FUNCTION
function love.load()
    -- SET UP TEXTURE RENDER OPTIONS
    love.graphics.setDefaultFilter('nearest', 'nearest');

    -- SET UP WINDOW TITLE
    love.window.setTitle('Mari0');

    -- SET RANDOM SEED
    math.randomseed(os.time());

    -- SET WINDOW SCREEN
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        vsyn = true,
        fullscreen = false
    })

    -- SET UP STATE MACHINE
    game_State_Machine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end
    }
    game_State_Machine:change('start');
    

    -- SET UP KEY CHECK
    love.keyboard.keysPressed = {};

    -- SET UP MOUSE CHECK
    love.mouse.keysPressed = {};
    love.mouse.keysReleased = {};



end


-- UPDATE FUNCTION
function love.update(dt)
    -- Update timer
    Timer.update(dt);

    game_State_Machine:update(dt);
end


-- RENDER FUNCTION
function love.draw()
    push:start()

    game_State_Machine:render();

   
    displayFPS();
    
    push:finish()
end


-- RESIZE WINDOW FUNCTION
function love.resize(w, h)
    push:resize(w, h);
end


-- CHECK WHICH KEY WAS PRESSED
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true;
end

-- FUNCTION TO CHECK IF A SPECIFIC KEY IN KEYBOARD WAS PRESSED
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key];
end


-- IF MOUSE PRESSED
function love.mousepressed(x, y, key)
    love.mouse.keysPressed[key] = true;
end

-- CHECK MOUSE PRESSES
function love.mouse.wasPressed(key)
    return love.mouse.keysPressed[key];
end


-- IF MOUSE RELEASED
function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true;
end

-- CHECK MOUSE PRESSES
function love.mouse.wasPressed(key)
    return love.mouse.keysPressed[key];
end

-- DISPLAY FPS FUNCTION
function displayFPS()
    love.graphics.setFont(game_Fonts['smallFont']);
    love.graphics.setColor(255, 255, 0, 255);
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), math.floor(10), 10);
end