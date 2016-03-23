% The people are Data, Geordi, Picard, Riker, Troi, and Worf
person(data;geordi;picard;riker;troi;worf).

% Chess ranks and Fiz ranks go from 1 to 6
chessRank(1..6).
fizRank(1..6).

% Every person is assigned a hero, a nemesis, a chessRank, and a fizRank
1{hero(P,H): person(H)}1:-person(P).
1{nemesis(P,N): person(N)}1:-person(P).
1{hasChessRank(P,CR): chessRank(CR)}1:-person(P).
1{hasFizRank(P,FR): fizRank(FR)}1:-person(P).

% No two crew members have the same chessRank or the same fizRank
:- P1 != P2, hasChessRank(P1,CR), hasChessRank(P2,CR), person(P1;P2), chessRank(CR).
:- P1 != P2, hasFizRank(P1,FR), hasFizRank(P2,FR), person(P1;P2), fizRank(FR).

% No one is their own hero or their own nemesis
not hero(P,P) :- person(P).
not nemesis(P,P) :- person(P).

% Every person has exactly one hero and exactly one nemesis
:- person(P), #count{ H : hero(P,H) } != 1.
:- person(P), #count{ N : nemesis(P,N) } != 1.

% Every person is the hero of exactly one person and the nemesis of exactly one person
:- person(H), #count{ P : hero(P,H) } != 1.
:- person(N), #count{ P : nemesis(P,N) } != 1.

% No person's nemesis is also their hero
not nemesis(P,NH) :- hero(P,NH), person(P;NH).

% 1. Geordi ranks 2 at Tri-D Chess
hasChessRank(geordi,2).

% 2. Picard ranks two positions behind Troi at Fizzbin
FRP+2=FRT :- hasFizRank(picard,FRP), hasFizRank(troi,FRT), fizRank(FRP;FRT).

% 3. Troi is feared by the person Geordi fears
nemesis(P,troi) :- nemesis(geordi,P), person(P).

% 4. Worf's hero ranks 3 times lower at Tri-D Chess than the crew member who is best at Fizzbin
CRWH*3=CRBF :- hero(worf,WH), hasChessRank(WH,CRWH), hasChessRank(BF,CRBF), hasFizRank(BF,6), person(WH;BF), chessRank(CRWH;CRBF).

% 5. Picard's hero fears Geordi
nemesis(P,geordi) :- hero(picard,P), person(P).

% 6. Data's hero is not Geordi
not hero(data,geordi).

% 7. Data is the hero of Riker's hero
hero(P,data) :- hero(riker,P), person(P).

% 8. The person who is worst at Fizzbin is better than Troi at Tri-D Chess
CRWF > CRT :- hasChessRank(troi,CRT), hasChessRank(WF,CRWF), hasFizRank(WF,1), person(WF), chessRank(CRWF;CRT).

% 9. The person ranked number 3 at Tri-D Chess is ranked 4 positions hier than Data at Fizzbin
FRP=FRD+4 :- hasFizRank(data,FRD), hasFizRank(P,FRP), hasChessRank(P,3), person(P), fizRank(FRP;FRD).

% 10. Riker is feared by the person Picard fears and is the hero of Worf's hero
nemesis(P,riker) :- nemesis(picard,P), person(P).
hero(P,riker) :- hero(worf,P), person(P).

% 11. Riker is ranked 2 lower at Tri-D Chess than the crew member ranked 2 at Fizzbin
CRR+2=CRP :- hasChessRank(riker,CRR), hasChessRank(P,CRP), hasFizRank(P,2), person(P), chessRank(CRR;CRP).
