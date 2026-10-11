% COPIED FROM https://github.com/matsavage/DND-5e-LaTeX-Character-Sheet-Template/blob/ab3b041769dfbd42c0fb50cc42f50363cdab07c6/dndtemplate.sty
% MODIFIED TO USE AS CLASS

% SEE OVERLEAF DOCS FOR WRITING YOUR OWN CLASS -> https://www.overleaf.com/learn/latex/Writing_your_own_class
\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{pixiedndtemplate}[2026/10/01 Pixie's DnD Character Template]

\RequirePackage{etoolbox} % for conditional content, macro-from-string, etc.
\RequirePackage{ifthen} % OBSOLETE: see https://tex.stackexchange.com/a/5896 --- i don't know where this is used

% DEFINE TOGGLE AND OPTIONS FOR A4 VS LETTER FORMAT
\newtoggle{a4paper}\toggletrue{a4paper}
\DeclareOption{a4paper}{\toggletrue{a4paper}}
\DeclareOption{letterpaper}{\togglefalse{a4paper}}
% DEFINE TOGGLE AND OPTIONS FOR DISPLAYING TEXT IN DIFFERENT LANGUAGES
% IF NO LANGUAGE IS GIVEN, DOES NOT DISPLAY ANY TEXT
\newtoggle{showText}
\newtoggle{deutsch}
\DeclareOption{german}{\toggletrue{deutsch}\toggletrue{showText}}
\DeclareOption{deutsch}{\toggletrue{deutsch}\toggletrue{showText}}
\newtoggle{english}
\DeclareOption{english}{\toggletrue{english}\toggletrue{showText}}
% DEFINE TOGGLE AND OPTION FOR INCLUDING FILLABLE FORM CONTENT
\newtoggle{interactive}
\DeclareOption{interactive}{\toggletrue{interactive}}
\DeclareOption{interactive=true}{\toggletrue{interactive}}
\DeclareOption{interactive=false}{\togglefalse{interactive}}
% DEFINE TOGGLE FOR STARTER SET/DoSI OR REGULAR LAYOUT (because max level 3 = no feats)
\newtoggle{maxlevel3}
\DeclareOption{level4up}{\togglefalse{maxlevel3}}
\DeclareOption{DoSI}{\toggletrue{maxlevel3}}
\DeclareOption{maxlevel3}{\toggletrue{maxlevel3}}
% DEFINE TOGGLE AND OPTION FOR DISPLAYING THE DOCUMENT AS A DRAFT
\newtoggle{pixiedraft}
\DeclareOption{pixiedraft}{\toggletrue{pixiedraft}}
\DeclareOption{pixiedraft=true}{\toggletrue{pixiedraft}}
\DeclareOption{pixiedraft=false}{\togglefalse{pixiedraft}}

%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\iftoggle{a4paper}{\LoadClass[a4paper,openany,oneside,twocolumn]{book}}{\LoadClass[letterpaper,openany,oneside,twocolumn]{book}}

\RequirePackage{bookmark} % lets you set bookmarks
\RequirePackage[margin=0pt,nomarginpar,showframe=true]{geometry} % lets you manipulate the page geometry
\RequirePackage{graphicx} % improved graphics handling
\RequirePackage{fontspec} % font handling for LuaLaTeX
\RequirePackage{pstricks} % draw SVG graphcis
\RequirePackage{pst-plot} % enables use of \psaxes
\RequirePackage{multido} % enables use of \multido for loops
%\RequirePackage{xfp} % use simple math inline with \fpeval{} % ALREADY PART OF CORE LATEX
\RequirePackage{pifont} % for checkbox symbol
\RequirePackage{calc} % for using \widthof{}
\RequirePackage[normalem]{ulem} % consistent underlining
\RequirePackage{contour} % for cutting out descenders from underlining
\RequirePackage{fmtcount} % for using multido variables for input field IDs

\RequirePackage{xstring} % what for?
\RequirePackage{ragged2e} % what for?

\RequirePackage{fancyhdr,booktabs,array}
\RequirePackage{hyperref} % for input fields
\RequirePackage{l3pdffield} % for check input fields specifically!!

\newlength{\pixieLabelLengthPtWeapon}
\newlength{\pixieLabelLengthPtClass}
\newlength{\pixieLabelLengthPtSpecies}
\newlength{\pixieLabelLengthPtBackground}
\newlength{\pixieLabelLengthPtFeats}
\newlength{\pixieLabelLengthPtPersonalGoal}
\newlength{\pixieLabelLengthPtOtherProfs}
\newlength{\pixieLabelLengthPtSpellSlots}
\newlength{\pixieLabelLengthPtSpellList}
\newlength{\pixieLabelLengthPtAppearance}
\newlength{\pixieLabelLengthPtPersonality}
\newlength{\pixieLabelLengthPtEquipment}
\makeatletter
\newcommand{\pixieLabelLengthWeapon}[1]{\strip@pt\pixieLabelLengthPtWeapon}
\newcommand{\pixieLabelLengthClass}[1]{\strip@pt\pixieLabelLengthPtClass}
\newcommand{\pixieLabelLengthSpecies}[1]{\strip@pt\pixieLabelLengthPtSpecies}
\newcommand{\pixieLabelLengthBackground}[1]{\strip@pt\pixieLabelLengthPtBackground}
\newcommand{\pixieLabelLengthFeats}[1]{\strip@pt\pixieLabelLengthPtFeats}
\newcommand{\pixieLabelLengthPersonalGoal}[1]{\strip@pt\pixieLabelLengthPtPersonalGoal}
\newcommand{\pixieLabelLengthOtherProfs}[1]{\strip@pt\pixieLabelLengthPtOtherProfs}
\newcommand{\pixieLabelLengthSpellSlots}[1]{\strip@pt\pixieLabelLengthPtSpellSlots}
\newcommand{\pixieLabelLengthSpellList}[1]{\strip@pt\pixieLabelLengthPtSpellList}
\newcommand{\pixieLabelLengthAppearance}[1]{\strip@pt\pixieLabelLengthPtAppearance}
\newcommand{\pixieLabelLengthPersonality}[1]{\strip@pt\pixieLabelLengthPtPersonality}
\newcommand{\pixieLabelLengthEquipment}[1]{\strip@pt\pixieLabelLengthPtEquipment}
\makeatother

% nicer underline
\makeatletter
    \newcommand{\coloruline}[2]{%
        \UL@protected\def\temp@uline{\leavevmode \bgroup
            \markoverwith{\textcolor{#1}{\rule[-0.5ex]{2pt}{0.4pt}}}%
        \ULon}%
        \temp@uline{#2}%
    }
\makeatother
\renewcommand{\ULdepth}{1pt}
\contourlength{0.4pt}
\newcommand{\myuline}[1]{\coloruline{gray!70}{\phantom{#1}}\llap{\contour{white}{#1}}}

%%%% USE NICER FONTS SIMILAR TO DND 5.5E
%%%% source: https://github.com/jonathonf/solbera-dnd-fonts

% simple character sheet text
\newfontfamily{\pixieFontSimple}{ScalySans}[
    Path=solbera-fonts/scaly-sans/,
    Extension=.otf,
    UprightFont={*-Regular},
    BoldFont={*-Bold},
    ItalicFont={*-Italic},
    BoldItalicFont={*-BoldItalic}
    % NOTE: trying to use ScalySansCaps as the small-caps version of this font doesn't work fsr?
    %       the files are still in the correct folder, but i couldn't figure out how to switch from small-caps to regular ...
    %UprightFeatures={SmallCapsFont={*-RegularCaps}},BoldFeatures={SmallCapsFont={*-BoldCaps}},ItalicFeatures={SmallCapsFont={*-ItalicCaps}},BoldItalicFeatures={SmallCapsFont={*-BoldItalicCaps}}
    ]
% caps text on the character sheet - only present in German 2024
\newfontfamily{\pixieFontGermanCaps}{ScalySansCaps}[Path=solbera-fonts/scaly-sans-caps/,Extension=.otf,UprightFont={*-Regular},BoldFont={*-Bold},ItalicFont={*-Italic},BoldItalicFont={*-BoldItalic}]
% pregen text body (e.g. starter set 2022)
\newfontfamily{\pixieFontPrintBody}{Bookinsanity}[Path=solbera-fonts/bookinsanity/,Extension=.otf,UprightFont={*-Regular},BoldFont={*-Bold},ItalicFont={*-Italic},BoldItalicFont={*-BoldItalic}] 
% pregen text headings (e.g. starter set 2022)
\newfontface\pixieFontPrintHeadings{MrEavesSmallCaps-Regular.otf}[Path=solbera-fonts/mr-eaves/]

%%%% OLD FONT SELECTION
%\RequirePackage[largesmallcaps]{kpfonts}
%\RequirePackage{gillius2}
%\newcommand{\kpFont}{\setsansfont{KpSans}[largesmallscaps]}
%\newcommand{\gtFont}{\setsansfont{Gillius ADF No2}}
%\newcommand{\gtcFont}{\setsansfont{Gillius ADF No2 Cond}}

\renewcommand*\familydefault{ScalySans}

% FONT SIZE BETWEEN TINY AND SCRIPTSIZE --- COPIED FROM https://tex.stackexchange.com/a/432684
\makeatletter
\newcommand\notsotiny{\@setfontsize\notsotiny\@vipt\@viipt}
\makeatother

% DEFINE TOGGLE FOR SPELL SLOTS TEXT
\newtoggle{expendedShort}
% DEFINE TOGGLE FOR SPELL SLOT ALIGNMENT
\newtoggle{slotsrightaligned}

% END OF PIXIE'S ADDITIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DEFINE FONT FOR USER INPUTTED TEXT
\newfontfamily\entryfont{Kalam}[Path=original/template/fonts/,Extension=.ttf,UprightFont=Kalam-Regular,BoldFont=Kalam-Bold]

% HEADER BACKGROUND COLOR AND OPACITY
\newrgbcolor{header-background-color}{0.87 0.87 0.87}
\pgfmathsetmacro{\headercolorbackgroundopacity}{1}

% HEADER DRAWING (DRAGON ETC) COLOR AND OPACITY
\newrgbcolor{character-sheet-dragon-color}{0 0 0}
%\newrgbcolor{character-sheet-dragon-eye-color}{1 0 0}
\newrgbcolor{character-sheet-dragon-eye-color}{1 1 1}
\newrgbcolor{spell-sheet-fireball-color}{0 0 0}
\pgfmathsetmacro{\headerdragonopacity}{1}

% HEADER TRIM
%\newrgbcolor{header-color}{0.850 0.764 0.466}
\newrgbcolor{header-color}{0 0 0}
%\newrgbcolor{header-color-accent}{.2 .2 .2}
\newrgbcolor{header-color-accent}{0 0 0}

% GREY BACKGROUND FOR STAT BLOCK SECTION
\pgfmathsetmacro{\generalbackgroundopacity}{0}
\pgfmathsetmacro{\statsbackgroundopacity}{1}

% WHITE BACKGROUNDS FOR STATS BLOCKS AND MODIFIERS
\pgfmathsetmacro{\statsscoreopacity}{1}
\pgfmathsetmacro{\statsmodifieropacity}{1}

% COLOR FOR BLOCK OUTLINES
%\newrgbcolor{outline-color}{0.850 0.764 0.466}
\newrgbcolor{outline-color}{0 0 0}

% COLORS FOR MONEY OUTLINES
%\newrgbcolor{money-outline-color}{0.850 0.764 0.466}
\newrgbcolor{money-outline-color}{0 0 0}
%\newrgbcolor{money-outline-color-accent}{0.705 0.607 0.431}
\newrgbcolor{money-outline-color-accent}{.2 .2 .2}

% COLOR INDICATORS
\newrgbcolor{primary-indicator-color}{0 0 0}
\newrgbcolor{secondary-indicator-color}{0.1 0.1 0.1}
\newrgbcolor{tertiary-indicator-color}{0.6 0.6 0.6}

% SPELL HEADER COLOR AND BACKGROUND OPACITY
\pgfmathsetmacro{\spellheaderbackgroundopacity}{0}
\pgfmathsetmacro{\spellheaderbackgroundinfillopacity}{1}

% PROFICIENCY MARKER COLOR
\newrgbcolor{proficiency-marker-color}{0 0 0}
%\newrgbcolor{expert-proficiency-marker-color}{0.18 0.04 0.39}
\newrgbcolor{expert-proficiency-marker-color}{0.4 0.4 0.4}

% TEXT COLOR
\newrgbcolor{text-color}{0 0 0}

% SPELL LINE COLOR
\newrgbcolor{spell-line-color}{0.3 0.3 0.3}

% SIMPLIFY TRANSPARENCY OPTIONS WHEN ALLOWPSTRANSPARENCY ISN'T SET
\ifnum \headercolorbackgroundopacity=0
  \def \headercolorbackgroundfill{none}
\else
  \def \headercolorbackgroundfill{solid}
\fi
\ifnum \headerdragonopacity=0
  \def \headerdragonfill{none}
\else
  \def \headerdragonfill{solid}
\fi
\ifnum \generalbackgroundopacity=0
  \def \generalbackgroundfill{none}
\else
  \def \generalbackgroundfill{solid}
\fi
\ifnum \statsbackgroundopacity=0
  \def \statsbackgroundfill{none}
\else
  \def \statsbackgroundfill{solid}
\fi
\ifnum \statsmodifieropacity=0
  \def \statsmodifierfill{none}
\else
  \def \statsmodifierfill{solid}
\fi
\ifnum \statsscoreopacity=0
  \def \statsscorefill{none}
\else
  \def \statsscorefill{solid}
\fi
\ifnum \spellheaderbackgroundopacity=0
  \def \spellheaderbackgroundfill{none}
\else
  \def \spellheaderbackgroundfill{solid}
\fi
\ifnum \spellheaderbackgroundinfillopacity=0
  \def \spellheaderbackgroundinfillfill{none}
\else
  \def \spellheaderbackgroundinfillfill{solid}
\fi

\input{pixie-class-setup/setup-fillable}
\input{pixie-class-setup/setup-styling-1-color}
\input{pixie-class-setup/setup-styling-2-text}
\input{pixie-class-setup/setup-styling-3-pstricks}
\input{pixie-class-setup/setup-language-text} % AFTER styling setup
\input{pixie-class-setup/setup-drawing} % AFTER all other setup

\newtoggle{armorLight}
\newtoggle{armorMedium}
\newtoggle{armorHeavy}
\newtoggle{shields}
% TODO: use toggles for ALL the proficiency stuff and mimic the original's behaviour

\input{fork-original/template/character-sheet-commands} % keep only bc of color definition 
    % TODO: recreate using toggles and such

\newcommand{\renderfirstpage}{\input{pixie-template/pixie-page-one}}
\newcommand{\rendersecondpage}{\input{pixie-template/pixie-page-two}}