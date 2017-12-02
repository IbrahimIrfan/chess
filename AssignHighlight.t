% draw highlight if tile is on board and piece can be taken or tile is vacant
proc assign_highlight (spriteID : sprite, i, vert, horiz : int)
    if check_collision (spriteID, vert, horiz) not= 0 and spriteID.name (1) = "w"
	    or check_collision (spriteID, vert, horiz) not= 1 and spriteID.name (1) = "b" then
	if spriteID.x + horiz * SPACE < 8 * SPACE and spriteID.y + vert * SPACE < 8 * SPACE
		and spriteID.x + horiz * SPACE >= 0 and spriteID.y + vert * SPACE >= 0 then
	    highlight (i).x := spriteID.x + horiz * SPACE
	    highlight (i).y := spriteID.y + vert * SPACE
	    draw_piece (highlight (i))
	end if
    end if
end assign_highlight

% used for pieces to ensure they cannot jump over - 0 if occupied tile, 1 if vacant
fcn assign_highlight_2 (spriteID : sprite, i, vert, horiz : int) : int
    if check_collision (spriteID, vert, horiz) = 0 and spriteID.name (1) = "w"
	    or check_collision (spriteID, vert, horiz) = 1 and spriteID.name (1) = "b" then
	result 0
    elsif spriteID.y + vert * SPACE < 8 * SPACE and spriteID.x + horiz * SPACE < 8 * SPACE
	    and spriteID.x + horiz * SPACE >= 0 and spriteID.y + vert * SPACE >= 0 then
	highlight (i - 1).y := spriteID.y + vert * SPACE
	highlight (i - 1).x := spriteID.x + horiz * SPACE
	draw_piece (highlight (i - 1))
	if check_collision (spriteID, vert, horiz) = 1 and spriteID.name (1) = "w"
		or check_collision (spriteID, vert, horiz) = 0 and spriteID.name (1) = "b" then
	    result 0
	else
	    result 1
	end if
    end if
    result 2
end assign_highlight_2

% the below code is for use with checkmate detection

% same as assign_highlight, excpet don't actually draw the highlights (only store the values in the array for reference)
proc assign_highlight_3 (spriteID : sprite, i, vert, horiz : int)
    if check_collision (spriteID, vert, horiz) not= 0 and spriteID.name (1) = "w"
	    or check_collision (spriteID, vert, horiz) not= 1 and spriteID.name (1) = "b" then
	if spriteID.x + horiz * SPACE < 8 * SPACE and spriteID.y + vert * SPACE < 8 * SPACE
		and spriteID.x + horiz * SPACE >= 0 and spriteID.y + vert * SPACE >= 0 then
	    highlight (i).x := spriteID.x + horiz * SPACE
	    highlight (i).y := spriteID.y + vert * SPACE
	end if
    end if
end assign_highlight_3

% same as assign_highlight_2, excpet don't actually draw the highlights (only store the values in the array for reference)
fcn assign_highlight_4 (spriteID : sprite, i, vert, horiz : int) : int
    if check_collision (spriteID, vert, horiz) = 0 and spriteID.name (1) = "w"
	    or check_collision (spriteID, vert, horiz) = 1 and spriteID.name (1) = "b" then
	result 0
    elsif spriteID.y + vert * SPACE < 8 * SPACE and spriteID.x + horiz * SPACE < 8 * SPACE
	    and spriteID.x + horiz * SPACE >= 0 and spriteID.y + vert * SPACE >= 0 then
	highlight (i - 1).y := spriteID.y + vert * SPACE
	highlight (i - 1).x := spriteID.x + horiz * SPACE
	if check_collision (spriteID, vert, horiz) = 1 and spriteID.name (1) = "w"
		or check_collision (spriteID, vert, horiz) = 0 and spriteID.name (1) = "b" then
	    result 0
	else
	    result 1
	end if
    end if
    result 2
end assign_highlight_4
