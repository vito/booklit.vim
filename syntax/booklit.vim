" Remove any old syntax stuff hanging around
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

syn region booklitBraceRange matchgroup=Delimiter start="{" end="}" contains=booklitExprStart,booklitInnerBraceRange nextgroup=booklitBraceRange contained
syn region booklitInnerBraceRange matchgroup=booklitBraceRange start="{" end="}" contains=booklitExprStart,booklitInnerBraceRange contained

syn region booklitPreformattedBraceRange matchgroup=Delimiter start="{{" end="}}" contains=booklitExprStart,booklitInnerBraceRange nextgroup=booklitPreformattedBraceRange contained

syn region booklitVerbatimBraceRange matchgroup=Delimiter start="{{{" end="}}}" nextgroup=booklitVerbatimBraceRange contained

syn match booklitIdentifier /[a-zA-Z0-9\-_]\+/ nextgroup=booklitBraceRange,booklitVerbatimBraceRange,booklitPreformattedBraceRange contained

syn match booklitExprStart "\\" nextgroup=brooklitVerbatimBraceRange,booklitPreformattedBraceRange,booklitBraceRange,booklitIdentifier containedin=brooklitVerbatimBraceRange,booklitBraceRange,booklitInnerBraceRange

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

  HiLink booklitPreformattedBraceRange  String
  HiLink booklitVerbatimBraceRange      String

  delcommand HiLink
endif

let b:current_syntax = "booklit"
