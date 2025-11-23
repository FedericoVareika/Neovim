" chi.vim - Syntax highlighting for the χ language

if exists("b:current_syntax")
  finish
endif

" === Keywords (from syntax) ===
syntax keyword chiKeyword case of rec

" === Operators ===
"syntax match chiOperator /\v<\+|:=|->|=|#/
syntax match chiOperator "+\|:=\|->\|=\|#"

" === Lambda and recursion symbols ===
syntax match chiLambda /\\/
syntax match chiArrow /-\>/
" syntax match chiEval /⇓/

" === Comments ===
syntax match chiComment /--.*$/

" === Numbers ===
syntax match chiNumber /\v\d+/

" === Strings (if needed) ===
syntax match chiString /"[^"]*"/

" === Constructors and constants ===
syntax match chiConstructor /\v<k>/

" === Variables (lowercase identifiers) ===
" syntax match chiVariable /\v\<[a-z]\w*\>/
syntax match chiVariable /\v<[a-z][a-z0-9_]*>/

" === Functions (lambda definitions) ===
syntax match chiFunction /\\[a-z]\w*\./

" === Punctuation ===
syntax match chiPunctuation /[(){}\[\];.,]/

" === Highlight groups ===
highlight link chiKeyword Keyword
highlight link chiOperator Operator
highlight link chiLambda Keyword
highlight link chiArrow Operator
" highlight link chiEval Statement
highlight link chiComment Comment
highlight link chiNumber Number
highlight link chiString String
highlight link chiConstructor Type
highlight link chiVariable Identifier
highlight link chiFunction Function
highlight link chiPunctuation Delimiter

let b:current_syntax = "chi"

