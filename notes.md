# DCG / Parsing notes

These are various notes and snippets from several sources. Such as clocksin/mellish, tokenize swi-prolog package, dcg_tut by anne hogdon and amzi prolog tutorial.

##

DCGs or what they are converted to are basically difference lists such as `lex([lex, fsdf, sd,"."]-X).` DCGs are a nicer/better notation for that.



## Alternatives in DCGS

* The `;` operator allows alternatives, kind of like a switch statement(?)
* `{Var = "somevalue"}` to unify to a certain value if not unified by some other predicate
* `optional(:Match, :Default)//`` https://www.swi-prolog.org/pldoc/man?predicate=optional//2

## Conversion between a predicate with arguments to a list (or reverse)

`=..` univ - converts predicate and args to list or reverse (list to predicate and args)

## Lookahead

`look_ahead(T), [T] --> [T].`
`phrase(look_ahead(T), [a], Rest).`

This is actually first removing it then putitng it back.


## Trees

* How to map to tree?
* Recursion but then - probably an extra state or variable than carries tree state... or just look at examples from Anne.
* How to build parse tree https://cs.union.edu/~striegnk/learn-prolog-now/html/node67.html

### Sorted tree dictionary

* chpt 7 clocksin/mellish
* Examples of trees?

## For formatting output

`try_literals(X) :- phrase(cliche, X) ,format('~s~n', [X]).`



## Helper

* `atomic(X).` test of atom or number

## For lists

* `efface` - removes first occurence
* `delete` - removes all occurences
* `last()` - last list element
* first?
* `nextto(X, Y, L)` (X and Y are consecutive elements in L)
* findall


## Reading and writing files

* `read_file_to_codes(File, Codes, [encoding(utf8)]),`
* `open(Filename, read, Output).`
* `close(Output).`

## One or more of some

names ---> [name, conj, names].
names ---> [name].
names ---> [].

## 

* Unify for one additional Var - `noun(thing,X) --> [X], {location(X,_)}.`

N to count terms
AST to add nodes ?

wordlist([X|Y]) --> word(X), whitespace, wordlist(Y).
wordlist([X]) --> whitespace, wordlist(X).
wordlist([X]) --> word(X).
wordlist([X]) --> word(X), whitespace.

word(W) --> charlist(X), {name(W,X)}.

charlist([X|Y]) --> chr(X), charlist(Y).
charlist([X]) --> chr(X).

chr(X) --> [X],{X>=48}.