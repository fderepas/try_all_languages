s(1,M):-M is 1.
s(X,M):-X>1,mod(X,2)=:=1,Y is 3*X+1,s(Y,N),M is max(3*X+1,N).
s(X,M):-X>1,mod(X,2)=:=0,Y is X/2,s(Y,N),M is max(X,N).
a(L,A):-sumlist(L,S),length(L,G),G>0,A is S/G.
main:-read_line_to_string(user_input,C),read_line_to_string(user_input,D),number_string(E,C),number_string(F,D),numlist(E,F,L),maplist(s,L,M),a(M,A),G is floor(A),writeln(G).
