% % motive(harry).
% % motive(sally).
% % guilty(harry).
% % 
% % A suspect is innocent if she has a motive and is not guilty
% % innocent(Suspect) :- motive(Suspect), not guilty(Suspect).
% 
% % place queens on the chess board
% { q(1..8,1..8) }.
% 
% % exactly 1 queen per row/column
% :- X = 1..8, not #count{ Y : q(X,Y) } = 1.
% :- Y = 1..8, not #count{ X : q(X,Y) } = 1.
% 
% % pre-calculate the diagonals
% d1(X,Y,X-Y+8) :- X = 1..8, Y = 1..8.
% d2(X,Y,X+Y-1) :- X = 1..8, Y = 1..8.
% 
% % at most one queen per diagonal
% :- D = 1..8*2-1, 2 { q(X,Y) : d1(X,Y,D) }.
% :- D = 1..8*2-1, 2 { q(X,Y) : d2(X,Y,D) }.

% Data, Geordi, Picard, Riker, Troi, and Worf are crew members
crew(data;geordi;picard;riker;troi;worf).

% Every crew member is assigned a hero
1{hero(P,S): crew(S)}1:-crew(P).

% Every crew member is assigned a fear
1{fear(P,S): crew(S)}1:-crew(P).

% H(H(riker)) = data
% :-hero(riker,C1), hero(C1,C2), C2!=data, crew(C1;C2).
hero(C1,data) :- hero(riker,C1), crew(C1).

% F(F(geordi)) = troi, that is, Troi is feared by the person whom Geordi fears
% :- fear(C0,C1), fear(C1,C2), C2!=troi, C0=geordi, crew(C0;C1;C2).
fear(C1,troi) :- fear(geordi,C1), crew(C1).

% F(F(picard)) = riker
% :-fear(picard,C1), fear(C1,C2), C2!=riker, crew(C1;C2).
fear(C1,riker) :- fear(picard,C1), crew(C1).

% F(H(picard)) = geordi
% :-hero(picard,C1), fear(C1,C2), C2!=geordi, crew(C1;C2).
fear(C1,geordi) :- hero(picard,C1), crew(C1).

% H(H(worf)) = riker
% :-hero(worf,C1), hero(C1,C2), C2!=riker, crew(C1;C2).
hero(C1,riker) :- hero(worf,C1), crew(C1).

% H(data) != geordi
:-hero(data,geordi).

% No one is their own hero
:-hero(C1,C1), crew(C1).

% No one fears themself
:-fear(C1,C1), crew(C1).

% Every crew member has exactly one hero
:- crew(C1), not #count{ C2 : hero(C1,C2) } = 1.

% Every crew member is hero to exactly one other crew member
:- crew(C1), not #count{ C2 : hero(C2,C1) } = 1.

% Every crew member fears exactly one crew member
:- crew(C1), not #count{ C2 : fear(C1,C2) } = 1.

% Every crew member is feared by exactly one crew member
:- crew(C1), not #count{ C2 : fear(C2,C1) } = 1.

% No Crew member fears their hero
:-fear(C1,C2), hero(C1,C2), crew(C1;C2).
