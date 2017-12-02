% if user clicks on a highlighted area set move variable and hide highlights
proc assign_move (spriteID : sprite)
    loop
	delay (20)
	Mouse.Where (x, y, button)
	if button = 1 then 
	    % if user has clicked on a sprite 
	    if x > spriteID.x + SPACE or x < spriteID.x or y > spriteID.y + SPACE or y < spriteID.y then
		for i : 0 .. 56
		    % if user clicked on a highlight, set move variable
		    if x <= (highlight (i).x + SPACE) and x >= highlight (i).x and y <= (highlight (i).y + SPACE) and y >= highlight (i).y then
			move := i + 1
			return
		    end if
		end for
		% hide highlights after click
		for i : 0 .. 56
		    highlight (i).x := 10000
		    Sprite.Hide (highlight (i).spr)
		end for
		return
	    end if
	end if
    end loop
end assign_move
