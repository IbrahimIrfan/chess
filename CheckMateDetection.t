/*
Checkmate detection has been commented out since it is buggy and does not work consistently
To test out the checkmate, remove the comment in "Main.t" of %include "CheckMateDetection.t"
and in "Animate.t" remove the comments around the 2 long blocks of code which are commented out.
*/

% alert players of checkmate
proc check_mate_action
    drawfillbox (0, 0, maxx, maxy, yellow)
end check_mate_action

% detect checkmate for castle, bishop, queen (repeating moves)
proc c_or_b_or_q_check (spriteID : sprite, highlight_index : int)
    for i : 1 .. spriteID.maxv
	if assign_highlight_4 (spriteID, highlight_index, i, 0) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxh
	if assign_highlight_4 (spriteID, (highlight_index + spriteID.maxv), 0, i) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxd
	if assign_highlight_4 (spriteID, (highlight_index + spriteID.maxv + spriteID.maxh), i, i) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxv
	if assign_highlight_4 (spriteID, (highlight_index + spriteID.maxv + spriteID.maxh + spriteID.maxd), -i, 0) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxh
	if assign_highlight_4 (spriteID, (highlight_index + 2 * spriteID.maxv + spriteID.maxh + spriteID.maxd), 0, -i) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxd
	if assign_highlight_4 (spriteID, (highlight_index + 2 * spriteID.maxv + 2 * spriteID.maxh + spriteID.maxd), i, -i) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxd
	if assign_highlight_4 (spriteID, (highlight_index + 2 * spriteID.maxv + 2 * spriteID.maxh + 2 * spriteID.maxd), -i, i) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxd
	if assign_highlight_4 (spriteID, (highlight_index + 2 * spriteID.maxv + 2 * spriteID.maxh + 3 * spriteID.maxd), -i, -i) = 0 then
	    exit
	end if
    end for
end c_or_b_or_q_check

% return 0 if tile has white king, 1 for black king, 2 for no checkmate
fcn detect_check_mate (spriteID : sprite, vert, horiz : int) : int
    for i : 0 .. 7
	if (spriteID.y + vert * SPACE) = highlight (i).y and spriteID.x + horiz * SPACE = highlight (i).x then
	    result 0
	end if
    end for
    for i : 100 .. 107
       if (spriteID.y + vert * SPACE) = highlight (i).y and spriteID.x + horiz * SPACE = highlight (i).x then
	    result 1
	end if
    end for
    result 2
end detect_check_mate

% 3 if a piece is blocking movement and the piece is not a king, 0 for black checkmate, 1 for white checkmate, 2 for continue
fcn detect_check_mate_2 (spriteID : sprite, vert, horiz : int) : int
    for i : 0 .. 7
	if (spriteID.y + vert * SPACE) = highlight (i).y and (spriteID.x + horiz * SPACE) = highlight (i).x
		and spriteID.name (1) = "b" then
	    result 0
	end if
	if check_collision (spriteID, vert, horiz) not= 2 then
	    if (spriteID.y + vert * SPACE) not= highlight (i).y and (spriteID.x + horiz * SPACE) not= highlight (i).x
		    and spriteID.name (1) = "b" then
		result 3
	    end if
	end if
    end for
    for i : 100 .. 107
	if (spriteID.y + vert * SPACE) = highlight (i).y and (spriteID.x + horiz * SPACE) = highlight (i).x
		and spriteID.name (1) = "w" then
	    result 1
	end if
	if check_collision (spriteID, vert, horiz) not= 2 then
	    if (spriteID.y + vert * SPACE) not= highlight (i).y and (spriteID.x + horiz * SPACE) not= highlight (i).x
		    and spriteID.name (1) = "w" then
		result 3
	    end if
	end if
    end for
    result 2
end detect_check_mate_2

% detect checkmate for white pawns, king, and knights
proc detect_check_mate_w
    for i : 0 .. 7
	if detect_check_mate (w_pawns (i), 1, 1) = 1 or detect_check_mate (w_pawns (i), 1, -1) = 1 then
	    check_mate_action
	end if
    end for
    for i : 0 .. 1
	if detect_check_mate (w_knights (i), 2, -1) = 1 or detect_check_mate (w_knights (i), 2, 1) = 1
		or detect_check_mate (w_knights (i), 1, -2) = 1 or detect_check_mate (w_knights (i), 1, 2) = 1
		or detect_check_mate (w_knights (i), -1, 2) = 1 or detect_check_mate (w_knights (i), -1, -2) = 1
		or detect_check_mate (w_knights (i), -2, 1) = 1 or detect_check_mate (w_knights (i), -2, -1) = 1 then
	    check_mate_action
	end if
    end for
    if detect_check_mate (w_king, 1, 0) = 1 or detect_check_mate (w_king, 0, 1) = 1 or detect_check_mate (w_king, 1, 1) = 1
	    or detect_check_mate (w_king, -1, 0) = 1 or detect_check_mate (w_king, 0, -1) = 1 or detect_check_mate (w_king, -1, -1) = 1
	    or detect_check_mate (w_king, 1, -1) = 1 or detect_check_mate (w_king, -1, 1) = 1 then
	check_mate_action
    end if
