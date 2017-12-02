% alert players of check
proc check_action
    check := true
    drawfillbox (0, 0, maxx, maxy, red)
    Font.Draw ("Check! Save your king!", 450, 65, font4, white)
end check_action

% return 0 if tile has white king, 1 for black king, 2 for no check
fcn detect_check (spriteID : sprite, vert, horiz : int) : int  
  if (spriteID.y + vert * SPACE) = w_king.y and spriteID.x + horiz * SPACE = w_king.x then
	result 0
    elsif (spriteID.y + vert * SPACE) = b_king.y and spriteID.x + horiz * SPACE = b_king.x then
	result 1
    end if
    result 2
end detect_check

% return 3 if a non-king piece is blocking movement, 0 for black check, 1 for white check, 2 for continue
fcn detect_check_2 (spriteID : sprite, vert, horiz : int) : int
    if (spriteID.y + vert * SPACE) = w_king.y and (spriteID.x + horiz * SPACE) = w_king.x and spriteID.name (1) = "b" then
	result 0
    elsif (spriteID.y + vert * SPACE) = b_king.y and (spriteID.x + horiz * SPACE) = b_king.x and spriteID.name (1) = "w" then
	result 1
    elsif check_collision (spriteID, vert, horiz) not= 2 then
	result 3
    end if
    result 2
end detect_check_2

% detect check for white pawns, king, and knights (non repetitive movements)
proc detect_check_w
    for i : 0 .. 7
	if detect_check (w_pawns (i), 1, 1) = 1 or detect_check (w_pawns (i), 1, -1) = 1 then
	    check_action
	end if
    end for
    for i : 0 .. 1
	if detect_check (w_knights (i), 2, -1) = 1 or detect_check (w_knights (i), 2, 1) = 1
		or detect_check (w_knights (i), 1, -2) = 1 or detect_check (w_knights (i), 1, 2) = 1
		or detect_check (w_knights (i), -1, 2) = 1 or detect_check (w_knights (i), -1, -2) = 1
		or detect_check (w_knights (i), -2, 1) = 1 or detect_check (w_knights (i), -2, -1) = 1 then
	    check_action
	end if
    end for
    if detect_check (w_king, 1, 0) = 1 or detect_check (w_king, 0, 1) = 1 or detect_check (w_king, 1, 1) = 1
	    or detect_check (w_king, -1, 0) = 1 or detect_check (w_king, 0, -1) = 1 or detect_check (w_king, -1, -1) = 1
	    or detect_check (w_king, 1, -1) = 1 or detect_check (w_king, -1, 1) = 1 then
	check_action
    end if
end detect_check_w

% detect check for black pawns, king, and knights (non repetitive movements)
proc detect_check_b
    for i : 0 .. 7
	if detect_check (b_pawns (i), -1, 1) = 0 or detect_check (b_pawns (i), -1, -1) = 0 then
	    check_action
	end if
    end for
    for i : 0 .. 1
	if detect_check (b_knights (i), 2, -1) = 0 or detect_check (b_knights (i), 2, 1) = 0
		or detect_check (b_knights (i), 1, -2) = 0 or detect_check (b_knights (i), 1, 2) = 0
		or detect_check (b_knights (i), -1, 2) = 0 or detect_check (b_knights (i), -1, -2) = 0
		or detect_check (b_knights (i), -2, 1) = 0 or detect_check (b_knights (i), -2, -1) = 0 then
	    check_action
	end if
    end for
    if detect_check (b_king, 1, 0) = 0 or detect_check (b_king, 0, 1) = 0
	    or detect_check (b_king, 1, 1) = 0 or detect_check (b_king, -1, 0) = 0
	    or detect_check (b_king, 0, -1) = 0 or detect_check (b_king, -1, -1) = 0
	    or detect_check (b_king, 1, -1) = 0 or detect_check (b_king, -1, 1) = 0 then
	check_action
    end if
end detect_check_b

% if there is a check, then call check_action, if a piece is blocking then exit
fcn detect_check_final (spriteID : sprite, vert, horiz, w_or_b : int) : int
    if detect_check_2 (spriteID, vert, horiz) = w_or_b then
	check_action
	result 1
    elsif detect_check_2 (spriteID, vert, horiz) = 3 then
	result 0
    else
	result 2
    end if
end detect_check_final
