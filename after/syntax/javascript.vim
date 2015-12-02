" Vim syntax file
" Language:     JavaScript
" Maintainer:   Kao Wei-Ko(othree) <othree@gmail.com>
" Last Change:  2015-08-05
" Version:      0.1
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
syntax match   javascriptClassProperty         containedin=javascriptClassBlock /[a-zA-Z_$]\k*\s*=/ nextgroup=@javascriptExpression skipwhite skipempty
syntax keyword javascriptClassStatic           contained static nextgroup=javascriptClassProperty,javascriptMethodName,javascriptMethodAccessor skipwhite

" async await
syntax keyword javascriptAsyncFuncKeyword      async nextgroup=javascriptFuncKeyword,javascriptArrowFuncDef skipwhite
syntax keyword javascriptAsyncFuncKeyword      await nextgroup=@javascriptExpression skipwhite

syntax cluster javascriptExpression            add=javascriptAsyncFuncKeyword

syntax match   javascriptOpSymbol              contained /\(::\)/ nextgroup=@javascriptExpression,javascriptInvalidOp skipwhite skipempty " 1

if exists("did_javascript_hilink")
  HiLink javascriptDecorator           Statement
  HiLink javascriptDecoratorFuncName   Statement
  HiLink javascriptDecoratorFuncCall   Statement
  HiLink javascriptDecoratorParens     Statement

  HiLink javascriptClassProperty       Normal

  HiLink javascriptAsyncFuncKeyword    Keyword

  delcommand HiLink
  unlet did_javascript_hilink
endif
