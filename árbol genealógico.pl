%padre
esPadreDe(alvaro,eduardo).
esPadreDe(alvaro,margarita).
esPadreDe(alvaro,mercedes).
esPadreDe(eduardo,luis).
esPadreDe(saulo,marina).
esPadreDe(obdulio,camen).
esPadreDe(herlid,belkys).
esPadreDe(herlid,kevin).
esPadreDe(kevin,sofia).
esPadreDe(arley,melissa).
esPadreDe(arley,laura).

%madre
esMadreDe(marina,luis).
esMadreDe(carmen,marina).
esMadreDe(carmen,arley).
esMadreDe(carmen,herlid).

% padres@
% A es padre o madre de B
esPadresDe(A, B) :- esMadreDe(A, B); esPadreDe(A, B).

% Hij@
% A es Hijo de B, el inverso de esPadresDe
esHijoDe(A, B) :- esPadresDe(B, A).

% Abuel@
% No se tiene encuenta el genero del abuelo o abuela. 
% A es abuela de B,  Cuando La madre o Padre de A, tiene una Madre o Padre de B
esAbuelaDe(A,B) :- esMadreDe(A, X), esMadreDe(X, B).
esAbuelaDe(A,B) :- esPadreDe(A, X), esPadreDe(X, B).
esAbuelaDe(A,B) :- esPadreDe(A, X), esMadreDe(X, B).
esAbuelaDe(A,B) :- esMadreDe(A, X), esPadreDe(X, B).

% Niet@
% el Inverso de esAbuelaDe
esNietoDe(A, B) :- esAbuelaDe(B, A).

% Herman@
% A es hermano de B, Cuando la Madre y padre de A es la madre y padre de B,
% Siempre y cuando A y B no sean iguales, por que serian la misma persona.
% tampoco se tiene encuenta el genero.
esHermanoDe(A, B) :- esMadreDe(X, A), esMadreDe(X, B), not(A=B).
esHermanoDe(A, B) :- esPadreDe(X, A), esPadreDe(X, B), not(A=B).

% Ti@
% A es tio de B, cuando la (madre o padre) de B tiene hermano(a) de A
% tampoco se tiene encuenta el genero.
esTioDe(A, B) :-   esMadreDe(X, B),esHermanoDe(X, A).
esTioDe(A, B) :-   esPadreDe(X, B),esHermanoDe(X, A).

% Prim@s
% A es primo de B, cuando X es tio de A Y X es madre o padre de B
% tampoco se tiene encuenta el genero.
esPrimoDe(A, B) :- esTioDe(X, A), esMadreDe(X, B), not(A=B).
esPrimoDe(A, B) :- esTioDe(X, A), esPadreDe(X, B), not(A=B).

% Primos segundo grado
% A es el primo2do B, cuando B es primo de X Y X Tiene una hija A
esPrimo2doDe(A, B) :- esPrimoDe(X,B), esPadreDe(X,A).
esPrimo2doDe(A, B) :- esPrimoDe(X,B), esMadreDe(X,A).

%Consultas
% Es solo llamar la consulta en prolog y lista los hijos, abuelos, hermanos, tios, primos, primos2dos.
% Ejemplo: hijos(X,Y). , abuelos(X,Y). , etc.
abuelos(X,Y) :- esAbuelaDe(X,Y), write(X), write(' es abuel@ de '), write(Y),nl,fail.
padres(X,Y) :- esPadresDe(X,Y), write(X), write(' es Padre/Madre de '), write(Y),nl,fail.
hijos(X,Y) :- esHijoDe(X,Y), write(X), write(' es hij@ de '), write(Y),nl,fail.
hermanos(X,Y) :- esHermanoDe(X,Y), write(X), write(' es herman@ de '), write(Y),nl,fail.
nietos(X,Y) :- esNietoDe(X,Y), write(X), write(' es niet@ de '), write(Y),nl,fail.
tios(X,Y) :- esTioDe(X,Y), write(X), write(' es ti@ de '), write(Y),nl,fail.
primos(X,Y) :- esPrimoDe(X,Y), write(X), write(' es prim@ de '), write(Y),nl,fail.
primo2dos(X,Y) :- esPrimo2doDe(X,Y), write(X), write(' es prim@ segundo de '), write(Y),nl,fail.


