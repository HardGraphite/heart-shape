#!/usr/bin/lua

local function F(x, y)
    return (x ^ 2 + y ^ 2 - 1) ^ 3 - x ^ 2 * y ^ 3
end

local X_MIN = -1.3
local X_MAX = -X_MIN
local Y_MIN = -1.1
local Y_MAX = 1.4

local function draw(stream)
    local width, height = 80, 24
    local x_step = (X_MAX - X_MIN) / (width - 1)
    local y_step = (Y_MIN - Y_MAX) / (height - 1)

    for y = Y_MAX, Y_MIN, y_step do
        local buffer = {}
        for x = X_MIN, X_MAX, x_step do
            if F(x, y) <= 0 then
                table.insert(buffer, '@')
            else
                table.insert(buffer, ' ')
            end
        end
        print(table.concat(buffer))
    end
end

draw(io.stdout)
