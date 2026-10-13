# Customizable LaTeX Template for DnD 5e Character Sheets

> LaTeX class to typeset fully customizable character sheets for DnD 5e.

## Features

* 2-Page Character Sheet
  * "5.25e": layout combining 5e and 5.5e
  * "maxlevel3": layout for low-level characters
  * *(WIP: default 5e layout)*
* Paper sizes: A4
  * *(WIP: letter)*
* Fillable fields in the generated PDF
* High degree of customisation: layout, language, colors
  * see below for [instructions](#customization-instructions)
  * *(WIP: customisation via commands)*
* Usable in Overleaf

## Usage

### Using empty character sheets

If you're just here to use my layout, go ahead and download one of the empty sheets in `PDFs/`.

Note: If you want to use a fillable one and are having trouble seeing the actual fields, I recommend trying a different PDF viewer. Personally, I've found that Firefox works quite well.

### Building a character sheet

It is recommended to look at pre-existing character sheets in the `characters` directory when using this repository for the first time.  
~~Each text input area of the character sheet is fillable with functions defined in the template, however it may require some trial and error to have the sheet looking as you intend.~~
  
### Customization instructions

* **Layout**: see `pixie-template/pixie-page-*.tex` for examples; add your own by  
  (a) modifying these templates or  
  (b) creating your own and modfiying the `\input{}`s at the end of `pixiedndtemplate.cls`
* **Language**
  1. add your own language toggle + option in `pixiedndtemplate.cls`
  2. edit `pixie-class-setup/setup-language-text.tex` to add the proper terms
* **Colors**: modify or redefine the colors
  * all colors originally defined in either: `pixiedndtemplate.cls`, `pixie-class-setup/setup-styling-1-color.tex`, or `fork-original/template/character-sheet-commands.tex`

## Compilation

### Overleaf

This package can be used as-is with Overleaf. *(It was actually exclusively written and tested with Overleaf.)*

Steps for running on Overleaf:

* ~~Download latest version of the repo for overleaf from the [`releases`](https://github.com/matsavage/DND-5e-LaTeX-Character-Sheet-Template/releases) tab~~
  Download the repo
* Create a new project in Overleaf via a zip upload
* Change the engine to `LuaLaTeX`
* Change the PDF viewer to `Browser` (only if using the `interactive` option to generate fillable fields)

~~You should then be able to compile any of the example characters in the `characters/` directory.~~
You should then be able to compile an empty character sheet using the example files in the `pixie-characters/` directory.

## Dependencies

~~This package requires LaTeX and (optionally) the [DnD 5e LaTeX Template](https://github.com/rpgtex/DND-5e-LaTeX-Template). I recommend using the [instructions](https://github.com/rpgtex/DND-5e-LaTeX-Template/tree/355b9ced1b42324574c2c4e28f9783f29c760a20#dependencies) provided with this package to set up your environment if not using overleaf, nix or the GitHub action in this repository.~~

This package requires LaTeX (specifically LuaLaTeX).

## Credits

* This repository was originally forked from [matsavage/DND-5e-LaTeX-Character-Sheet-Template](https://github.com/matsavage/DND-5e-LaTeX-Character-Sheet-Template).  
  * Original files can be found in `fork-original/`.
  * The original package was generated from the standard Wizards of the Coast [PDF character sheet](https://media.wizards.com/2016/dnd/downloads/5E_CharacterSheet_Fillable.pdf) template
* Additional fonts were downloaded from [jonathonf's Solbera's DnD 5e Fonts](https://github.com/jonathonf/solbera-dnd-fonts), licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

## Work in Progress

Improvement suggestions welcome!

I did my best to separate various "levels" of drawing/layout/design commands according to the table below.

| type of command                       | prefix           | file                           |
|---------------------------------------|------------------|--------------------------------|
| SVG paths (inside pscustom)           | `\pixieGraphic*` | `graphic-*.tex`                |
| psset styling (before pscustom)       | `\pixieStyle*`   | `setup-styling-3-pstricks.tex` |
| form fields                           | `\pixieInput*`   | `setup-fillable.tex`           |
| elements (calls/combines the above)   | `\pixieMake*`    | `element-*.tex`                |
| module (sets elements at coordinates) | `\pixiePlace*`   | `module-*.tex`                 |
