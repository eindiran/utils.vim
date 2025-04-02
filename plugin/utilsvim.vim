"'---------------------------------------------------------------------
" FILE: plugin/utilsvim.vim
" AUTHOR: Elliott Indiran <elliott.indiran@protonmail.com>
" DESCRIPTION: Register `(Plug)` entries and commands for utils.vim
" CREATED: Wed 02 Apr 2025
" LAST MODIFIED: Wed 02 Apr 2025
" VERSION: 0.0.1
"---------------------------------------------------------------------

"---------------------------------------------------------------------
" Prevent double loading
"---------------------------------------------------------------------
if exists("g:loaded_utilsvim")
    finish
endif
let g:loaded_utilsvim = 1

"---------------------------------------------------------------------
" Patch verson
"---------------------------------------------------------------------
command! -nargs=0 UpdatePatchVersion execute utilsvim#UpdatePatchVersion()
nnoremap <nowait> <silent> <Plug>(UpdatePatchVersion) :call utilsvim#UpdatePatchVersion()<CR>
" If we have set the relevant config option set, enable an autocmd for automatic
" version incrementing
if exists("g:utilsvim_autoversion") && g:utilsvim_autoversion == 1
    autocmd! BufWritePre * :call UpdatePatchVersion()
endif

"---------------------------------------------------------------------
" Minor verson
"---------------------------------------------------------------------
command! -nargs=0 UpdateMinorVersion execute utilsvim#UpdateMinorVersion()
nnoremap <nowait> <silent> <Plug>(UpdateMinorVersion) :call utilsvim#UpdateMinorVersion()<CR>

"---------------------------------------------------------------------
" Major version
"---------------------------------------------------------------------
command! -nargs=0 UpdateMajorVersion execute utilsvim#UpdateMajorVersion()
nnoremap <nowait> <silent> <Plug>(UpdateMajorVersion) :call utilsvim#UpdateMajorVersion()<CR>

"---------------------------------------------------------------------
" Timestamping
"---------------------------------------------------------------------
command! -nargs=0 UpdateTimestamp execute utilsvim#UpdateTimestamp()
nnoremap <nowait> <silent> <Plug>(UpdateTimestamp) :call utilsvim#UpdateTimestamp()<CR>
" If we have set the relevant config option set, enable an autocmd for automatic
" timestamping
if exists("g:utilsvim_autotimestamp") && g:utilsvim_autotimestamp == 1
    autocmd! BufWritePre * :call UpdateTimestamp()
endif

"---------------------------------------------------------------------
" Toggling relative line numbers
"---------------------------------------------------------------------
command! -nargs=0 ToggleRelativeNumber execute utilsvim#ToggleRelativeNumber()
nnoremap <nowait> <silent> <Plug>(ToggleRelativeNumber) :call utilsvim#ToggleRelativeNumber()<CR>

"---------------------------------------------------------------------
" Format hex files
"---------------------------------------------------------------------
command! -nargs=0 FormatHex execute utilsvim#FormatHex()
nnoremap <nowait> <silent> <Plug>(FormatHex) :call utilsvim#FormatHex()<CR>

"---------------------------------------------------------------------
" Format binary files (obviously don't save them)
"---------------------------------------------------------------------
command! -nargs=0 FormatBinary execute utilsvim#FormatBinary()
nnoremap <nowait> <silent> <Plug>(FormatBinary) :call utilsvim#FormatBinary()<CR>

"---------------------------------------------------------------------
" Format JSON
"---------------------------------------------------------------------
command! -nargs=0 FormatJSON execute utilsvim#FormatJSON()
nnoremap <nowait> <silent> <Plug>(FormatJSON) :call utilsvim#FormatJSON()<CR>

"---------------------------------------------------------------------
" Format XML
"---------------------------------------------------------------------
command! -nargs=0 FormatXML execute utilsvim#SanitizedFormatXML()
nnoremap <nowait> <silent> <Plug>(FormatXML) :call utilsvim#SanitizedFormatXML()<CR>

"---------------------------------------------------------------------
" Alias for format XML
"---------------------------------------------------------------------
command! -nargs=0 FormatHTML execute utilsvim#SanitizedFormatXML()
nnoremap <nowait> <silent> <Plug>(FormatHTML) :call utilsvim#SanitizedFormatXML()<CR>

"---------------------------------------------------------------------
" Search for git conflicts
"---------------------------------------------------------------------
command! -nargs=0 SearchGitConflictMarkers execute utilsvim#SearchGitConflictMarkers()
nnoremap <nowait> <silent> <Plug>(SearchGitConflictMarkers) :call utilsvim#SearchGitConflictMarkers()<CR>

"---------------------------------------------------------------------
" Delete git conflict markers
"---------------------------------------------------------------------
command! -nargs=0 DeleteGitConflictSection execute utilsvim#DeleteGitConflictSection()
nnoremap <nowait> <silent> <Plug>(DeleteGitConflictSection) :call utilsvim#DeleteGitConflictSection()<CR>

"---------------------------------------------------------------------
" Get the mapping of Fn keys
"---------------------------------------------------------------------
command! -nargs=0 ShowMappedFKeys execute utilsvim#ShowMappedFKeys()
nnoremap <nowait> <silent> <Plug>(ShowMappedFKeys) :call utilsvim#ShowMappedFKeys()<CR>
