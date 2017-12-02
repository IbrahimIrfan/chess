% check if the user clicked a piece, and pass the spriteID to the appropriate procedure
% if user clicks forfeit, assign forfeit variable to true
proc check_click (spriteID : sprite)
    if x <= spriteID.x + SPACE and x >= spriteID.x and y <= spriteID.y + SPACE and y >= spriteID.y then % click on sprite
	if spriteID.name (2) = "p" then
	    if spriteID.name(1) = "w" then
		pawn_move (spriteID, 1)
	    else    
		pawn_move (spriteID, -1)
	    end if
	elsif spriteID.name (2) = "b" then
	    c_or_b_or_q_move(spriteID)
	elsif spriteID.name = "wknight" or spriteID.name = "bknight" then
	    knight_move(spriteID)
	elsif spriteID.name (2) = "c" then
	    c_or_b_or_q_move(spriteID)
	elsif spriteID.name(2) = "q" then
	    c_or_b_or_q_move(spriteID)
	elsif spriteID.name = "wking" or spriteID.name = "bking" then 
	    king_move(spriteID)
	end if 
    elsif x > 450 and x < 600 and y > 180 and y < 230 then % click on forfeit
	if turn = 0 then
	    w_forfeit := true
	else
	    b_forfeit := true
	end if
    end if
end check_click
