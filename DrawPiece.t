% displays a sprite on the board
proc draw_piece (spriteID : sprite)
    if spriteID.x >= 0 and spriteID.y >= 0 then
	Sprite.SetPosition (spriteID.spr, spriteID.x, spriteID.y, false)
	% set height for layering - board on bottom, then highlights, then pieces on top
	if spriteID.name (1) not= "h" and spriteID.name not= "background" then
	    Sprite.SetHeight (spriteID.spr, 3)
	elsif spriteID.name = "highlight" then
	    Sprite.SetHeight (spriteID.spr, 2)
	else
	    Sprite.SetHeight (spriteID.spr, 1)
	end if
	Sprite.Show (spriteID.spr)
    end if
end draw_piece
