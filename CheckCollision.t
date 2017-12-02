% checks if a position on the board is occupied - 0 for white, 1 for black, 2 for vacant
fcn check_collision (spriteID : sprite, vert, horiz : int) : int
    for i : 0 .. 31
	if (spriteID.y + vert * SPACE) = ^ (pointers (i)).y and (spriteID.x + horiz * SPACE) = ^ (pointers (i)).x then
	    if i <= 15 then % white
		result 0
	    else % black
		result 1
	    end if
	end if
    end for
    result 2
end check_collision
