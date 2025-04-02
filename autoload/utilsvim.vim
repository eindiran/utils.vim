"---------------------------------------------------------------------
" FILE: autoload/utilsvim.vim
" AUTHOR: Elliott Indiran <elliott.indiran@protonmail.com>
" DESCRIPTION: These are the utility functions used by utils.vim
" CREATED: Wed 02 Apr 2025
" LAST MODIFIED: Wed 02 Apr 2025
" VERSION: 0.0.1
"---------------------------------------------------------------------

"---------------------------------------------------------------------
" Prevent double loading
"---------------------------------------------------------------------
if exists("g:autoloaded_utilsvim")
    finish
endif
let g:autoloaded_utilsvim = 1

"---------------------------------------------------------------------
" Do Automatic Versioning
"---------------------------------------------------------------------
function! utilsvim#UpdatePatchVersion()
    :1,20s@\(REVISION\s*:\s*\|VERSION\s*:\s*\)\(v\?\d\+\.\)\(\d\+\.\)\(\d\+\)@\=submatch(1) . submatch(2) . submatch(3) . (submatch(4) + 1)@
    " Hardcoded to first 20 lines
endfunction
function! utilsvim#UpdateMinorVersion()
    :1,20s@\(REVISION\s*:\s*\|VERSION\s*:\s*\)\(v\?\d\+\.\)\(\d\+\)\(\.\)\(\d\+\)@\=submatch(1) . submatch(2) . (submatch(3) + 1) . submatch(4) . 0@
    " Hardcoded to first 20 lines
endfunction
function! utilsvim#UpdateMajorVersion()
    :1,20s@\(REVISION\s*:\s*\|VERSION\s*:\s*\)\(v\?\)\(\d\+\)\(\.\)\(\d\+\)\(\.\)\(\d\+\)@\=submatch(1) . submatch(2) . (submatch(3) + 1) . submatch(4) . 0 . submatch(6) . 0@
    " Hardcoded to first 20 lines
endfunction
"---------------------------------------------------------------------
" Substitute within a line
" This function was taken from timestampvim
"---------------------------------------------------------------------
function! s:subst(start, end, pat, rep)
    let lineno = a:start
    while lineno <= a:end
        let curline = getline(lineno)
        if match(curline, a:pat) != -1
            let newline = substitute(curline, a:pat, a:rep, "")
            if (newline != curline)
                " Only substitute if we made a change
                keepjumps call setline(lineno, newline)
            endif
        endif
        let lineno = lineno + 1
    endwhile
endfunction
"---------------------------------------------------------------------
" Do Automatic Timestamping
"---------------------------------------------------------------------
function! utilsvim#UpdateTimestamp()
    " Matches "[LAST] (CHANGE[D]|UPDATE[D]|MODIFIED): "
    " Case sensitive. Replaces everything after that w/ timestamp
    " in format: "FRI 07 JUL 2017"
    let pat = '\(\(LAST\)\?\s*\(CHANGED\?\|MODIFIED\|UPDATED\?\)\s*:\s*\).*'
    let rep = '\1' . strftime('%a %d %b %Y')
    call s:subst(1, 20, pat, rep)
    " Hardcoded to first 20 lines
endfunction
"---------------------------------------------------------------------
" Toggle between relativenumber and norelativenumber
"---------------------------------------------------------------------
function! utilsvim#ToggleRelativeNumber()
    if (&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunction
"---------------------------------------------------------------------
" Show the currently mapped Fn keys
"---------------------------------------------------------------------
function! utilsvim#ShowMappedFKeys()
    for i in range(1, 12)
        if !empty(mapcheck("<F".i.">"))
            execute "map <F".i.">"
        endif
    endfor
endfunction
"---------------------------------------------------------------------
" Format hex using `xxd`
"---------------------------------------------------------------------
function! utilsvim#FormatHex()
    set ft=xxd
    :%!xxd
endfunction
" Once editing is complete, use =b to go back to binary
function! utilsvim#FormatBinary()
    :%!xxd -r
endfunction
"---------------------------------------------------------------------
" Format JSON using jq
"---------------------------------------------------------------------
function! utilsvim#FormatJSON()
    :%!jq .
endfunction
"---------------------------------------------------------------------
" Format XML using Python's minidom + some command-mode nonsense
"---------------------------------------------------------------------
function! utilsvim#FormatXML()
    :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
endfunction
function! utilsvim#SanitizedFormatXML()
    :call FormatXML()<CR>:%s/\t/  /g<CR>:%s/ \+$//<CR>:g/^$/d<CR>:noh<CR>
endfunction
"---------------------------------------------------------------------
" Git
"---------------------------------------------------------------------
" Function to search for Git conflict markers
function! utilsvim#SearchGitConflictMarkers() abort
    if exists("g:utilsvim_gitconflict_exact") && g:utilsvim_gitconflict_exact == 1
        " For reasons that are unclear to me I can't get the word boundaries to
        " work here, so use (^|\s)/($|\s) instead
        let l:pattern = '\v(^|\s)@<=(\<{7}|\={7}|\>{7})(\s|$)@='
    else
        let l:pattern = '\v(\<{7}|\={7}|\>{7})'
    endif
    let @/ = l:pattern
    call search(l:pattern, 'Wc')
    set hlsearch
    redraw! " Force screen redraw to show highlighting
endfunction
" Function to delete Git conflict markers
function! utilsvim#DeleteGitConflictSection()
    :,/\v(\<{7}|\={7}|\>{7})/-d
endfunction
