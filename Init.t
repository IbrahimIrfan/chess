% initalizes values before game starts
proc init_board
    cls
    drawbox (0, 0, 392, 392, black) % black border around board
    drawfillbox (0, 0, maxx, maxy, blue) % background
    Font.Draw ("White's turn", 450, 40, font4, white) % first turn
    % forfeit button
    drawfillbox (450, 180, 600, 230, yellow)
    Font.Draw ("Forfeit", 470, 195, font1, black)
    % initialize values
    move := 0
    turn := 0
    w_score := 0
    b_score := 0
    check := false
    w_forfeit := false
    b_forfeit := false
    
    % assign sprite pics and values to pawns and highlight
    for i : 0 .. 200
	if i <= 7 then
	    w_pawns (i).spr := Sprite.New (pics (1))
	    b_pawns (i).spr := Sprite.New (pics (7))
	end if
	highlight (i).spr := Sprite.New (pics (14))
	highlight (i).x := 10000
	highlight (i).y := 10000
	highlight(i).name := "highlight"
    end for

    % assign sprite pics to bishops, knights, castles
    for i : 0 .. 1
	w_bishops (i).spr := Sprite.New (pics (4))
	w_bishops (i).maxv := 0
	w_bishops (i).maxh := 0
	w_bishops (i).maxd := 7

	w_knights (i).spr := Sprite.New (pics (5))

	w_castles (i).spr := Sprite.New (pics (6))
	w_castles (i).maxv := 7
	w_castles (i).maxh := 7
	w_castles (i).maxd := 0

	b_bishops (i).spr := Sprite.New (pics (10))
	b_bishops (i).maxv := 0
	b_bishops (i).maxh := 0
	b_bishops (i).maxd := 7

	b_knights (i).spr := Sprite.New (pics (11))

	b_castles (i).spr := Sprite.New (pics (12))
	b_castles (i).maxv := 7
	b_castles (i).maxh := 7
	b_castles (i).maxd := 0
    end for

    % assign sprite pics to background, queens, and kings
    background.spr := Sprite.New (pics (13))
    w_queen.spr := Sprite.New (pics (2))
    w_queen.maxv := 7
    w_queen.maxh := 7
    w_queen.maxd := 7
    w_king.spr := Sprite.New (pics (3))
    b_queen.spr := Sprite.New (pics (8))
    b_queen.maxv := 7
    b_queen.maxh := 7
    b_queen.maxd := 7
    b_king.spr := Sprite.New (pics (9))

    % initialize and draw background
    background.x := 0
    background.y := 0
    background.name := "background"
    draw_piece (background)

    % initialize and draw pawns
    for i : 0 .. 343 by SPACE
	w_pawns (i div SPACE).x := i
	w_pawns (i div SPACE).y := SPACE
	w_pawns (i div SPACE).name := "wpawn"
	draw_piece (w_pawns (i div SPACE))

	b_pawns (i div SPACE).x := i
	b_pawns (i div SPACE).y := 6 * SPACE
	b_pawns (i div SPACE).name := "bpawn"
	draw_piece (b_pawns (i div SPACE))
    end for

    % initialize and draw bishops
    for i : 2 .. 5 by 3
	w_bishops (i div 3).x := i * SPACE
	w_bishops (i div 3).y := 0
	w_bishops (i div 3).name := "wbishop"
	draw_piece (w_bishops (i div 3))

	b_bishops (i div 3).x := i * SPACE
	b_bishops (i div 3).y := 7 * SPACE
	b_bishops (i div 3).name := "bbishop"
	draw_piece (b_bishops (i div 3))
    end for

    % initialize and draw knights
    for i : 1 .. 6 by 5
	w_knights (i div 5).x := i * SPACE
	w_knights (i div 5).y := 0
	w_knights (i div 5).name := "wknight"
	draw_piece (w_knights (i div 5))

	b_knights (i div 5).x := i * SPACE
	b_knights (i div 5).y := 7 * SPACE
	b_knights (i div 5).name := "bknight"
	draw_piece (b_knights (i div 5))
    end for

    % initialize and draw castles
    for i : 0 .. 7 by 7
	w_castles (i div 7).x := i * SPACE
	w_castles (i div 7).y := 0
	w_castles (i div 7).name := "wcastle"
	draw_piece (w_castles (i div 7))

	b_castles (i div 7).x := i * SPACE
	b_castles (i div 7).y := 7 * SPACE
	b_castles (i div 7).name := "bcastle"
	draw_piece (b_castles (i div 7))
    end for

    % initialize and draw queens and kings
    w_queen.x := 4 * SPACE
    w_queen.y := 0
    w_queen.name := "wqueen"
    draw_piece (w_queen)

    w_king.x := 3 * SPACE
    w_king.y := 0
    w_king.name := "wking"
    draw_piece (w_king)

    b_queen.x := 4 * SPACE
    b_queen.y := 7 * SPACE
    b_queen.name := "bqueen"
    draw_piece (b_queen)

    b_king.x := 3 * SPACE
    b_king.y := 7 * SPACE
    b_king.name := "bking"
    draw_piece (b_king)

    % initialize 32 pointers to the address of the piece sprites
    for i : 0 .. 7
	#pointers (i) := addr (w_pawns (i))
    end for
    for i : 8 .. 9
	#pointers (i) := addr (w_knights (i - 8))
    end for
    for i : 10 .. 11
	#pointers (i) := addr (w_bishops (i - 10))
    end for
    for i : 12 .. 13
	#pointers (i) := addr (w_castles (i - 12))
    end for
    #pointers (14) := addr (w_queen)
    #pointers (15) := addr (w_king)
    for i : 16 .. 23
	#pointers (i) := addr (b_pawns (i - 16))
    end for
    for i : 24 .. 25
	#pointers (i) := addr (b_knights (i - 24))
    end for
    for i : 26 .. 27
	#pointers (i) := addr (b_bishops (i - 26))
    end for
    for i : 28 .. 29
	#pointers (i) := addr (b_castles (i - 28))
    end for
    #pointers (30) := addr (b_queen)
    #pointers (31) := addr (b_king)
end init_board
