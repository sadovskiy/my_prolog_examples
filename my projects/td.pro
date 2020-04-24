

domains

	list = symbol*   % инцелизация константы как строки

predicates

	a2( list, list, list )
	a3( list, list, list, list )
%	test( list, list, list )
	T( list )
	copy( list, list )
	f( list )
	p( list )
	d( list )
%	sol_d 

%goal

%	sol_d.

clauses
	
%	sol_d:-
%	d(["(","~",a,"v",b,")","&","(","~",b,"v",
%	  c,")","&",a,"&","~",c]).




	a2([], L, L).        % пустой список
	
	a2([H | A], B, [H | C]):-
		a2(A, B, C).
	
	a3(L, L1, L2, L3):-
		a2( L1, T, L ), 
		a2( L2, L3, T ), 
%		a2( L3, L3, T ),
		write("f=",L2).
%        test([], L, L).
        
%        test([Head | L1], L2, [Head | L3]):-
%        		test(L1, L2, L3).
               
	
	T( L ):-
       		a3( L, L1, ["&"], L3 ), 
       			write("L01=",L),nl,
       			write("L11=",L1),nl,
       			write("L31=",L3), nl,
       			T( L1 ), P( L3 );
       		a3( L, L1, ["v"], L3 ), 
			write("L02=", L), nl,
			write("L12=", L1),nl,
			write("L32=",L3),nl,
			T( L1 ), P( L3 );
       		P( L ).
       		P( L ):-
       			
%       			write("L0=",L),nl,
       			a3( L, ["("], L2, [")"]), 
%       			write("L=",L),nl,
%       			write("L2=", L2),nl,
       			T(L2);
       			f( L ).
       			f( L ):-
       				a3( L, _, ["~"], L3), 
       				T(L3);
       				L = [a]; 
       				L = [b]; 
       				L = [c]; 
       				L = [d].
       	d( S ):- 
       		T( S ).
       	copy(L, MV):-
       		MV=L.
