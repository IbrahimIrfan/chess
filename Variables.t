% the pixel value of one square of the board
const SPACE := 49

% piece with coords, move values, name, and sprite
type sprite :
    record
	x, y, spr, maxv, maxh, maxd : int
	name : string
    end record
    
% array of pointers to all 32 pieces
var pointers : array 0 .. 31 of unchecked pointer to sprite

% move, turn, and score count
var move, turn, w_score, b_score : int 

% one array for all pictures
var pics : array 1 .. 21 of int

% x, y, button for click detection, and font variables for fonts
var x, y, button, font1, font2, font3, font4 : int

% varibales to indicate check and forfeit
var check, w_forfeit, b_forfeit : boolean 

% assign fonts
font1 := Font.New ("arial:25:bold")
font2 := Font.New ("palatino:32:italic")
font3 := Font.New ("arial:10:bold")
font4 := Font.New ("arial:13:bold")

% assign pics
pics (1) := Pic.FileNew ("piece1.bmp")
pics (2) := Pic.FileNew ("piece2.bmp")
pics (3) := Pic.FileNew ("piece3.bmp")
pics (4) := Pic.FileNew ("piece4.bmp")
pics (5) := Pic.FileNew ("piece5.bmp")
pics (6) := Pic.FileNew ("piece6.bmp")
pics (7) := Pic.FileNew ("piece7.bmp")
pics (8) := Pic.FileNew ("piece8.bmp")
pics (9) := Pic.FileNew ("piece9.bmp")
pics (10) := Pic.FileNew ("piece10.bmp")
pics (11) := Pic.FileNew ("piece11.bmp")
pics (12) := Pic.FileNew ("piece12.bmp")
pics (13) := Pic.FileNew ("chessboard.bmp")
pics (14) := Pic.FileNew ("highlight.bmp")
pics (15) := Pic.FileNew ("chess-set-clipart.bmp")
pics (16) := Pic.FileNew ("rules1.bmp")
pics (17) := Pic.FileNew ("rules2.bmp")
pics (18) := Pic.FileNew ("rules3.bmp")
pics (19) := Pic.FileNew ("rules4.bmp")
pics (20) := Pic.FileNew ("rules5.bmp")
pics (21) := Pic.FileNew ("play.bmp")

% declare sprite arrays
var w_pawns, b_pawns : array 0 .. 7 of sprite
var w_bishops, w_knights, w_castles, b_bishops, b_knights, b_castles : array 0 .. 1 of sprite
var background, w_queen, w_king, b_queen, b_king : sprite
var highlight : array 0 .. 200 of sprite
