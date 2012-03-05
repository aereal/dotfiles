syn keyword rspecBefore before
syn keyword rspecAfter after
syn keyword rspecAround around
syn keyword rspecSubject subject
syn keyword rspecExampleGroup describe context shared_examples shared_context

syn keyword rspecExample it its specify
syn keyword rspecExample it_behaves_like
syn keyword rspecExample it_should_behaves_like
syn keyword rspecExample include_examples

syn keyword rspecPending pending
syn keyword rspecLet let

syn keyword rspecExpectation should should_not to to_not not_to

hi def link rspecBefore rspecFilter
hi def link rspecAfter rspecFilter
hi def link rspecAround rspecFilter
hi def link rspecSubject rspecStructure
hi def link rspecExampleGroup rspecStructure
hi def link rspecExample rspecStructure
hi def link rspecPending rspecStructure
hi def link rspecLet rspecStructure
hi def link rspecFilter PreProc
hi def link rspecStructure Statement
hi def link rspecExpectation Keyword

