" Vim syntax file
" Language:     JavaScript
" Maintainer:   Kao Wei-Ko(othree) <othree@gmail.com>
" Last Change:  2017-03-02
" Version:      0.3
" Changes:      Go to https://github.com/othree/es.next.syntax.vim for recent changes.


if version >= 508 || !exists("did_javascript_syn_inits")
  let did_javascript_hilink = 1
  if version < 508
    let did_javascript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
else
  finish
endif

" decorator
syntax match   javascriptDecorator             /@/ containedin=javascriptClassBlock nextgroup=javascriptDecoratorFuncName
syntax match   javascriptDecoratorFuncName     contained /\<[^=<>!?+\-*\/%|&,;:. ~@#`"'\[\]\(\)\{\}\^0-9][^=<>!?+\-*\/%|&,;:. ~@#`"'\[\]\(\)\{\}\^]*/ nextgroup=javascriptDecoratorFuncCall,javascriptDecorator,javascriptClassMethodName skipwhite skipempty
syntax region  javascriptDecoratorFuncCall     contained matchgroup=javascriptDecoratorParens start=/(/ end=/)/ contains=@javascriptExpression,@javascriptComments nextgroup=javascriptDecorator,javascriptClassMethodName skipwhite skipempty

" class property initializer
syntax match   javascriptClassProperty         contained containedin=javascriptClassBlock /[a-zA-Z_$]\k*\s*=/ nextgroup=@javascriptExpression skipwhite skipempty
syntax keyword javascriptClassStatic           contained static nextgroup=javascriptClassProperty,javascriptMethodName,javascriptMethodAccessor skipwhite
syntax region  javascriptClassBlock            contained matchgroup=javascriptBraces start=/{/ end=/}/ contains=javascriptMethodName,javascriptMethodAccessor,javascriptClassStatic,@javascriptComments,@javascriptValue fold

" bind operator
syntax match   javascriptOpSymbol              contained /\(::\)/ nextgroup=@javascriptExpression,javascriptInvalidOp skipwhite skipempty " 1

" type hint
syntax cluster javascriptAfterIdentifier       contains=javascriptDotNotation,javascriptFuncCallArg,javascriptComputedProperty,javascriptOpSymbols,@javascriptComments,javascriptArrowFunc,javascriptTypeComma

syntax match   javascriptTypeComma             contained /:/ nextgroup=@javascriptTypeHints skipwhite
syntax match   javascriptTypeHint              contained /[a-zA-Z_$][0-9a-zA-Z_$]*/ nextgroup=javascriptTypeHintOr,javascriptTypeTuple,javascriptTypeGeneric,@javascriptAfterIdentifier
syntax keyword javascriptTypeHint              contained null void nextgroup=javascriptTypeHintOr,javascriptTypeTuple,javascriptTypeGeneric,@javascriptAfterIdentifier
syntax match   javascriptTypeHintOr            contained /\s*|/ nextgroup=@javascriptTypeHints skipwhite
syntax region  javascriptTypeTuple             contained matchgroup=javascriptBrackets start=/\s*\zs\[/ end=/]/ contains=javascriptTypeHintOnly nextgroup=javascriptTypeHintOr,javascriptTypeTuple,javascriptTypeGeneric,@javascriptAfterIdentifier
syntax region  javascriptTypeGeneric           contained matchgroup=javascriptBrackets start=/\s*\zs</ end=/>/ contains=javascriptTypeHintOnly nextgroup=javascriptTypeHintOr,javascriptTypeTuple,javascriptTypeArray,@javascriptAfterIdentifier skipwhite skipempty

syntax match   javascriptTypeHintOnly          contained /\s*\zs\<[a-zA-Z_$][0-9a-zA-Z_$]*/ nextgroup=javascriptTypeHintOrOnly
syntax match   javascriptTypeHintOrOnly        contained /\s*\zs|/ nextgroup=javascriptTypeHintOnly skipwhite

syntax match   javascriptArrowFuncDef          /(\_[^)]*)[^()]*\_s*=>/ contains=javascriptArrowFuncArg,javascriptComma,javascriptArrowFunc,javascriptTypeComma nextgroup=javascriptOperator,javascriptIdentifierName,javascriptBlock,javascriptArrowFuncDef,javascriptParenObjectLiteral,javascriptClassSuper,javascriptClassKeyword,@afterArrowFunc skipwhite skipempty

syntax cluster javascriptFuncArgElements       add=javascriptTypeComma

syntax cluster javascriptTypeHints             contains=javascriptTypeHint,javascriptTypeTuple,javascriptTypeGeneric

