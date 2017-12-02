% dipslay score and forfeit button
proc draw_score
    Font.Draw ("White       Black", 470, 300, font4, white)
    % draw coloured box over area to display new values
    if check = true then
	drawfillbox (480, 265, 600, 285, red)
    else
	drawfillbox (480, 265, 600, 285, blue)
    end if
    % score values
    Font.Draw (intstr (w_score), 485, 270, font4, white)
    Font.Draw (intstr (b_score), 550, 270, font4, white)
    % forfeit button
    drawfillbox (450, 180, 600, 230, yellow)
    Font.Draw ("Forfeit", 470, 195, font1, black)
end draw_score
