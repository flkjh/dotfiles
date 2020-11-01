"*line.vim*	    Comments and uncomments lines without using any plugin...
"Author:		Tomas Lestander <github.com/vwisd>

function! vwisd#line#Comment()
	let ft = &filetype
    let fe = expand('%:t:e')
    let fn = expand('%:t')
    if ft == 'xdefaults' || fn == '.Xmodmap'
        silent s:^:\!:e
	elseif ft == 'lisp'
        silent s:^\s*\zs\ze\S:;;:e
	elseif ft == 'conf' || ft == 'php' || ft == 'ruby' ||
            \ ft == 'sh' || ft == 'make' || ft == 'python' ||
            \ ft == 'perl' || fe == 'kts' || fe == 'yml' ||
            \ fe == 'txt' || ft == 'jconf' ||
            \ fn == 'misc' || fn == 'todo' || fn == 'notes' || fn == 'report'
        silent s:^\s*\zs\ze\S:\#:e
	elseif ft == 'javascript' || ft == 'c' || ft == 'cpp' ||
            \ ft == 'java' || ft == 'objc' || ft == 'scala' ||
            \ ft == 'go' || ft == 'proto' || fe == 'kt'
        silent s:^\s*\zs\ze\S:\/\/:e
	elseif ft == 'haskell' || ft == 'lhaskell'
        silent s:^:\-\-:e
	elseif ft == 'tex' || ft == 'matlab'
        silent s:^\s*\zs\ze\S:\%:e
	elseif ft == 'vim'
        silent s:^\s*\zs\ze\S:\":e
    endif
endfunction

function! vwisd#line#Uncomment()
	let ft = &filetype
    let fe = expand('%:t:e')
    let fn = expand('%:t')
    if ft == 'xdefaults' || fn == '.Xmodmap'
		silent! s:\!::
	elseif ft == 'lisp'
		silent! s:;;::
	elseif ft == 'conf' || ft == 'php' || ft == 'ruby' ||
            \ ft == 'sh' || ft == 'make' || ft == 'python' ||
            \ ft == 'perl' || fe == 'kts' || fe == 'yml' ||
            \ fe == 'txt' || ft == 'jconf' ||
            \ fn == 'misc' || fn == 'todo' || fn == 'notes' || fn == 'report'
        silent! s:\#::
    elseif ft == 'javascript' || ft == 'c' || ft == 'cpp' ||
            \ ft == 'java' || ft == 'objc' || ft == 'scala' ||
            \ ft == 'go' || ft == 'proto' || fe == 'kt'
		silent! s:\/\/::
	elseif ft == 'haskell' || ft == 'lhaskell'
		silent! s:\-\-::
	elseif ft == 'tex' || ft == 'matlab'
        silent! s:%::
	elseif ft == 'vim' || fe == 'vim'
		silent! s:\"::
    endif
endfunction
