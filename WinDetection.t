fcn detect_win : int
    % if either king has been taken, display win message and clear screen
    % result 0 for black win, 1 for white win, 2 for continue
    if w_king.x = 10000 or w_forfeit = true then
	drawfillbox (0, 0, maxx, maxy, black) % background
	Font.Draw ("Black wins!", 480, 55, font4, white)
	delay (1000)
	% hide everthing
	for i : 0 .. 31
	    Sprite.Hide ( ^ (pointers (i)).spr)
	end for
	Sprite.Hide (background.spr)
	cls
	result 0
    elsif b_king.x = 10000 or b_forfeit = true then
	drawfillbox (0, 0, maxx, maxy, black) % background
	Font.Draw ("White wins!", 480, 55, font4, white)
	delay (1000)
	% hide everthing
	for i : 0 .. 31
	    Sprite.Hide ( ^ (pointers (i)).spr)
	end for
	Sprite.Hide (background.spr)
	cls
	result 1
    end if
    result 2
end detect_win
