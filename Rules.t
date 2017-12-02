proc rules_screen
    cls
    drawfillbox (0, 0, maxx, maxy, black) % background
    Font.Draw ("Rules", 250, 350, font2, 0)

    % back button
    Draw.FillBox (250, 10, 400, 70, 40)
    Font.Draw ("Back", 285, 30, font1, 0)

    % animation start and play button pictures
    Pic.Draw (pics (16), 0, 30, picCopy)
    Pic.Draw (pics (21), 80, 10, picCopy)

    % instructions and troubleshooting
    Font.Draw ("Move a piece by first clicking on it to see the available (highlighted in blue)", 20, 320, font4, white)
    Font.Draw ("moves, and then clicking on a highlighted tile to move the piece to that", 20, 300, font4, white)
    Font.Draw ("location (see the animation below). The screen becomes red for check, yellow", 20, 280, font4, white)
    Font.Draw ("for checkmate, and black when the game ends. The game ends when a user", 20, 260, font4, white)
    Font.Draw ("takes the opponent's king or forfeits. All classic chess rules apply.", 20, 240, font4, white)
    Font.Draw ("Troubleshooting:", 200, 220, font4, white)
    Font.Draw ("The program does not have any known cases where it consistently", 200, 200, font3, white)
    Font.Draw ("crashes. This is due to the fact that there are so many possibilities in", 200, 180, font3, white)
    Font.Draw ("a chess game that it is hard to pinpoint why the program may crash.", 200, 160, font3, white)
    Font.Draw ("If the program does crash, however, it is most likely due to it", 200, 140, font3, white)
    Font.Draw ("checking so many conditions at once and checking the wrong thing", 200, 120, font3, white)
    Font.Draw ("at the wrong time. In this case, restart the program to start a", 200, 100, font3, white)
    Font.Draw ("new game.", 200, 80, font3, white)

    loop
	mousewhere (x, y, button)
	% exit when back is pressed
	exit when x > 250 and y > 10 and x < 400 and y < 70 and button = 1
	% if play is pressed, then show animation
	if x > 80 and x < 96 and y > 10 and y < 27 and button = 1 then
	    Pic.Draw (pics (16), 0, 30, picCopy)
	    delay (1250)
	    Pic.Draw (pics (17), 0, 30, picCopy)
	    delay (750)
	    Pic.Draw (pics (18), 0, 30, picCopy)
	    delay (1250)
	    Pic.Draw (pics (19), 0, 30, picCopy)
	    delay (750)
	    Pic.Draw (pics (20), 0, 30, picCopy)
	end if
    end loop
end rules_screen
