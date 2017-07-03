" Remove any old syntax stuff hanging around
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

syn region booklitBraceRange matchgroup=Delimiter start="{" end="}" contains=booklitExprStart,booklitInnerBraceRange nextgroup=booklitBrackRange,booklitBraceRange contained
syn region booklitInnerBraceRange matchgroup=booklitBraceRange start="{" end="}" contains=booklitExprStart,booklitInnerBraceRange contained

syn match booklitIdentifier /[a-zA-Z0-9\-_]\+/ nextgroup=booklitBraceRange,booklitBrackRange contained

syn match booklitExprStart "\\" nextgroup=booklitBrackRange,booklitBraceRange,booklitIdentifier,@AtomyBase containedin=booklitBraceRange,booklitInnerBraceRange,@AtomyBase

syn region booklitBlockComment start="{-"  end="-}" contains=booklitBlockComment

if version >= 508 || !exists("did_booklit_syntax_inits")
  if version < 508
    let did_booklit_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink booklitBlockComment        booklitComment
  HiLink booklitComment             Comment

  HiLink booklitExprStart           Statement
  HiLink booklitIdentifier          Statement

  delcommand HiLink
endif

let b:current_syntax = "booklit"
