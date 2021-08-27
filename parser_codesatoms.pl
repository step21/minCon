%:- use_module(library(dcg/basics)). %, [eos//0, number//1]).
:- use_module(library(tokenize)).
:- set_prolog_flag(back_quotes, codes).
:- use_rendering(svgtree, [list(false)]).

parse(Tokens, SyntaxStructure) :-
    phrase(doc, Tokens).

lexing(Source, Tokens) :-
    tokenize(Source, Tokens, [cased(false), spaces(false)]).

get_vars([X|Xs]) --> list(_), [strings(X), get_vars(Xs)].

doc(D) --> head(H), terms(T), clauses, list(_), {D = doc(H)}. %terms, clauses.
head(H) --> lex(L), version(V), author(A), preamble(P), list(_), {H = head(L, V, A, P)}. 
lex(L) --> [word(lex), punct((:))], list(LT), ending, {L = lex(LT)}.
version(V) --> [word(lexon), punct((:))], list(VT), ending, {V = version(VT)}.
author(A) --> authorhead, list(AT), ending, {A = author(AT), write(AT)}.
authorhead --> [word(author), punct((:))].
preambhead --> [word(preamble), punct((:))].
preamble(P) --> preambhead, list(PT), ending, {P = preamble(PT), write(PT)}.

termhead --> [word(terms), punct((:))].
terms(T) --> termhead, list(T).

clausehead --> [word(clause), punct((:))].
clauses --> lexclause, clauses.
clauses --> lexclause.
lexclause --> clausehead, list(C).

spac --> space(_).
ending --> [cntrl(('\n'))].

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).

preambtest(`PREAMBLE: This is a licensing contract for a software evaluation.
           dfd `).
ptt([word(preamble), punct((:)), word(this), word((is)), word(a), word(licensing), word(contract), word(for), word(a), word(software), word(evaluation), punct(('.'))]).

testhead(`LEX: Evaluation License System.
LEXON: 0.3.0
AUTHOR: FLORIAN IDELBERGER, HENNING DIEDRICH
PREAMBLE: This is a licensing contract for a software evaluation.`).

testfile(`LEX: Evaluation License System.
LEXON: 0.3.0
AUTHOR: FLORIAN IDELBERGER, HENNING DIEDRICH
PREAMBLE: This is a licensing contract for a software evaluation.
TERMS:
\"Licensor\" is a person.
\"Arbiter\" is a person.
\"License\" is this contract.
\"Licensing Fee\" is an amount.
\"Breach Fee\" is an amount.
The Licensor appoints the Arbiter,
fixes the Licensing Fee,
and fixes the Breach Fee.
CONTRACTS per Licensee:
\"Description of Goods\" is a text.
\"Licensee\" is a person.
\"Paid\" is [ a binary ].
\"Commissioned\" is a binary.
\"Comment Text\" is a text.
\"Published\" is a binary.
\"Permission to Comment\" is a binary.
\"Notice Time\" is a time.
The Licensor fixes the Description of Goods.
CLAUSE: Pay
The Licensee pays the Licensing Fee to the Licensor,
and pays the Breach Fee into escrow.
The License is therefore Paid.
CLAUSE: Commission.
The Licensor may certify this License as Commissioned.
CLAUSE: Comment.
The Licensee may register a Comment Text.
CLAUSE: Publication.
The Licensee may certify the License as Published.
CLAUSE: Grant Permission to Comment.
The Licensee may grant the Permission to Comment.
CLAUSE: Declare Breach.
The Arbiter may, if the License is Factually Breached:
pay the Breach Fee to the Licensor,
and afterwards terminate this License.
CLAUSE: Factually Breached.
\"Breached\" is defined as:
the License is Commissioned and the Comment Text is not fixed,
or the License is Published and there is no Permission to Comment and the Notice Time
is 24 hours in the past.
CLAUSE: Notice.
The Licensor or the Arbiter may fix the respective current time as the Notice Time.
CLAUSE: Noticed.
\"Noticed\" is defined as a Notice Time being fixed.`).
