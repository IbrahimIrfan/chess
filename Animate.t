% hide highlights, animate sprite, detect check and sprite overlap
proc animate (piece : unchecked pointer to sprite)
    if move not= 0 then % if the user has moved
	% hide highlights
	for j : 0 .. 56
	    Sprite.Hide (highlight (j).spr)
	end for
	if turn = 0 then % white turn
	    % animate piece
	    ^piece.x := highlight (move - 1).x
	    ^piece.y := highlight (move - 1).y
	    case ^piece.name of
		label ("wpawn") :
		    Sprite.Animate ( ^piece.spr, pics (1), ^piece.x, ^piece.y, false)
		label ("wbishop") :
		    Sprite.Animate ( ^piece.spr, pics (4), ^piece.x, ^piece.y, false)
		label ("wknight") :
		    Sprite.Animate ( ^piece.spr, pics (5), ^piece.x, ^piece.y, false)
		label ("wcastle") :
		    Sprite.Animate ( ^piece.spr, pics (6), ^piece.x, ^piece.y, false)
		label ("wqueen") :
		    Sprite.Animate ( ^piece.spr, pics (2), ^piece.x, ^piece.y, false)
		label ("wking") :
		    Sprite.Animate ( ^piece.spr, pics (3), ^piece.x, ^piece.y, false)
	    end case
	
	    % make screen blue again
	    if check = true then
		drawfillbox (0, 0, maxx, maxy, blue)
		check := false
	    end if
	
	    % reset highlights
	    for i : 0 .. 15
		highlight (i).x := 10000
	    end for

	    % check detection
	    detect_check_w
	    for i : 0 .. 1
		for j : 1 .. 8
		    exit when detect_check_final (w_castles (i), j, 0, 1) not= 2
		end for
		for j : 9 .. 15
		    exit when detect_check_final (w_castles (i), 0, (j - 8), 1) not= 2
		end for
		for j : 16 .. 22
		    exit when detect_check_final (w_castles (i), - (j - 15), 0, 1) not= 2
		end for
		for j : 23 .. 29
		    exit when detect_check_final (w_castles (i), 0, - (j - 22), 1) not= 2
		end for
		for j : 1 .. 8
		    exit when detect_check_final (w_bishops (i), j, j, 1) not= 2
		end for
		for j : 9 .. 15
		    exit when detect_check_final (w_bishops (i), - (j - 8), (j - 8), 1) not= 2
		end for
		for j : 16 .. 22
		    exit when detect_check_final (w_bishops (i), - (j - 15), - (j - 15), 1) not= 2
		end for
		for j : 23 .. 29
		    exit when detect_check_final (w_bishops (i), (j - 22), - (j - 22), 1) not= 2
		end for
	    end for
	    for j : 1 .. 8
		exit when detect_check_final (w_queen, j, 0, 1) not= 2
	    end for
	    for j : 9 .. 15
		exit when detect_check_final (w_queen, 0, (j - 8), 1) not= 2
	    end for
	    for j : 16 .. 22
		exit when detect_check_final (w_queen, - (j - 15), 0, 1) not= 2
	    end for
	    for j : 23 .. 29
		exit when detect_check_final (w_queen, 0, - (j - 22), 1) not= 2
	    end for
	    for j : 30 .. 36
		exit when detect_check_final (w_queen, (j - 29), (j - 29), 1) not= 2
	    end for
	    for j : 37 .. 43
		exit when detect_check_final (w_queen, - (j - 36), (j - 36), 1) not= 2
	    end for
	    for j : 44 .. 50
		exit when detect_check_final (w_queen, - (j - 43), - (j - 43), 1) not= 2
	    end for
	    for j : 51 .. 57
		exit when detect_check_final (w_queen, (j - 50), - (j - 50), 1) not= 2
	    end for


	    % checkmate detection has been commented out since it is buggy
	    % and does not work consistently
	    /*
	     detect_check_mate_w
	     for i : 0 .. 1
	     for j : 1 .. 8
	     exit when detect_check_mate_final (w_castles (i), j, 0, 1) not= 2
	     end for
	     for j : 9 .. 15
	     exit when detect_check_mate_final (w_castles (i), 0, (j - 8), 1) not= 2
	     end for
	     for j : 16 .. 22
	     exit when detect_check_mate_final (w_castles (i), - (j - 15), 0, 1) not= 2
	     end for
	     for j : 23 .. 29
	     exit when detect_check_mate_final (w_castles (i), 0, - (j - 22), 1) not= 2
	     end for
	     for j : 1 .. 8
	     exit when detect_check_mate_final (w_bishops (i), j, j, 1) not= 2
	     end for
	     for j : 9 .. 15
	     exit when detect_check_mate_final (w_bishops (i), - (j - 8), (j - 8), 1) not= 2
	     end for
	     for j : 16 .. 22
	     exit when detect_check_mate_final (w_bishops (i), - (j - 15), - (j - 15), 1) not= 2
	     end for
	     for j : 23 .. 29
	     exit when detect_check_mate_final (w_bishops (i), (j - 22), - (j - 22), 1) not= 2
	     end for
	     end for
	     for j : 1 .. 8
	     exit when detect_check_mate_final (w_queen, j, 0, 1) not= 2
	     end for
	     for j : 9 .. 15
	     exit when detect_check_mate_final (w_queen, 0, (j - 8), 1) not= 2
	     end for
	     for j : 16 .. 22
	     exit when detect_check_mate_final (w_queen, - (j - 15), 0, 1) not= 2
	     end for
	     for j : 23 .. 29
	     exit when detect_check_mate_final (w_queen, 0, - (j - 22), 1) not= 2
	     end for
	     for j : 30 .. 36
	     exit when detect_check_mate_final (w_queen, (j - 29), (j - 29), 1) not= 2
	     end for
	     for j : 37 .. 43
	     exit when detect_check_mate_final (w_queen, - (j - 36), (j - 36), 1) not= 2
	     end for
	     for j : 44 .. 50
	     exit when detect_check_mate_final (w_queen, - (j - 43), - (j - 43), 1) not= 2
	     end for
	     for j : 51 .. 57
	     exit when detect_check_mate_final (w_queen, (j - 50), - (j - 50), 1) not= 2
	     end for
	     */
	    delay (50)
	    turn := 1 % switch turns
	else % black turn
	    % animate piece
	    ^piece.x := highlight (move - 1).x
	    ^piece.y := highlight (move - 1).y
	    case ^piece.name of
		label ("bpawn") :
		    Sprite.Animate ( ^piece.spr, pics (7), ^piece.x, ^piece.y, false)
		label ("bbishop") :
		    Sprite.Animate ( ^piece.spr, pics (10), ^piece.x, ^piece.y, false)
		label ("bknight") :
		    Sprite.Animate ( ^piece.spr, pics (11), ^piece.x, ^piece.y, false)
		label ("bcastle") :
		    Sprite.Animate ( ^piece.spr, pics (12), ^piece.x, ^piece.y, false)
		label ("bqueen") :
		    Sprite.Animate ( ^piece.spr, pics (8), ^piece.x, ^piece.y, false)
		label ("bking") :
		    Sprite.Animate ( ^piece.spr, pics (9), ^piece.x, ^piece.y, false)
	    end case

	    % make screen blue again
	    if check = true then
		drawfillbox (0, 0, maxx, maxy, blue)
		check := false
	    end if
    
	    % reset highlights
	    for i : 0 .. 15
		highlight (i).x := 10000
	    end for

	    % check detection
	    detect_check_b
	    for i : 0 .. 1
		for j : 1 .. 8
		    exit when detect_check_final (b_castles (i), j, 0, 0) not= 2
		end for
		for j : 9 .. 15
		    exit when detect_check_final (b_castles (i), 0, (j - 8), 0) not= 2
		end for
		for j : 16 .. 22
		    exit when detect_check_final (b_castles (i), - (j - 15), 0, 0) not= 2
		end for
		for j : 23 .. 29
		    exit when detect_check_final (b_castles (i), 0, - (j - 22), 0) not= 2
		end for
		for j : 1 .. 8
		    exit when detect_check_final (b_bishops (i), j, j, 0) not= 2
		end for
		for j : 9 .. 15
		    exit when detect_check_final (b_bishops (i), - (j - 8), (j - 8), 0) not= 2
		end for
		for j : 16 .. 22
		    exit when detect_check_final (b_bishops (i), - (j - 15), - (j - 15), 0) not= 2
		end for
		for j : 23 .. 29
		    exit when detect_check_final (b_bishops (i), (j - 22), - (j - 22), 0) not= 2
		end for
	    end for
	    for j : 1 .. 8
		exit when detect_check_final (b_queen, j, 0, 0) not= 2
	    end for
	    for j : 9 .. 15
		exit when detect_check_final (b_queen, 0, (j - 8), 0) not= 2
	    end for
	    for j : 16 .. 22
		exit when detect_check_final (b_queen, - (j - 15), 0, 0) not= 2
	    end for
	    for j : 23 .. 29
		exit when detect_check_final (b_queen, 0, - (j - 22), 0) not= 2
	    end for
	    for j : 30 .. 36
		exit when detect_check_final (b_queen, (j - 29), (j - 29), 0) not= 2
	    end for
	    for j : 37 .. 43
		exit when detect_check_final (b_queen, - (j - 36), (j - 36), 0) not= 2
	    end for
	    for j : 44 .. 50
		exit when detect_check_final (b_queen, - (j - 43), - (j - 43), 0) not= 2
	    end for
	    for j : 51 .. 57
		exit when detect_check_final (b_queen, (j - 50), - (j - 50), 0) not= 2
	    end for

	    % checkmate detection has been commented out since it is buggy
	    % and does not work consistently
	   /*
	     detect_check_mate_b
	     for i : 0 .. 1
	     for j : 1 .. 8
	     exit when detect_check_mate_final (b_castles (i), j, 0, 0) not= 2
	     end for
	     for j : 9 .. 15
	     exit when detect_check_mate_final (b_castles (i), 0, (j - 8), 0) not= 2
	     end for
	     for j : 16 .. 22
	     exit when detect_check_mate_final (b_castles (i), - (j - 15), 0, 0) not= 2
	     end for
	     for j : 23 .. 29
	     exit when detect_check_mate_final (b_castles (i), 0, - (j - 22), 0) not= 2
	     end for
	     for j : 1 .. 8
	     exit when detect_check_mate_final (b_bishops (i), j, j, 0) not= 2
	     end for
	     for j : 9 .. 15
	     exit when detect_check_mate_final (b_bishops (i), - (j - 8), (j - 8), 0) not= 2
	     end for
	     for j : 16 .. 22
	     exit when detect_check_mate_final (b_bishops (i), - (j - 15), - (j - 15), 0) not= 2
	     end for
	     for j : 23 .. 29
	     exit when detect_check_mate_final (b_bishops (i), (j - 22), - (j - 22), 0) not= 2
	     end for
	     end for
	     for j : 1 .. 8
	     exit when detect_check_mate_final (b_queen, j, 0, 0) not= 2
	     end for
	     for j : 9 .. 15
	     exit when detect_check_mate_final (b_queen, 0, (j - 8), 0) not= 2
	     end for
	     for j : 16 .. 22
	     exit when detect_check_mate_final (b_queen, - (j - 15), 0, 0) not= 2
	     end for
	     for j : 23 .. 29
	     exit when detect_check_mate_final (b_queen, 0, - (j - 22), 0) not= 2
	     end for
	     for j : 30 .. 36
	     exit when detect_check_mate_final (b_queen, (j - 29), (j - 29), 0) not= 2
	     end for
	     for j : 37 .. 43
	     exit when detect_check_mate_final (b_queen, - (j - 36), (j - 36), 0) not= 2
	     end for
	     for j : 44 .. 50
	     exit when detect_check_mate_final (b_queen, - (j - 43), - (j - 43), 0) not= 2
	     end for
	     for j : 51 .. 57
	     exit when detect_check_mate_final (b_queen, (j - 50), - (j - 50), 0) not= 2
	     end for
	     */
	    delay (50)
	    turn := 0 % switch turn
	end if
	% check if piece has been taken
	for i : 0 .. 31
	    detect_sprite_overlap ( ^piece, pointers (i))
	end for
    end if
    move := 0
end animate
