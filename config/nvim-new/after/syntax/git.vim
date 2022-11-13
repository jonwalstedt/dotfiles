syn match gitLgLine /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>.*\)\?$/
syn match gitLgHead /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\> - ([^)]\+)\( ([^)]\+)\)\? \)\?/ contained containedin=gitLgLine
syn match gitLgDate /(\u\l\l \u\l\l \d\=\d \d\d:\d\d:\d\d \d\d\d\d)/ contained containedin=gitLgHead nextgroup=gitLgRefs skipwhite
syn match gitLgRefs /([^)]*)/ contained containedin=gitLgHead
syn match gitLgGraph /^[_\*|\/\\ ]\+/ contained containedin=gitLgHead,gitLgCommit nextgroup=gitHashAbbrev skipwhite
syn match gitLgCommit /^[^-]\+- / contained containedin=gitLgHead nextgroup=gitLgDate skipwhite
syn match gitLgIdentity /<[^>]*>$/ contained containedin=gitLgLine
hi def link gitLgGraph Comment
hi def link gitLgDate gitDate
hi def link gitLgRefs gitReference
hi def link gitLgIdentity gitIdentity
