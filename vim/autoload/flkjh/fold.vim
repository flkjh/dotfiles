"*fold.vim*     Custom fold text in vim folding
"Author:        Tomas Lestander <github.com/flkjh>

function! vwisd#fold#MyFoldText()
    let lc = v:foldend - v:foldstart + 1
    let origline = getline(v:foldstart)
    let line = s:SmallStr(origline)
    return line . s:Tag(lc)
endfunction

function! s:TrimTrailingSpaces(line)
    return substitute(a:line, '\v\s+$', '\1', '')
endfunction

function! s:AppendSpaces(line, n)
    let fillStr = repeat(" ", a:n)
    return a:line . fillStr
endfunction

function! s:SmallStr(line)
    let ll = a:line
    let llen = strlen(ll)
    let max = 30
    if llen > max
        let ll = strpart(ll,0,max)
        let ll = s:TrimTrailingSpaces(ll) . '...'
    endif
    return s:AppendSpaces(ll, 37 - strlen(ll))
endfunction

function! s:PreSp(c)
    let n = 0
    if a:c < 10
        let n = 3
    elseif a:c < 100
        let n = 2
    elseif a:c < 1000
        let n = 2
    elseif a:c < 10000
        let n = 1
    elseif a:c < 100000
        let n = 1
    endif 
    return n
endfunction

function! s:PostSp(c)
    let n = 0
    if a:c < 10
        let n = 3
    elseif a:c < 100
        let n = 3
    elseif a:c < 1000
        let n = 2
    elseif a:c < 10000
        let n = 2
    elseif a:c < 100000
        let n = 1
    elseif a:c < 1000000
        let n = 1
    endif 
    return n
endfunction

function! s:Tag(c)
    let prSp = s:PreSp(a:c)
    let poSp = s:PostSp(a:c)
    let preStr = repeat(" ", s:PreSp(a:c))
    let postStr = repeat(" ", s:PostSp(a:c))
    return '[' . preStr . a:c . postStr . ']'
endfunction