end detect_check_mate_w

% detect checkmate for black pawns, king, and knights
proc detect_check_mate_b
    for i : 0 .. 7
	if detect_check_mate (b_pawns (i), -1, 1) = 0 or detect_check_mate (b_pawns (i), -1, -1) = 0 then
	    check_mate_action
	end if
    end for
    for i : 0 .. 1
	if detect_check_mate (b_knights (i), 2, -1) = 0 or detect_check_mate (b_knights (i), 2, 1) = 0
		or detect_check_mate (b_knights (i), 1, -2) = 0 or detect_check_mate (b_knights (i), 1, 2) = 0
		or detect_check_mate (b_knights (i), -1, 2) = 0 or detect_check_mate (b_knights (i), -1, -2) = 0
		or detect_check_mate (b_knights (i), -2, 1) = 0 or detect_check_mate (b_knights (i), -2, -1) = 0 then
	    check_mate_action
	end if
    end for
    if detect_check_mate (b_king, 1, 0) = 0 or detect_check_mate (b_king, 0, 1) = 0
	    or detect_check_mate (b_king, 1, 1) = 0 or detect_check_mate (b_king, -1, 0) = 0
	    or detect_check_mate (b_king, 0, -1) = 0 or detect_check_mate (b_king, -1, -1) = 0
	    or detect_check_mate (b_king, 1, -1) = 0 or detect_check_mate (b_king, -1, 1) = 0 then
	check_mate_action
    end if
end detect_check_mate_b

% assign values for highlights, detect a checkmate, and exit. 1 - checkmate, 0 - exit, 2 - continue checking
fcn detect_check_mate_final (spriteID : sprite, vert, horiz, w_or_b : int) : int
    if w_or_b = 0 then
	assign_highlight_3 (w_king, 0, 1, -1)
	assign_highlight_3 (w_king, 1, 1, 0)
	assign_highlight_3 (w_king, 2, 1, 1)
	assign_highlight_3 (w_king, 3, 0, 1)
	assign_highlight_3 (w_king, 4, -1, 1)
	assign_highlight_3 (w_king, 5, -1, 0)
	assign_highlight_3 (w_king, 6, -1, -1)
	assign_highlight_3 (w_king, 7, 0, -1)

	for i : 0 .. 1
	    assign_highlight_3 (w_knights (i), 8, 2, -1)
	    assign_highlight_3 (w_knights (i), 9, 2, 1)
	    assign_highlight_3 (w_knights (i), 10, 1, -2)
	    assign_highlight_3 (w_knights (i), 11, 1, 2)
	    assign_highlight_3 (w_knights (i), 12, -1, 2)
	    assign_highlight_3 (w_knights (i), 13, -1, -2)
	    assign_highlight_3 (w_knights (i), 14, -2, 1)
	    assign_highlight_3 (w_knights (i), 15, -2, -1)
	    c_or_b_or_q_check (w_bishops (i), 17)
	    c_or_b_or_q_check (w_castles (i), 34)
	end for

	c_or_b_or_q_check (w_queen, 50)

    else
	assign_highlight_3 (b_king, 100, 1, -1)
	assign_highlight_3 (b_king, 101, 1, 0)
	assign_highlight_3 (b_king, 102, 1, 1)
	assign_highlight_3 (b_king, 103, 0, 1)
	assign_highlight_3 (b_king, 104, -1, 1)
	assign_highlight_3 (b_king, 105, -1, 0)
	assign_highlight_3 (b_king, 106, -1, -1)
	assign_highlight_3 (b_king, 107, 0, -1)

	for i : 0 .. 1
	    assign_highlight_3 (b_knights (i), 108, 2, -1)
	    assign_highlight_3 (b_knights (i), 109, 2, 1)
	    assign_highlight_3 (b_knights (i), 110, 1, -2)
	    assign_highlight_3 (b_knights (i), 111, 1, 2)
	    assign_highlight_3 (b_knights (i), 112, -1, 2)
	    assign_highlight_3 (b_knights (i), 113, -1, -2)
	    assign_highlight_3 (b_knights (i), 114, -2, 1)
	    assign_highlight_3 (b_knights (i), 115, -2, -1)
	    c_or_b_or_q_check (b_bishops (i), 117)
	    c_or_b_or_q_check (b_castles (i), 134)
	end for

	c_or_b_or_q_check (b_queen, 150)
	
    end if
    if detect_check_mate_2 (spriteID, vert, horiz) = w_or_b then
	check_mate_action
	result 1
    elsif detect_check_mate_2 (spriteID, vert, horiz) = 3 then
	result 0
    else
	result 2
    end if
end detect_check_mate_final

