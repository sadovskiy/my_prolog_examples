Domains
  syms=symbol*
DataBase
  rule(symbol,syms,syms).
  leftTerm(symbol,symbol).
  list(symbol,string).
  areal(symbol,char,char).
Predicates
  pack(syms,syms,unsigned,unsigned,string,symbol).
  packLine(syms,syms,unsigned,unsigned,string,syms,syms).
  packUp(syms,syms,unsigned,unsigned,string,symbol,symbol).
  term(unsigned,unsigned,string,symbol).
  writeList(syms,string,unsigned).
  writeNT(syms).
  addLefts.
  addLeft(symbol).
  addSubLeft(symbol,symbol).
  run(string).
  repeat.
  run1(string,unsigned).
  runPack(string,unsigned,symbol).
Goal
  cursor(4,0),write("Название файла грамматики: "),readln(Name),
  concat(Name,".grm",NameOs),consult(NameOs),addLefts,repeat,run(S),S="exit".
Clauses
  pack([Res|L],L,NN,N,S,Res):-term(NN,N,S,Res),writeList([Res|L],S,NN).
  pack([Res|LN],L,NN,N,S,Res):-term(N1,N,S,Rule),not(Rule=Res),
    writeList([Rule|L],S,N1),
    packUp([Res|LN],[Rule|L],NN,N1,S,Res,Rule).

  packUp([Res|L],[Rule|L],NN,N,S,Res,Rule):-
    rule(Res,[Rule|L1],L2),packLine(LN,[Rule|L],NN,N,S,L1,L2),
    writeList([Res|L],S,NN).
  packUp([Res|L],[Rule|L],NN,N,S,Res,Rule):-leftTerm(Rule1,Res),
    rule(Rule1,[Rule|L1],L2),not(Rule1=Res),
    packLine(LM,[Rule|L],N1,N,S,L1,L2),writeList([Rule1|L],S,N1),
    packUp(LN,[Rule1|L],NN,N1,S,Res,Rule1).

  packLine(L,L,N,N,S,[],[]).
  packLine(LN,L,NN,N,S,[],[H|L2]):-term(N1,N,S,H),
    writeList([H|L],S,N1),
    packLine(LN,[H|L],NN,N1,S,L2,[]).
  packLine(LN,L,NN,N,S,[],[H|L2]):-leftTerm(T,H),term(N1,N,S,T),
    writeList([T|L],S,N1),
    packUp([H|L],[T|L],N2,N1,S,H,T),packLine(LN,[H|L],NN,N2,S,L2,[]).
  packLine(L,L,N,N,S,[],L2):-not(L2=[]).
  packLine(LN,L,NN,N,S,[H|L1],L2):-term(N1,N,S,H),
    writeList([H|L],S,N1),packLine(LN,[H|L],NN,N1,S,L1,L2).
  packLine(LN,L,NN,N,S,[H|L1],L2):-pack([H|L],L,N1,N,S,H),
    packLine(LN,[H|L],NN,N1,S,L1,L2).

  term(NN,N,S,Rule):-list(Rule,Token),str_len(Token,K),str_len(S,NS),NS>=N+K-1,
    subString(S,N,K,SS),SS=Token,NN=N+K.
  term(NN,N,S,Rule):-str_len(S,NS),N<=NS,subChar(S,N,C),areal(Rule,B,E),B<=C,C<=E,NN=N+1.

  writeList(L,S,N):-cursor(0,0),writeNT(L),str_len(S,K),K1=K-N+1,
    subString(S,N,K1,S1),write(S1),nl,nl,ReadChar(_).

  writeNT([]).
  writeNT([H|L]):-writeNT(L),write('<',H,'>').

  addLefts:-rule(Rule,_,_),addLeft(Rule),fail.
  addLefts.

  addLeft(Rule):-rule(Rule,[Rule1|_],_),addSubLeft(Rule,Rule1),fail.
  addLeft(_).

  addSubLeft(R,SR):-rule(SR,[SSR|_],_),leftTerm(SR,R).
  addSubLeft(R,SR):-not(leftTerm(SR,R)),rule(SR,[SSR|_],_),addSubLeft(R,SSR),
    fail.
  addSubLeft(R,SR):-not(leftTerm(SR,R)),assertz(leftTerm(SR,R)).

  runPack(S,N,Rule):-pack(_,[],N,1,S,Rule),write("OK").
  runPack(_,_,_):-write("fail").

  run(S):-clearWindow,cursor(5,0),write("Введите предложение: "),Readln(S),
    nl,str_len(S,N),N1=N+1,run1(S,N1),!.

  run1(S,N):-S<>"exit",rule(Rule,_,_),runPack(S,N,Rule),!,readChar(_).
  run1(_,_).

  repeat.
  repeat:-repeat.