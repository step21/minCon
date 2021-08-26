:-set_prolog_flag(double_quotes, chars).
:- use_module(library(dcg/basics)).
:- use_module(library(dcg/high_order)).
:- use_rendering(svgtree, [list(false)]).

doc(Doc) --> head(Head), tbd(Terms), {Doc = doc(Head, Terms)}, list(X).
head(Head) --> lex(Lex), lexon(Lexon), author(Author), preamble(Preambletext),
    {Head = head(Lex, Lexon, Author, Preambletext)}, list(_).

lex(Name) --> "LEX:", " ", list(TempName), {atom_codes(TempName2, TempName), Name = name(TempName2)}, ".", list(_).
lexon(Version) --> "LEXON:", whites, list(TempVersion), {atom_codes(TempVersion2, TempVersion), Version = version(TempVersion2)}, "\n", list(_).
author(Author) --> "AUTHOR:", whites, list(TempAuthor), {atom_codes(TempAuthor2, TempAuthor), Author = author(TempAuthor2)}, "\n", list(_).
% add separate authors
preamble(PreambleText) --> "PREAMBLE:", whites, list(TempPreambleText),
    {atom_codes(TempPre, TempPreambleText), PreambleText = preamble(TempPre)}, ".". % list(_). 

tbd(Terms) --> "TERMS:", "\n", termbody(Terms).
termbody(Terms) --> terms(T), {Terms = terms(T)}, list(_).

terms(T) --> term(CompTerm1), blanks, terms(CompTerm2), {T = terms(CompTerm1, CompTerm2)}.
terms(T) --> term(CompTerm1), {T = terms(CompTerm1)}. %, blanks, term(CompTerm2), {Terms = terms(CompTerm1, CompTerm2)}.
terms(_T) --> [].
term(CompTerm) --> "\"", list(TempTerm), {atom_codes(TempTerm2, TempTerm), Term = term(TempTerm2)}, "\"", whites, 
    assignment(TempAssignor), {Assignor = assignor(TempAssignor)}, whites, determinant(TempDet), {Det = det(TempDet)},
    whites, vartype(Vartype), ".", {CompTerm = term(Term, Assignor, Det, Vartype)}. %, list(_).

assignment(is) --> "is". % {list(Verb)}. % does that really work?
determinant(det) --> "a" ; "an".
vartype(Vartype) --> "person", {atom_codes(TempVartype, "person"), Vartype = vartype(TempVartype)} ; "this contract", {atom_codes(TempVartype, "this contract"), Vartype = vartype(TempVartype)}; "amount", {atom_codes(TempVartype, "amount"), Vartype = vartype(TempVartype)}; "binary", {atom_codes(TempVartype, "binary"), Vartype = vartype(TempVartype)}. % should unify with vartype, how does that work again...

list([]) --> [].
list([L|Ls]) --> [L], list(Ls).

tt("LEX: Evaluation License System.
LEXON: 0.3.x
AUTHOR: FLORIAN IDELBERGER, HENNING DIEDRICH
PREAMBLE: This is a licensing contract for a software evaluation.
TERMS:
\"Licensor\" is a person.
\"Arbiter\" is a person.
\"License\" is this contract.
\"Licensing Fee\" is an amount.
\"Breach Fee\" is an amount.").

t("LEX: Evaluation License System.
LEXON: 0.3.x
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

\"Description of Goods\" is [ a text ].
\"Licensee\" is [ a person ].
\"Paid\" is [ a binary ].
\"Commissioned\" is [ a binary ].
\"Comment Text\" is [ a text ].
\"Published\" is [ a binary ].
\"Permission to Comment\" is [ a binary ].

The Licensor fixes the Description of Goods.").

twt("\"Licensor\" is a person.
\"Arbiter\" is a person.
\"License\" is this contract.
\"Licensing Fee\" is an amount.
\"Breach Fee\" is an amount.").

ttt("TERMS:
\"Licensor\" is a person.
\"Arbiter\" is a person.
\"License\" is this contract.
\"Licensing Fee\" is an amount.
\"Breach Fee\" is an amount.").
