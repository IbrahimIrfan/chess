% display intro screen
proc intro_screen
    drawfillbox (0, 0, maxx, maxy, black) % background
    Pic.Draw (pics(15), 10, 0, picCopy)
    Font.Draw ("Chess", 250, 350, font2, 0)
    
    % buttons
    Draw.FillBox (50, 240, 200, 300, 40)
    Draw.FillBox (250, 240, 400, 300, 40)
    Draw.FillBox (450, 240, 600, 300, 40)
    Font.Draw ("Play", 85, 260, font1, 0)
    Font.Draw ("Rules", 275, 260, font1, 0)
    Font.Draw ("Quit", 490, 260, font1, 0)
    
    % checks if buttons are clicked
    loop
	mousewhere (x, y, button)
	exit when x > 50 and y > 240 and x < 200 and y < 300 and button = 1
	exit when x > 250 and y > 240 and x < 400 and y < 300 and button = 1
	% quit program when quit is pressed
	if x > 450 and y > 240 and x < 600 and y < 300 and button = 1 then
	    quit
	end if
    end loop
end intro_screen