" function return type
syntax match   javascriptFuncTypeComma         contained /:/ nextgroup=@javascriptFuncTypeHints skipwhite
syntax match   javascriptFuncTypeHint          contained /[a-zA-Z_$][0-9a-zA-Z_$]*/ nextgroup=javascriptFuncTypeHintOr,javascriptFuncTypeTuple,javascriptFuncTypeGeneric,javascriptBlock skipwhite skipempty
syntax keyword javascriptFuncTypeHint          contained null void nextgroup=javascriptFuncTypeHintOr,javascriptFuncTypeTuple,javascriptFuncTypeGeneric,javascriptBlock skipwhite skipempty
syntax match   javascriptFuncTypeHintOr        contained /\s*|/ nextgroup=@javascriptFuncTypeHints skipwhite
syntax region  javascriptFuncTypeTuple         contained matchgroup=javascriptBrackets start=/\s*\zs\[/ end=/]/ contains=javascriptTypeHintOnly nextgroup=javascriptFuncTypeHintOr,javascriptFuncTypeTuple,javascriptFuncTypeGeneric,javascriptBlock skipwhite skipempty
syntax region  javascriptFuncTypeGeneric       contained matchgroup=javascriptBrackets start=/\s*\zs</ end=/>/ contains=javascriptTypeHintOnly nextgroup=javascriptFuncTypeHintOr,javascriptFuncTypeTuple,javascriptFuncTypeArray,javascriptBlock skipwhite skipempty

syntax cluster javascriptFuncTypeHints         contains=javascriptFuncTypeHint,javascriptFuncTypeTuple,javascriptFuncTypeGeneric

syntax region  javascriptFuncArg               contained matchgroup=javascriptParens start=/(/ end=/)/ contains=@javascriptFuncArgElements nextgroup=javascriptFuncTypeComma,javascriptBlock skipwhite skipempty

" import()
syntax keyword javascriptImport                import nextgroup=javascriptImportPattern,javascriptFuncCallArg
syntax match   javascriptImportPattern         contained /\s\+\zs\*/
syntax cluster javascriptExpression            add=javascriptImport
syntax cluster afterArrowFunc                  add=javascriptImport

" pipeline operator
syntax match javascriptOpSymbol contained /\|>/ " 1: |>

" numeric separator
" syntax match   javascriptNumber                /\<0[bB][01][01]\=\>/ nextgroup=@javascriptComments skipwhite skipempty
syntax match   javascriptNumber                /\<0[bB][01][_01]\+[01]\>/ nextgroup=@javascriptComments skipwhite skipempty
" syntax match   javascriptNumber                /\<0[oO][0-7][0-7]\=n\>/ nextgroup=@javascriptComments skipwhite skipempty
syntax match   javascriptNumber                /\<0[oO][0-7][_0-7]\+[0-7]\>/ nextgroup=@javascriptComments skipwhite skipempty
" syntax match   javascriptNumber                /\<0[xX][0-9a-fA-F][0-9a-fA-F]\=n\>/ nextgroup=@javascriptComments skipwhite skipempty
syntax match   javascriptNumber                /\<0[xX][0-9a-fA-F][_0-9a-fA-F]\+[0-9a-fA-F]\>/ nextgroup=@javascriptComments skipwhite skipempty

" too much case for decimal, use non strict pattern for better performance
syntax match   javascriptNumber                /[+-]\=\%([_0-9]\+\.[_0-9]\+\|[_0-9]\+\|\.[_0-9]\+\)\%([eE][+-]\=[_0-9]\+\)\=\>/ nextgroup=@javascriptComments skipwhite skipempty
syntax match   javascriptNumber                /[+-]\=[_0-9]\+\.\%([eE][+-]\=[_0-9]\+\)\=/ nextgroup=@javascriptComments skipwhite skipempty
" non number pattern
syntax match   javascriptNonNumber             /\%(\<\|\.\|e\)_[_0-9]\+\|[_0-9]\+_\%(\>\|\.\|e\|n\)/ nextgroup=@javascriptComments skipwhite skipempty

if exists("did_javascript_hilink")
  HiLink javascriptDecorator           Statement
  HiLink javascriptDecoratorFuncName   Statement
  HiLink javascriptDecoratorFuncCall   Statement
  HiLink javascriptDecoratorParens     Statement

  HiLink javascriptClassProperty       Normal

  HiLink javascriptTypeHint            Structure
  HiLink javascriptFuncTypeHint        Structure

  delcommand HiLink
  unlet did_javascript_hilink
endif
