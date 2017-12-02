% pawn move algorithm
% if tile is vacant and valid then draw highlight, and if turn is 1 then draw two highlights
proc pawn_move (spriteID : sprite, w_or_b : int)
    % if tile is vacant then draw highlight
    if check_collision (spriteID, w_or_b * 1, 0) = 2 and spriteID.y + w_or_b * 1 < 7* SPACE and spriteID.y + w_or_b * 1 >= 0 then
	highlight (0).x := spriteID.x
	highlight (0).y := spriteID.y + w_or_b * SPACE
	draw_piece (highlight (0))
	% if first turn then draw an extra highlight (can move 2 spaces)
	if spriteID.y = SPACE and turn = 0 or spriteID.y = 6 * SPACE and turn = 1 then
	    if check_collision (spriteID, w_or_b * 2, 0) = 2 then
		highlight (1).x := spriteID.x
		highlight (1).y := spriteID.y + w_or_b * 2 * SPACE
		draw_piece (highlight (1))
	    end if
	end if
    end if
    % if pawn can take a diagonal piece, draw highlight
    for i : -1 .. 1 by 2
	if check_collision (spriteID, w_or_b * 1, i) = 1 and spriteID.name (1) = "w"
		or check_collision (spriteID, w_or_b * 1, i) = 0 and spriteID.name (1) = "b" then
	    if spriteID.x + i * SPACE < 8 * SPACE and spriteID.y + w_or_b * 1 * SPACE < 8 * SPACE then
		highlight (i + 3).x := spriteID.x + i * SPACE
		highlight (i + 3).y := spriteID.y + w_or_b * 1 * SPACE
		draw_piece (highlight (i + 3))
	    end if
	end if
    end for
    assign_move (spriteID)
end pawn_move

% knight move algorithm
% assign highlights for 8 possible moves
proc knight_move (spriteID : sprite)
    assign_highlight (spriteID, 0, 2, -1)
    assign_highlight (spriteID, 1, 2, 1)
    assign_highlight (spriteID, 2, 1, -2)
    assign_highlight (spriteID, 3, 1, 2)
    assign_highlight (spriteID, 4, -1, 2)
    assign_highlight (spriteID, 5, -1, -2)
    assign_highlight (spriteID, 6, -2, 1)
    assign_highlight (spriteID, 7, -2, -1)
    assign_move (spriteID)
end knight_move

% king move algorithm
% assign highlights for 8 possible moves
proc king_move (spriteID : sprite)
    assign_highlight (spriteID, 0, 1, -1)
    assign_highlight (spriteID, 1, 1, 0)
    assign_highlight (spriteID, 2, 1, 1)
    assign_highlight (spriteID, 3, 0, 1)
    assign_highlight (spriteID, 4, -1, 1)
    assign_highlight (spriteID, 5, -1, 0)
    assign_highlight (spriteID, 6, -1, -1)
    assign_highlight (spriteID, 7, 0, -1)
    assign_move (spriteID)
end king_move

% castle, bishop, queen move algorithm
% assign highlights to castle, bishop, and queen (repeated moves)
proc c_or_b_or_q_move (spriteID : sprite)
    % for loops exit when the piece can no longer move (a piece is in the way)
    for i : 1 .. spriteID.maxv
	if assign_highlight_2 (spriteID, i, i, 0) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxh
	if assign_highlight_2 (spriteID, (i + spriteID.maxv), 0, i) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxd
	if assign_highlight_2 (spriteID, (i + spriteID.maxv + spriteID.maxh), i, i) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxv
	if assign_highlight_2 (spriteID, (i + spriteID.maxv + spriteID.maxh + spriteID.maxd), -i, 0) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxh
	if assign_highlight_2 (spriteID, (i + 2 * spriteID.maxv + spriteID.maxh + spriteID.maxd), 0, -i) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxd
	if assign_highlight_2 (spriteID, (i + 2 * spriteID.maxv + 2 * spriteID.maxh + spriteID.maxd), i, -i) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxd
	if assign_highlight_2 (spriteID, (i + 2 * spriteID.maxv + 2 * spriteID.maxh + 2 * spriteID.maxd), -i, i) = 0 then
	    exit
	end if
    end for
    for i : 1 .. spriteID.maxd
	if assign_highlight_2 (spriteID, (i + 2 * spriteID.maxv + 2 * spriteID.maxh + 3 * spriteID.maxd), -i, -i) = 0 then
	    exit
	end if
    end for
    assign_move (spriteID)
end c_or_b_or_q_move
