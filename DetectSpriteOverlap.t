% if sprites of opp. colour overlap, increase appropriate score and hide sprite (piece is taken)
proc detect_sprite_overlap (spriteID : sprite, overlap : unchecked pointer to sprite)
    % if opp colour and overlap is true then hide sprite and update score
    if ^overlap.y = spriteID.y and ^overlap.x = spriteID.x and ^overlap.name (1) not= spriteID.name (1) then
	^overlap.x := 10000
	Sprite.Hide ( ^overlap.spr)
	if ^overlap.name (1) = "w" then
	    b_score := b_score + 1
	else
	    w_score := w_score + 1
	end if
    end if
end detect_sprite_overlap
