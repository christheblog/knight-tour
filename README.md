# Knight's tour #

A small PROLOG program solving the classic Open/Closed/Holy Knight's Tour problems :
https://en.wikipedia.org/wiki/Knight%27s_tour

Implementation is a straight-forward search algorithm, relying on backtracking to explore all possibilities.
Warnsdorff's rule has been implemented.

The predicates ``solve_open_tour/3``, ``solve_closed_tour/3`` and ``solve_holy_tour/4`` are using a common solver.


### Open Knight's Tour ###

```prolog
% Solving a small tour
solve_open_tour(board(4, 3), pos(4, 3), OpenTour).

OpenTour = [
	pos(3, 4), pos(2, 2), pos(1, 4), pos(3, 3), 
	pos(2, 1), pos(1, 3), pos(3, 2), pos(1, 1), 
	pos(2, 3), pos(3, 1), pos(1, 2), pos(2, 4)] ;
OpenTour = [
	pos(3, 4), pos(2, 2), pos(1, 4), pos(3, 3), 
	pos(2, 1), pos(1, 3), pos(3, 2), pos(2, 4), 
	pos(1, 2), pos(3, 1), pos(2, 3), pos(1, 1)] ;


% Bigger tours can also be solved ...
solve_open_tour(board(50, 50), pos(1, 1), R).

```

### Closed Knight's Tour ###

```prolog
solve_closed_tour(board(6,5), pos(1,2), ClosedTour).

ClosedTour = [
	pos(1, 2), pos(3, 1), pos(5, 2), pos(6, 4), pos(4, 5), pos(2, 4), 
	pos(3, 2), pos(1, 1), pos(2, 3), pos(1, 5), pos(3, 4), pos(5, 5), 
	pos(6, 3), pos(5, 1), pos(4, 3), pos(3, 5), pos(1, 4), pos(2, 2), 
	pos(4, 1), pos(6, 2), pos(5, 4), pos(4, 2), pos(6, 1), pos(5, 3), 
	pos(6, 5), pos(4, 4), pos(2, 5), pos(1, 3), pos(2, 1), pos(3, 3), 
	pos(1, 2)] ;
...
```

### Holy Knight's Tour ###

A knight's tour where some positions of the chessboard are forbidden. 
The implementation is reusing the same solver, but the initial list of available positions is taken as an input.

Example solved is taken from Rosetta Code website : https://rosettacode.org/wiki/Solve_a_Holy_Knight%27s_tour

```prolog
% Example taken from Rosetta Code
% We are inputing allowed positions (and NOT forbidden ones) on the board 8 x 8
Allowed = [
	pos(2,1),pos(3,1),pos(4,1),
	pos(2,2),pos(4,2),pos(5,2),
	pos(2,3),pos(3,3),pos(4,3),pos(5,3),pos(6,3),pos(7,3),pos(8,3),
	pos(1,4),pos(2,4),pos(3,4),pos(6,4),pos(8,4),
	pos(1,5),pos(3,5),pos(6,5),pos(7,5),pos(8,5),
	pos(1,6),pos(2,6),pos(3,6),pos(4,6),pos(5,6),pos(7,6),pos(8,6),
	pos(3,7),pos(4,7),pos(6,7),
	pos(4,8),pos(5,8),pos(6,8)],
solve_holy_tour(board(8,8), pos(1,6), Allowed, HolyTour).

HolyTour = [
	pos(1, 6), pos(3, 5), pos(1, 4), pos(3, 3), pos(2, 1), 
	pos(4, 2), pos(2, 3), pos(1, 5), pos(3, 4), pos(2, 2), 
	pos(4, 1), pos(5, 3), pos(6, 5), pos(8, 6), pos(6, 7), 
	pos(4, 6), pos(5, 8), pos(3, 7), pos(5, 6), pos(4, 8), 
	pos(3, 6), pos(2, 4), pos(4, 3), pos(3, 1), pos(5, 2), 
	pos(7, 3), pos(8, 5), pos(6, 4), pos(8, 3), pos(7, 5), 
	pos(6, 3), pos(8, 4), pos(7, 6), pos(6, 8), pos(4, 7), 
	pos(2, 6)] ;
...
```