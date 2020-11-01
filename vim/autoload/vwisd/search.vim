"*search.vim*   Literal search and replace
"Author:        Tomas Lestander <github.com/vwisd>

let s:buf = ''
let s:pat = ''
let s:mode = ''
let s:direction = ''
let s:flags = ''
let s:found = 0
let s:pos = [0, 0, 0, 0]
let s:endkey = "\<cr>"
let s:visualonly = 0
let s:searchbuf = ''
let s:searching = 0

au CmdlineChanged * if s:searching && getcmdtype() == '@' |
            \ let s:buf = getcmdline() |
            \ let s:pat = s:Pattern() |
            \ call s:MatchPattern() |
            \ endif

function! s:Pattern()
    if s:visualonly
        let [l:s1, l:s2] = s:SplitLast(s:buf)
        return "\\V\\%V" . escape(l:s1, '/\') . "\\%V" . escape(l:s2, '/\')
    endif
    return "\\V" . escape(s:buf, '/\')
endfunction

function! s:MatchPattern()
    call clearmatches()
    let l:len = strlen(s:buf) 
    if s:visualonly == 0
        call setpos('.', s:pos)
    endif
    let s:found = search(s:pat, s:flags)
    if s:found == 0 && s:visualonly == 0
        call setpos('.', s:pos)
    else
        if s:visualonly
            call clearmatches()
            if l:len > 0
                call matchadd('Search', s:pat)
            endif
        else
            let [l:r, l:c] = getpos(".")[1:2]
            if s:mode == 'n' 
                call matchaddpos('Search', [[l:r, l:c, l:len], 1])
            else
                call matchaddpos('Search', [[l:r, l:c], 1])
            endif
        endif
    endif
    redraw
endfunction

function! s:MapDirection(dir)
	if a:dir == '/'
        let v:searchforward = 1
		nmap n /<CR>
		nmap N ?<CR>
		vmap n /<CR>
		vmap N ?<CR>
	else
        let v:searchforward = 0
		nmap n ?<CR>
		nmap N /<CR>
		vmap n ?<CR>
		vmap N /<CR>
	endif
endfunction

function! s:ReMap()
    cnoremap <expr> <esc> s:RegisterKey("\<esc>")
    cnoremap <expr> <CR> s:RegisterKey("\<cr>")
endfunction

function! s:DefaultMap()
    cnoremap <expr> <esc>  "\<esc>"
    cnoremap <expr> <CR> "\<cr>"
endfunction

function! s:PreInput(direction, mode)
    let s:pos = getpos(".")
    if a:mode == 'v'
        let s:mode = visualmode()
    else
        let s:mode = a:mode
    endif
    let s:direction = a:direction
	let s:flags = a:direction == '/' ? "zs" : "zbs"
    let s:buf = ''
    let s:pat = ''
endfunction

function! s:PostInput()
    if s:endkey == "\<esc>"
        call setpos('.', s:pos)
        call feedkeys("\<esc>", 't')
        redraw
        return
    endif
endfunction

function! vwisd#search#SR(direction, mode) range
    call s:PreInput(a:direction, a:mode)
    let s:flags = "zc"
    let s:mode = "v"
    let s:direction = "/"
    let s:visualonly = 1
    let s:searching = 1
    call s:Input("[Search]")
    let s:searching = 0
    call clearmatches()
    redraw
    call s:PostInput()
	if s:found == 0
        if s:endkey == "\<cr>"
            let @/ = ""
        endif
        return
    endif
    let l:s = s:buf
    let l:r = s:RePlaceInput("[Replace]")
	call clearmatches()
    redraw
    execute "normal! " . s:SrStr(l:s, l:r)
    call s:RecRedraw()
    echo ""
	let @/ = ""
	let @/ = l:s
endfunction

function! s:RePlaceInput(prompt)
  	echohl Todo
    call s:ReMap()
  	call inputsave()
  	let l:buf = input(a:prompt)
  	call inputrestore()
  	echohl Normal
    call s:DefaultMap()
    return l:buf
endfunction

function! s:Input(prompt)
  	echohl Todo
    call s:ReMap()
    if s:visualonly == 0
        set conceallevel=3
        set concealcursor="cv"
    endif
  	call inputsave()
  	let s:buf = input(a:prompt)
  	call inputrestore()
    if s:visualonly == 0
        set conceallevel=0
        set concealcursor=""
    endif
  	echohl Normal
    call s:DefaultMap()
endfunction

function! s:RegisterKey(key)
    let s:endkey = a:key
    return a:key
endfunction

function! s:RecRedraw() range
    execute a:firstline .  ", " . a:lastline . "normal! " ":redraw\<cr>"
endfunction

function! s:SrStr(s, r)
    let [l:s1, l:s2] = s:SplitLast(a:s)
    let l:spat = "\\V\\%V" . escape(l:s1, '/\') . "\\%V" . escape(l:s2, '/\')
    let l:rr = escape(a:r, '/\')
    return ":'<,'>s/" . l:spat . "/" . l:rr . "/ge" . "\<cr>"
endfunction

function! s:SplitLast(s)
    let l:len = strlen(a:s)
    return [s:RemoveLastChar(a:s, l:len), s:GetLastChar(a:s, l:len)]
endfunction

function! s:RemoveLastChar(s, n)
    return a:n > 1 ? a:s[0:a:n - 2] : ""
endfunction

function! s:GetLastChar(s, n)
    return a:n > 1 ? a:s[a:n - 1] : a:s[0]
endfunction
