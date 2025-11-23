" imp.vim - Vim syntax highlighting for Imp language

if exists("b:current_syntax")
  finish
endif

" Keywords
syntax keyword impKeyword def returns local case of while is null

" Function definition (must come early!)
syntax match impFunctionDef /def\s\+\h\w*\s*(.*)\s*returns\s*\h\w*\s*{/
highlight link impFunctionDef Function

" Operators
syntax match impOperator /\v(\->|:=|\+\+|<\+|-)/

" Punctuation
syntax match impPunctuation /[()\[\];,→{}]/

" Function calls
syntax match impFunctionCall /\v\w+\s*\([^)]*\)\s*on\s*\w+/

" Variable fallback
syntax match impVariable /\v\w+/

" Numbers
syntax match impNumber /\v\d+/

" Strings
syntax match impString /"[^"]*"/

" Comments (single-line)
syntax match impComment /\/\/.*$/

" Highlight links
highlight link impKeyword Keyword
highlight link impOperator Operator
highlight link impPunctuation Delimiter
highlight link impFunctionDef Function
highlight link impFunctionCall Function
highlight link impVariable Identifier
highlight link impNumber Number
highlight link impString String
highlight link impComment Comment

let b:current_syntax = "imp"

