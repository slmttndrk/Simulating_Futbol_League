
list_length([], 0 ).                                                            % This  part finds the length of list.
list_length([_|X] , L ) :- list_length(X,Length) , L is Length+1 .

sum_list([], 0).                                                                % This  part finds the sum of elements of the list.
sum_list([H|T], Sum) :-
   sum_list(T, R),
   Sum is H + R.

pair_sorting(L,SortedList):-                                                    % This  part sorts the pairs.
        sort(1,@>=, L, SortedList).

first_n_of_list(N, _, Xs) :- N =< 0, N =:= 0, Xs = [].                          % This  part gets the first N element of a list.
first_n_of_list(_, [], []).
first_n_of_list(N, [X|Xs], [X|Ys]) :- M is N-1, first_n_of_list(M, Xs, Ys).

allTeams(List,Number) :-                                                         % This  part writes teams as list and the lenght of the list.
    findall(X, team(X, _), UnsortedList),
    permutation(UnsortedList,List),
    list_length(List,Number).


wins(T,W,L,N) :-                                                                 % This  part writes the wins in the week which you enter.
    findall(X,(match(W,T,Y,X,Z),Y>Z),L1),
    findall(X,(match(W,X,Y,T,Z),Y<Z),L2),
    append(L1,L2,L),
    list_length(L,N).

losses(T,W,L,N) :-                                                               % This  part writes the losses in the week which you enter.
    findall(X,(match(W,T,Y,X,Z),Y<Z),L1),
    findall(X,(match(W,X,Y,T,Z),Y>Z),L2),
    append(L1,L2,L),
    list_length(L,N).

draws(T,W,L,N) :-                                                                % This  part writes the draws in the week which you enter.
    findall(X,(match(W,T,Y,X,Z),Y=Z),L1),
    findall(X,(match(W,X,Y,T,Z),Y=Z),L2),
    append(L1,L2,L),
    list_length(L,N).

scored(T,W,S) :-                                                                % This  part writes the score of a team when you enter the teamname and week.
        findall(X,(match(V,T,X,_,_),V=<W),L1),
        findall(X,(match(V,_,_,T,X),V=<W),L2),
        append(L1,L2,L),
        sum_list(L,S).


conceded(T,W,C)  :-                                                            % This  part writes the concede of a team when you enter the teamname and week.
        findall(X,(match(V,T,_,_,X),V=<W),L1),
        findall(X,(match(V,_,X,T,_),V=<W),L2),
        append(L1,L2,L),
        sum_list(L,C).


average(T,W,A) :-                                                              % This  part writes the average (score - concede) of a team when you enter the teamname and week.
        findall(X,(match(V,T,X,_,_),V=<W),L1),
        findall(X,(match(V,_,_,T,X),V=<W),L2),
        append(L1,L2,L),
        sum_list(L,S),

        findall(X,(match(V,T,_,_,X),V=<W),L3),
        findall(X,(match(V,_,X,T,_),V=<W),L4),
        append(L3,L4,L5),
        sum_list(L5,C),

        A is S - C.

order(L,W) :-                                                                 % This  part writes the the list of teams sorted according to their average.
        findall(X,(match(W,L,Y,_,Z),average(L,W,X)),L1),
        findall(X,(match(W,_,Y,L,Z),average(L,W,X)),L2),
        append(L1,L2,L3),
        findall(T,match(W,T,X,_,_),L4),
        findall(T,match(W,_,_,T,X),L5),
        append(L4,L5,L6),
        pairs_keys_values(P, L3, L6),                                         % At this part I keep two lists as pairs in one list.
        pair_sorting(P,SortedP),                                              % At this part I sorted pairs.
        msort(L3,L3sort),                                                     % At this part I sorted average list.
        reverse(L3sort,L7),
        pairs_keys_values(SortedP,L7, L).

topThree(L,W) :-                                                              % This  part writes the first three teams as a sorted list according to their average.
        findall(X,(match(W,L,Y,_,Z),average(L,W,X)),L1),
        findall(X,(match(W,_,Y,L,Z),average(L,W,X)),L2),
        append(L1,L2,L3),
        findall(T,match(W,T,X,_,_),L4),
        findall(T,match(W,_,_,T,X),L5),
        append(L4,L5,L6),
        pairs_keys_values(P, L3, L6),
        pair_sorting(P,SortedP),
        msort(L3,L3sort),
        reverse(L3sort,L7),
        pairs_keys_values(SortedP,L7, L8),
        first_n_of_list(3,L8,L).                                               % At this part I got the most three successfull teams.





