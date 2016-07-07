%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% solver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 盤をドミノタイルで埋め尽くすことができる。
% can_put_tile(+board)
can_put_tile([Line|Lines]) :-
    put_tile(1,Line,Lines).

% put_tile(+tile, +line, +lines)
put_tile(_,[],[]). % 最後に達しました。盤は空白なく埋め尽くされました。
put_tile(Tile,[],[NextLine|Lines]) :- % この行の最後に達したので次の行を調べます。
    put_tile(Tile,NextLine,Lines).
put_tile(Tile,[Cell|Line],Lines) :- % 既にタイルがあるのでスキップします。
    nonvar(Cell),
    put_tile(Tile,Line,Lines).
put_tile(Tile,[Tile,Tile|Line],Lines) :- % 横に置きます。
    NextTile is Tile+1,
    put_tile(NextTile,Line,Lines).
put_tile(Tile,[Tile|Line],[NextLine|Lines]) :- % 縦に置きます。
    length(Line,Length),
    put_vertical_tile(Tile,Length,NextLine),
    NextTile is Tile+1,
    put_tile(NextTile,Line,[NextLine|Lines]).

% put_vertical_tile(+tile, +length, +line)
put_vertical_tile(Tile,Length,[Tile|Line]) :- % 次の列の適切な場所に縦のタイルを置きます。
    length(Line,Length),!.
put_vertical_tile(Tile,Length,[_|Line]) :-
    put_vertical_tile(Tile,Length,Line).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% sample problem
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% i.e.
%  board_4_a(B),can_put_tile(B).

board_4_0(
    [[A1,A2,A3,A4],
     [B1,B2,B3,B4],
     [C1,C2,C3,C4],
     [D1,D2,D3,D4]]).

% 1問目 http://senseicode.club/2-cs-vs-programming
board_4_a(
    [[A1,0, A3,A4],
     [B1,B2,B3,B4],
     [C1,C2,0, C4],
     [D1,D2,D3,D4]]).
% 2問目 http://senseicode.club/2-cs-vs-programming
board_4_b(
    [[0,A2,A3,A4],
     [B1,B2,B3,B4],
     [C1,C2,C3,C4],
     [D1,D2,D3,0]]).

% memo.
% ruby -e '("A".."H").map{|x|puts "["+(1..8).map{|i|x+i.to_s}.join(",")+"],"}'
board_8_0(
        [[A1,A2,A3,A4,A5,A6,A7,A8],
         [B1,B2,B3,B4,B5,B6,B7,B8],
         [C1,C2,C3,C4,C5,C6,C7,C8],
         [D1,D2,D3,D4,D5,D6,D7,D8],
         [E1,E2,E3,E4,E5,E6,E7,E8],
         [F1,F2,F3,F4,F5,F6,F7,F8],
         [G1,G2,G3,G4,G5,G6,G7,G8],
         [H1,H2,H3,H4,H5,H6,H7,H8]]).

% 解けない。10秒程度。
board_8_1(
        [[0, A2,A3,A4,A5,A6,A7,A8],
         [B1,B2,B3,B4,B5,B6,B7,B8],
         [C1,C2,C3,C4,C5,C6,C7,C8],
         [D1,D2,D3,D4,D5,D6,D7,D8],
         [E1,E2,E3,E4,E5,E6,E7,E8],
         [F1,F2,F3,F4,F5,F6,F7,F8],
         [G1,G2,G3,G4,G5,G6,G7,G8],
         [H1,H2,H3,H4,H5,H6,H7,0 ]]).
