" rename.vim: functions to rename files and C symbols under the cursor.
" (Heavily inspired from renamec.vim)
"
" @maintainer       : <chm.duquesne@gmail.com>
" @license          : GPL (see http://www.gnu.org/licenses/gpl.txt)
" @last modified    : 2010-03-21
" @todo             : find a way to allow the user to undo changes (using
"                     diff and patch?)
"
" @Features:
" :call Renamec(): renames the symbol under the cursor
" :call Renamef(): renames the file under the cursor and updates references
" to this file (like includes directives) in the given files
"
" Comparison with renamec:
" bugs fixed
" - the regular expression now matches entire words and is less likely to
"   provoke errors.
" - when used presses escape, the action is aborted.
" features added:
" - can now rename files
" - puts the renamed lines in the quickfix list (to check the changes and
"   update the commentaries)
"

function! Renamec()

    " catches incompatible options
    if &autowrite == 1
        echoerr "You need autowrite to be unset for renaming to work"
        return
    endif

    " saves current position
    let save_buffer = bufnr("%")
    let save_cursor = getpos(".")

    " gets the word to replace
    let word_to_rename = expand("<cword>")

    " gets the new_name, aborts the function if nothing was provided
    let new_name = input("new name: ", word_to_rename)
    if new_name == ""
        return
    endif

    let subs_command = "smagic/\\<" . word_to_rename . "\\>/" . new_name . "/gI"

    " gets the places to modify
    let places_to_modify_raw = system("cscope -L -d -F cscope.out -0 " . word_to_rename)
    let places_to_modify = split(places_to_modify_raw,'\n')

    " empties the quickfix list
    cgetexpr ""
    for place_raw in places_to_modify

        " gets the file and line to modify
        let place = split(place_raw,' ')
        let file = place[0]
        let line = place[2]

        " reaches the file where to proceed the replacement
        let subs_buffer = bufnr(file)
        if subs_buffer == -1
            execute "hide edit ".file
            let subs_buffer = bufnr(file)
        endif
        execute "hide buffer " . subs_buffer

        " tries to join replacements (to cancel them in one shot)
        try
            undojoin
        catch " catch everything
        endtry

        " tries to proceed replacement and to feed the quickfix list
        try
            execute line . "," . line . subs_command
            caddexpr file . ":" . line . ": changed " . word_to_rename . "to" . new_name
        catch E486
        endtry
    endfor

    " restores position
    execute "hide buffer " . save_buffer
    call setpos('.', save_cursor)

endfunction



function! Renamef()
    " catches incompatible options
    if &autowrite == 1
        echoerr "You need autowrite to be unset for renaming to work"
        return
    endif

    " saves current position
    let save_buffer = bufnr("%")
    let save_cursor = getpos(".")

    " gets the file to rename
    let file_to_rename = expand("<cfile>")

    let new_file_name = input("new file name: ", file_to_rename)
    " aborts action if nothing was provided
    if new_file_name == ""
        return
    endif

    let on_files = input("replace refs in files: ", "**/*.cpp")
    " aborts action if nothing was provided
    if on_files == ""
        return
    endif

    exec "grep! '" . file_to_rename . "' " . on_files

    let subs_command = "smagic~\\<" . file_to_rename . "\\>~" . new_file_name . "~gI"

    for place in getqflist()
        let file = bufname(place.bufnr)
        let line = place.lnum

        " reaches the file where to proceed the replacement
        let subs_buffer = place.bufnr
        if subs_buffer == -1
            execute "hide edit ".file
            let subs_buffer = bufnr(file)
        endif
        execute "hide buffer " . subs_buffer

        " tries to join replacements (to cancel them in one shot)
        try
            undojoin
        catch
        endtry

        " tries to proceed replacement
        try
            execute line . "," . line . subs_command
        catch E486
        endtry
    endfor

    " restores position
    execute "hide buffer " . save_buffer
    call setpos('.', save_cursor)

    " saves the file as the new name, but do not remove the former one
    silent execute "!cp " . file_to_rename . " " . new_file_name

endfunction

