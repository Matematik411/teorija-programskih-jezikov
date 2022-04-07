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

# Uvod v OCaml

```{code-cell}
:tags: [remove-cell, remove-stdout]

(* Ko se v Jupytru prvič požene OCaml, program Findlib izpiše neko sporočilo.
   Da se to sporočilo ne bi videlo v zapiskih, je tu ta celica, ki sproži izpis,
   vendar ima nastavljeno, da je v zapiskih v celoti skrita. *)
```

_Funkcijsko programiranje_ je pristop k pisanju programov prek sestavljanja funkcij in njihove uporabe na vrednostih. Nasproten pristop bi bilo na primer _imperativno programiranje_, v katerem programe pišemo kot zaporedja ukazov, ki spreminjajo računalnikovo stanje. Programi, napisani v funkcijskem stilu, so dostikrat krajši in preglednejši, poleg tega pa dostikrat omogočajo porazdeljeno računanje. Zaradi vseh teh lastnosti veliko modernih programskih jezikov vpeljuje ideje iz funkcijskega programiranja. Da se bomo lahko osredotočili na te ideje, si bomo ogledali programski jezik OCaml, ki je bil eden prvih in je še danes eden najbolj popularnih funkcijskih jezikov.

## Vaje

### Naloga 1

Dopolnite lambda račun s celimi števili <u>`n`</u> in seštevanjem `e1 + e2`.  

- Dopolnite pravila za leno in neučakano izvajanje izvajanje velikih in malih korakov. Komentirajte, kje se pojavijo ključne razlike.

### Naloga 2

Izračunajte spodnje izraze v lambda računu. Jasno označite korake izvajanja pri vsakem.

- `(\y -> (\x -> x + y)) 2 3`
- `(\y -> (\x -> x + x)) 2 3`
- `(\x -> x x) (\x -> x x)`

### Naloga 3

Razložite kaj naredijo naslednje funkcije za Churchova števila

- `\n f z -> f (n f z)`
- `\n f z -> n f (f z)`
- `\m n f z -> m f (n f x)`
- `\m n f z -> m (n f) z`
- `\m n -> n m`

### Naloga 4

Uporabite Churchovo kodiranje za predstavitev seznamov kot aplikacije `fold` na tem seznamu.
