:- export(solve_open_tour/3).
:- export(solve_closed_tour/3).
:- export(solve_holy_tour/3).


%%
%%	Main predicates to solve Knight's Tour problems
%%

% Open Knight's Tour problem
solve_open_tour(board(W,H), pos(X,Y), Tour) :-
	positions(board(W,H), All),
	delete(All, pos(X,Y), StartPos),
	solve(board(W,H), pos(X,Y), StartPos, Tour).
	
% Closed Knight's Tour problem
solve_closed_tour(board(W,H), pos(X,Y), ClosedTour) :-
	solve_open_tour(board(W,H), pos(X,Y),R),
	last(R,Last),
	move(Last,LastMove),               % Simulating a move from the last position
	member(pos(X,Y),LastMove),         % Check the start position can be reached
	append(R,[pos(X,Y)], ClosedTour).  % Adds the start position at the end

% Holy Knight's Tour problem
solve_holy_tour(board(W,H), pos(X,Y), Allowed, HolyTour) :-
	delete(Allowed, pos(X,Y), StartPos),
	solve(board(W,H), pos(X,Y), StartPos, HolyTour).


%%
%%	Solver
%%

solve(_, pos(X,Y), [], [pos(X,Y)]).
solve(board(W,H), pos(X,Y), Allowed, [pos(X,Y)|R]) :-
	%move(board(W,H), pos(X,Y), Moves),           % Uncomment the line to experience a search without warnsdoff's rule
	warnsdoff_move(board(W,H), pos(X,Y), Allowed, Moves), %  Warnsdoff's rule used to order the moves
	member(pos(Hx,Hy), Moves),                   % Iterating by backtracking on all possible moves
	member(pos(Hx,Hy),Allowed),                  % Making sure the move is allowed
	delete(Allowed, pos(Hx,Hy), Remaining),      % Removing the move from the list of available positions
	solve(board(W,H), pos(Hx,Hy), Remaining, R). % Solving recursively for the remaining positions


%%
%%	Helpers
%%

% Moves for a knight from a given position
move(pos(X,Y), R) :-
	X1 is X-2, Y1 is Y-1,
	X2 is X-1, Y2 is Y-2,
	X3 is X-2, Y3 is Y+1,
	X4 is X-1, Y4 is Y+2,
	X5 is X+2, Y5 is Y-1,
	X6 is X+1, Y6 is Y-2,
	X7 is X+2, Y7 is Y+1,
	X8 is X+1, Y8 is Y+2,
	R = [pos(X1,Y1), pos(X2,Y2),
	     pos(X3,Y3), pos(X4,Y4),
	     pos(X5,Y5), pos(X6,Y6),
	     pos(X7,Y7), pos(X8,Y8)].

% Moves on the board for a knight, from a given position
move(board(W,H), pos(X,Y), R) :-
	move(pos(X,Y), AllMoves),           % Finding all possible moves from the (X,Y)
	on_board(board(W,H), AllMoves, R).  % making sure moves are on the board


% Warnsdorff's rule
% Select moves with less possibility first (lookahead)

% Count how many possibilities from the given location, taking in account available positions
% Returns a tuple Count-pos(X,Y)
lookahead(board(W,H), Available, pos(X,Y), R) :- 
	move(board(W,H), pos(X,Y), NextMoves),
	findall(P, (member(P, NextMoves), member(P, Available)), Possible),
	length(Possible, L),
	R=L-pos(X,Y).

% Orders possible moves according to warnsdoff's rule	
warnsdoff_move(board(W,H), pos(X,Y), Available, R) :-
	move(board(W,H), pos(X,Y), Possible),
	findall(Res, (member(P, Possible), member(P, Available), lookahead(board(W,H),Available,P,Res)), Counts),
	sort(1,=<,Counts,Sorted), % Sorting by ascending counts
	findall(Candidate,member(_-Candidate,Sorted),R).

% Generates all available positions for a board W x H
positions(board(W,H), R) :-
	W > 1, H > 1,
	findall(P,(numlist(1,W,Xs), member(X,Xs), numlist(1,H,Ys), member(Y,Ys), P=pos(X,Y)), R).

% Filters the list of positions or moves, keeping only the ones that ARE on the board
on_board(_,[],[]).
on_board(board(W,H),[pos(X,Y)|T],[pos(X,Y)|R]) :-
	X > 0 , X =< W, Y > 0, Y =< H, !,
	on_board(board(W,H),T,R).
on_board(board(W,H),[_|T],R) :-
	on_board(board(W,H),T,R).
