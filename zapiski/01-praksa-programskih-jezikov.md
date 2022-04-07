---
jupytext:
  text_representation:
    extension: .md
    format_name: myst
    format_version: 0.12
    jupytext_version: 1.8.0
kernelspec:
  display_name: OCaml 4.11
  language: OCaml
  name: ocaml-jupyter
---

# Praksa programskih jezikov

## Abstraktna sintaksa

aritmetični izraz _e_ ::= _#l_
     | _n_
     | _e1_ `+` _e2_
     | _e1_ `-` _e2_
     | _e1_ `*` _e2_

Booleov izraz _b_ ::= `true`
     | `false`
     | _e1_ `=` _e2_
     | _e1_ `<` _e2_
     | _e1_ `>` _e2_

ukaz _c_ ::= `if` _b_ `then` _c1_ `else` _c2_
     | `while` _b_ `do` _c_
     | _c1_ `;` _c2_
     | _l_ `:=` _e_
     | `skip`

## Konkretna sintaksa z ignoriranimi presledki

    <exp> ::= <atomic_exp> "+" <atomic_exp>
           |  <atomic_exp> "-" <atomic_exp>
           |  <atomic_exp> "*" <atomic_exp>
           |  <atomic_exp>
    <atomic_exp> ::= location
                  |  integer
                  |  "(" <exp> ")"
    <bexp> ::= "true"
            |  "false"
            |  <exp> "=" <exp>
            |  <exp> "<" <exp>
            |  <exp> ">" <exp>
    <cmd> ::= "if" <bexp> "then" <cmd> "else" <cmd>
           |  "while" <bexp> "do" <cmd>
           |  <atomic_cmd> ";" <cmd>
    <atomic_cmd> ::= location ":=" <exp>
                  |  "skip"
                  |  "(" <cmd> ")"

## Konkretna sintaksa z upoštevanimi presledki

    <space> ::= " " | "\n" | "\t" | "\r"
    <spaces> ::= "" | <spaces1>
    <spaces1> ::= <space> <spaces>
    <exp> ::= <atomic_exp> <spaces> "+" <spaces> <atomic_exp>
           |  <atomic_exp> <spaces> "-" <spaces> <atomic_exp>
           |  <atomic_exp> <spaces> "*" <spaces> <atomic_exp>
           |  <atomic_exp>
    <atomic_exp> ::= location
                  |  integer
                  |  "(" <spaces> <exp> <spaces> ")"
    <bexp> ::= "true"
            |  "false"
            |  <exp> <spaces> "=" <spaces> <exp>
            |  <exp> <spaces> "<" <spaces> <exp>
            |  <exp> <spaces> ">" <spaces> <exp>
    <cmd> ::= "if" <spaces1> <bexp> <spaces1> "then" <spaces1> <cmd> <spaces1> "else" <spaces1> <cmd>
           |  "while" <spaces1> <bexp> <spaces1> "do" <spaces1> <cmd>
           |  <atomic_cmd> <spaces> ";" <spaces> <cmd>
    <atomic_cmd> ::= location <spaces> ":=" <spaces> <exp>
                  |  "skip"
                  |  "(" <spaces> <cmd> <spaces> ")"

## Vaje

### Naloga 1
Napišite sintaktično drevo, ki ustreza programom:

```
#a := 2 + #b
```

```
if #x = 2 then 
  #x := 3
else
  skip
```

```
while #z > 0 do 
  #z := #z - 1;
  #w := #z + #w
```

```
(while #z > 0 do #z := #z - 1);
#w := #z + #w
```

### Naloga 2
Programe najprej napišite v OCamlu, nato pa jih prevedite v programski jezik IMP s predavanj.

1. Napišite program, ki sešteje vsa naravna števila manjša od `n`.

2. Napišite program, ki preveri ali je podano število praštevilo.

### Naloga 3
Razmislite, kako bi dopolnili sintakso in evaluator jezika IMP za:

1. logična veznika `&&` in `||`,

2. ukaz `switch`, ki zamenja vrednosti dveh lokacij,

3. ukaz `fail`, ki prekine izvajanje programa.

### Naloga 4
Izboljšajte parser, da bo dopolnil nepopolne `if` stavke. Ukaz `if b then c` naj se prevede v enako sintaktično drevo kot `if b then c else skip`.

### Naloga 5
Dopolnite vse dele IMPa s podporo za `for` zanke oblike:
```
for #x := 0 to 100 do
  cmd
```
Pri tem sta `0` in `100` seveda zgolj zgled poljubnih aritmetičnih izrazov.