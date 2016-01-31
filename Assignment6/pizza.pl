n_pizzas(4).
pizza(1,10).
pizza(2,5).
pizza(3,10).
pizza(4,15).
n_vouchers(2).
voucher(1,1,1).
voucher(2,2,1).

buy(0,[],[],0).
buy(0,A,A,0).

buy(N,Bought,NewBought,Cost):-
	N > 0,
	pizza(PizzaNo,Cost1),
	\+member(PizzaNo,Bought),
	N1 is N-1,	
	append(Bought,[PizzaNo],Bought1),
	buy(N1,Bought1,NewBought,Cost2),
	Cost is Cost1 + Cost2.


costOfAll([],[]).
costOfAll([H|T],[C1|C2]):-
	pizza(H,C1),
	costOfAll(T,C2).


minCost(Bought,MinPizzaCost):-
	costOfAll(Bought,Costs),
	min_list(Costs,MinPizzaCost).

freePizza(_,0,L,L).
freePizza(Cost,NumberFree,PizzaBought,FreePizzas):-
	NumberFree > 0,
	pizza(PizzaNo,PizzaCost),
	PizzaCost =< Cost,
	\+member(PizzaNo,PizzaBought),
	NewNumberFree is NumberFree-1,
	append([PizzaNo],PizzaBought,NewPizzaBought),
	freePizza(Cost,NewNumberFree,NewPizzaBought,FreePizzas).

costHelper(0,PizzaBought,_):-
	n_pizzas(N),
	length(PizzaBought,N).

costHelper(C,PizzaBought,VoucherBought):-
	voucher(VoucherNo,Buy,Free),
	\+member(VoucherNo,VoucherBought),		
	buy(Buy,PizzaBought,NewBought,Cost1),
	minCost(NewBought,MinPizzaCost),
	freePizza(MinPizzaCost,Free,NewBought,NewBought1),
	append(VoucherBought,[VoucherNo],NewVoucher),
	costHelper(Cost2,NewBought1,NewVoucher),
	C is Cost1 + Cost2.

cost(R):-
	findall(C,costHelper(C,[],[]),L),
	min_list(L,R).		
