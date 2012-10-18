" customized by rahul kumar
" Maintainer:	rahul
" Last update:  2011-11-12 - 14:31
"
set nocompatible	" Use Vim defaults (much better!)

set bs=2		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set nowritebackup " i am doing this since those large files are being edited awfully slowly
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time - is superceded by statusline
"set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

" added 2010-09-21 21:20 
filetype off
call pathogen#runtime_append_all_bundles() 
"set showmatch  " i find this too confusing
set tabstop=2
set shiftwidth=2
set softtabstop=2
set backupdir=~/tmp/vimbackup//  " put backups in ~/tmp, dont clutter current
set directory=~/tmp/vimswap//
set backup		" keep a backup file - actually without this won't know if file edited in 2 places
" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*" 

set expandtab           " expand tabs to spaces
set nonu                " copying sucks with numbering
set t_Co=256
set background=dark

set incsearch          " i love this
"set cindent             " C indenting as I type -- see ahead !!!
set vb                    " visual bell - no beep
set noeb
if has("autocmd")
  " In text files, always limit the width of text to 72 characters
  autocmd BufRead *.txt set tw=72
  " When editing a file, always jump to the last cursor position
  " thenext line gives annoying errors on temp and log files
  "autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
endif

" Don't use Ex mode, use Q for formatting
map Q gq
noremap W :w<CR>

" map tab to previous matching character
"inoremap <TAB> 

" on F2 copy current line down, and comment current with timestamp
"map <F2> yy0i#<Esc>A # chg on <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>p
"imap <F2> Arunachala added on <C-R>=strftime("%Y%m%d %H:%M:%S")<CR><Esc>
" next is to place on top of files i write as diaries
" to generate date based file name on : prompt when saving
"cmap <F2> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
"cmap <F2> ~/Thoughts/<C-R>=strftime("%Y-%m-%d")<CR>.txt
"cmap <F3> <C-R>=strftime("%Y-%m-%d_%H%M%S")<CR>
" well, in MAC inbuilt laptop kb  you need to press fn+F2 for this.
" F4: Toggle list (display unprintable characters).
"nnoremap <F4> :set list!<CR>
"------------------------------------------------------------------------------
"" HTML.
"------------------------------------------------------------------------------
" " does hyperlinking of content from yaml link files
"nmap \l :/^BODY/,/^---/ ! inter.rb <bar> urlify.rb <bar> urlize.rb
" " will replace prev word with same name + rubyforge.net as URL
"nmap \r hviwyi<A HREF="<ESC>pa.rubyforge.net/"><ESC>lea</A> 
"
"" Print an empty <a> tag.
imap ;h <a href=""></a><ESC>5hi

" Wrap an <a> tag around the URL under the cursor.
map ;H lBi<a href="<ESC>Ea"></a><ESC>3hi
" wrap a <a> tag around selected text (use v motion to select)
vmap ;H `><ESC>a</a><ESC>`<<ESC>i<a href=""><ESC>hi.html<ESC>4hi
" help visual-block to know more
"------------------------------------------------------------------------------
" Enable this if you mistype :w as :W or :q as :Q.
nmap :W :w
nmap :Q :q
" i keep typing :X which is encrypt key
nmap :X :x

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" added jsp and java to c cpp. no wonder the cindent was not working RK XXX
if has("autocmd")
 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcqln nocindent ai comments=sr:#,mb:#,el:#/,:## 
  "autocmd FileType *      set formatoptions=tcqln nocindent ai comments=sr:##,mb:##+,el:#/,:#
  autocmd FileType pl,awk,perl  set formatoptions=croqln cindent comments=sr:#,mb:#
  autocmd FileType c,cpp,java,jsp  set formatoptions=croqln cindent comments=sr:/*,mb:*,el:*/,://
  autocmd FileType sh set formatoptions=croqln cindent comments=sr:#,mb:#,el:#/,:## 
  "autocmd FileType sh set formatoptions=croqln cindent comments=sr:##,mb:##+,el:#/,:#

  autocmd FileType c abbr sep fprintf( stderr, "Error xxx.\n");
  autocmd FileType c abbr sop fprintf( stdout, "Outxxx.\n");
  autocmd FileType c abbr fori for( i = 0; i < len; i++ ){
  autocmd FileType c abbr forj for( j = 0; j < len; j++ ){

  autocmd FileType rb abbr fwrite File.open(filename,"w").write(str).close();

 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  "	  read:	set binary mode before reading the file
  "		uncompress text in buffer after reading
  "	 write:	compress file after writing
  "	append:	uncompress file, append, compress file
"  autocmd BufReadPre,FileReadPre	*.gz set bin
"  autocmd BufReadPost,FileReadPost	*.gz let ch_save = &ch|set ch=2
"  autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
"  autocmd BufReadPost,FileReadPost	*.gz set nobin
"  autocmd BufReadPost,FileReadPost	*.gz let &ch = ch_save|unlet ch_save
"  autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")
"
"  autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
"  autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r
"
"  autocmd FileAppendPre			*.gz !gunzip <afile>
"  autocmd FileAppendPre			*.gz !mv <afile>:r <afile>
"  autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
"  autocmd FileAppendPost		*.gz !gzip <afile>:r
 augroup END
autocmd BufNewFile  *.java	0r ~/.skeleton.java
autocmd BufNewFile  *.c	0r ~/.skeleton.c
autocmd BufNewFile  *.pl 0r ~/.skeleton.pl
autocmd BufNewFile  *.py 0r ~/.skeleton.py
autocmd BufNewFile  *.html 0r ~/.skeleton.html
autocmd BufNewFile  *.rb 0r ~/.skeleton.rb
"autocmd BufNewFile  *.rb 0r ~/.skeleton.rb
autocmd BufNewFile  *.sh 0r ~/.skeleton.sh
autocmd BufNewFile  *.txt 0r ~/.skeleton.txt
autocmd BufNewFile  *.htm 0r ~/.mt.html
endif
" sometimez those fellers didnt work, so here goes ..
"set tw=72
" for java, the last will interfere with c programs
set suffixesadd=.rb
" for the gf or gc feature (goto file)
"set path=.,/usr/include,/home/jdk/src/share/classes
set path=.
"set path=.,src/**,/usr/local/java/src/**
"set path+=~/work/rail/cookbook/app/**
"set path+=~/work/rail/cookbook/lib/**
set path=.,/Users/rahul/work/projects/rbcurse/**
set suffixesadd=.rb
set includeexpr+=substitute(v:fname,'s$','','g')

"set makeprg=ruby

" desert is nice but comments not shown dimmer
" default is nice but highlights hide cursor
":colorscheme darkblue
:colorscheme grb256
" back to default, desert too noisy
":colorscheme default # hides comments which i need to see

" ===================================================================
" Mapping of special keys - arrow keys and function keys.
" ===================================================================
" Buffer commands (split,move,delete) -
"map <F8> :bd<C-M> map <C-Down>  <C-w>j
map <C-Up>    <C-w>k
map <C-Down>    <C-w>j
map <C-Left>  <C-w>h
map <C-Right> <C-w>l
" these 2 rock, they expand the window they move into
map <C-j> <C-W>j<C-w>_
map <C-k> <C-W>k<C-w>_
map <C-h> <C-w>h<C-w>_
map <C-l> <C-w>l<C-w>_

" cycle fast thru buffers ... i have removed <CR> since i often press
" this accidentally and don't want to go next when i have splits
" removed since yankring uses C-n and C-p and i love that
"nnoremap <C-n> :bn
"nnoremap <C-p> :bp
nnoremap <m-n> :bn
nnoremap <m-p> :bp
" in insert mode C-n still gets next match, C-p prev match
"
" cycle fast thru errors ... I wasnt usiong this so lets make it buffers
"map <m-n> :cn<cr>
"map <m-p> :cp<cr>

" open new window on gf
map gf <C-W>f

" goto class instance
map gc gdb<C-W>f

"set su+=.class
"set sua=.java
set includeexpr=substitute(v:fname,'\\.','/','g')

"Expression to be used to transform the string found with the 'include'
"    option to a file name.  Mostly useful to change "." to "/" for Java:
set includeexpr=substitute(v:fname,'\\.','/','g')
                    
" code completion options
"set complete=i,],.,b,w,t,k,.
set complete=.,b
" that menu drove me nuts!!
" 2011-11-3 commented out to see what its like now
"set completeopt=
set dictionary=~/.vimKeywords

" use ctrl-] for jumping to a tag, and ctrl-t to return.
" use ctags *.java to create file named "tags". If you have a file
" called "TAGS" then add that to path using "set tag=./tags,tags,/Users/rahul/work/game/TAGS"
" use ctags 5.5.4 from ctags.sourceforge.net

" added by rahul 2005-11-20 to handle devanagari hindi sanskrit
set encoding=utf-8 fileencodings=

if &t_Co > 2 || has("gui_running")
inoremap =InsertTabWrapper ("forward")
inoremap =InsertTabWrapper ("backward")
function! InsertTabWrapper(direction) 
  let col = col('.') - 1 
  if !col || getline('.')[col - 1] !~ '\k' 
    return "\" 
  elseif "backward" == a:direction 
    return "\" 
  else 
    return "\" 
  endif 
endfunction
endif
" abbreviations that have been put in typeit4me are clashing with these so some commented
"abbr spir spiritual
"abbr sepa separate
"abbr occu occurence
abbr occa occasional
abbr nece necessary
abbr dont don't
abbr wont won't
abbr Dont Don't
abbr cant can't
abbr didnt didn't
abbr doesnt doesn't
abbr thats that's
abbr whats what's
"abbr i I
abbr yu you
abbr yuo you
abbr THat That
abbr THe The
abbr THey Them
abbr THis This
" added for ruby from http://wiki.rubygarden.org/Ruby/page/show/VimRubySupport
filetype on
syntax on
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
" 2006-06-05 4:45 PM intellisense in ruby
autocmd FileType ruby,eruby,dsl set omnifunc=rubycomplete#Complete

imap <S-CR> <ESC>:execute 'normal o' . EndToken()<CR>O
" ruby stuff
abbr yload mymap = YAML::load( File.open("config.yml"));
abbr ydump File.open("config.yml", "w") { <bar> f <bar> YAML.dump( hash, f )}
abbr fwrite  File.open(filename, 'w') {<bar>f<bar> f.write(str) }
"abbr fappend File::append(filename, str); # require 'facets'
abbr fappend File.open(filename,'a'){ <bar>f<bar> f.write text }
"abbr #!ruby #!/usr/bin/env ruby -w

" Wraps visual selection in an HTML tag
vmap ,w <ESC>:call VisualHTMLTagWrap()<CR>
vmap ,m <ESC>:call VisualMarkdownTagWrap()<CR>

function! VisualHTMLTagWrap()
     "let a:tag = toupper( input( "Tag to wrap block: ") )
     let a:tag =  input( "Tag to wrap block: ") 
     let a:jumpright = 2 + len( a:tag )
     normal `<
     let a:init_line = line( "." )
     exe "normal i<".a:tag.">"
     normal `>
     let a:end_line = line( "." )
     " Don't jump if we're on a new line
     if( a:init_line == a:end_line )
         " Jump right to compensate for the
         " characters we've added
         exe "normal ".a:jumpright."l"
     endif
     exe "normal a</".a:tag.">"
endfunction

function! VisualMarkdownTagWrap()
     "let a:tag = toupper( input( "Tag to wrap block: ") )
     let a:tag =  input( "Chars to wrap block: ") 
     let braces_at_start = ['[','{','(','[','<']
     let braces_at_end = [']','}',')',']','>']
     let a:jumpright = 0 + len( a:tag )
     normal `<
     let a:init_line = line( "." )
     exe "normal i".a:tag
     normal `>
     let a:end_line = line( "." )
     " Don't jump if we're on a new line
     if( a:init_line == a:end_line )
         " Jump right to compensate for the
         " characters we've added
         exe "normal ".a:jumpright."l"
     endif
     let m = index(braces_at_start,a:tag)
     if m >= 0
         "exe "normal a".strpart(braces_at_end,m,1)
         exe "normal a".get(braces_at_end,m,"")
     else
         exe "normal a".a:tag
     endif
endfunction
" added 2009-10-28 15:04 to give me a method stub
map ,f <ESC>:call MyRubyMethod()<CR>
" see http://yard.soen.ca/getting_started.html#using
function! MyRubyMethod()
     exe ":set paste"
     let a:tag =  input( "Enter Method name: ") 
     let a:param =  input( "Parameters (comma sep): ") 
     "exe ":r ! sed 's/method/" . a:tag . "/g' ~/.yard.rb"
     let mylist = split(a:param, '[,\W]')
     exe "normal o     ## "
     exe "normal o     #  XXX Desc"
     exe "normal o     #  "
     for item in mylist
         exe "normal o     # @param [String] ".item . " comment" 
     endfor
     exe "normal o     # @return [true, false] comment" 
     exe "normal o    "
     exe "normal o     def ".a:tag."(".a:param.")"
     for item in mylist
         exe "normal o       @".item . " = ".item . ";"
     endfor
     exe "normal o     end # ".a:tag
     exe ":set nopaste"
endfunction

map ,p <ESC>:call MyRubyPMethod()<CR>
function! MyRubyPMethod()
     exe ":set paste"
     let a:tagg =  input( "Enter property name: ") 
     let a:date = system("date")
     "exe ":r ! sed 's/symbol/" . a:tagg . "/g;s/DTS/" . a:date . "/g' ~/.method.rb"
     exe ":r ! sed 's/symbol/" . a:tagg . "/g' ~/.method.rb"
     exe ":set nopaste"
endfunction


"noreabbr pre, <pre style="margin: 1.5em 0px; padding: 10px 10px 10px 10px; color: #333; background: #000000;color:#ffffff; font-family: monaco,monospace; font-size: 120%; border-left: solid #ccc 1px; overflow: auto;">
"noreabbr codesnip, <pre style="margin: 1.5em 0px; padding: 10px 10px 10px 10px; color: #333; background: #EFEFEF;color:#000016; font-family: courier,monospace; font-size: 120%; border: solid #ccc 2px; overflow: auto;">
"noreabbr gpre, <pre  style="background: #333333; color: white; padding: 15px; border: 1px solid #666666; font-family: courier,monospace; font-size: 120%; overflow: auto;"><code><CR></code></pre>
"

" " post current file to livejournal account
"map ;ljp :!ljpost.rb %<CR>

abbr fread lines = File.open(file,'r').readlines

nmap ,i viw;it<ESC>
"nmap ,s O[[ slnc 1000 ]]<ESC>
" map ,s [[ slnc 1000 ]]<ESC>
"abbr ,s [[ slnc 5000 ]] 
" visual area will be written to tmp file, new post file created and then new.sh
" reads in the temp file 20080101 22:45:50
":vmap #xxx :w! ~/tmp/post.tmp <CR>:!~/work/posts/new.sh<CR>
" this was great once, but now conflicts with ,,L and others
":map ,, a,<ESC>
":map ,p i<CR>[[ slnc 1000 ]]<CR><ESC>

" 2008-09-11 21:36 taglist plugin
nnoremap <F8>   :TlistToggle
":TlistAddFilesRecursive ~/work/ *.rb
":TlistAddFiles *.rb


map K :w<CR>:! ruby %
map <F6> :!ruby %<CR>
map <S-Enter> O<ESC> " awesome, inserts new line without going into insert mode
" Professor VIM says '87% of users prefer jj over esc', jj abrams strongly
" disagrees
imap jj <Esc>
imap kk <Esc>
imap jk <Esc>:w<CR>
imap hh =>
"imap aa @
" I often want to insert only one character and then navigate left or right
" without having to do an ESC and then navigate. qa lets me insert just one and be back in command mode
" Oops, now i cannot record, i use qq to record a macro
map qa i.<ESC>r
inoremap uu _

" 2008-10-13 16:56 visual up and down on arrow key
map <UP> gk
map <DOWN> gj
" often changing text till _. Also, @ used as instance var start
":set iskeyword-=_
"set iskeyword+=@
" I used pastetoggle a lot when copying code
:set pastetoggle=<F7>
"map ;dl viWyi#{<ESC>ea}<ESC>
" 2010-01-12 13:30 changed viW to viw so that commas don't get included.
" I am also mapping dl and di to ll and li since dl can be destructive if 
"  i type slowly
map ;ll viWdi#{<ESC>pa}<ESC>
map ;li viWdi#{@<ESC>pa}<ESC>
"map ;di viWyi#{@<ESC>ea}<ESC>
map ;db i$log.debug "DEBUG :
noreabbr ,d $log.debug "XXX: 
noreabbr ,w $log.warn "XXX: WARN 
"" read up screens buffer (usually for backticks that mangle screen since its
"" my escape key
map ;pb o<ESC>:r ~/tmp/screen-buffer<CR>

"abbr #!ruby #!/usr/bin/env ruby -w
map ;hr  i#!/usr/bin/env ruby -w
map ;hb  i#!/bin/bash

" comment and uncomment with #
" # ooooh, ./ was lovely but it really slowed down using the dot for repeat
noremap ;/ :s/^\( *\)/\1#/<CR><Esc>:nohlsearch <CR>
noremap ;? :s/^\( *\)#/\1/<CR><Esc>:nohlsearch <CR>
" save
noremap ;; :w<CR>
inoremap ;; <ESC>:w<CR>
" comments current line, since ;/ destroys current search.
map ;co I#<Esc>A # <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><ESC>j
" http://vim.wikia.com/wiki/Easy_(un)commenting_out_of_source_code
" in shell, go to definition of function
autocmd FileType sh map <buffer> gf /^<C-R>=expand("<cword>")<cr><cr>
autocmd FileType ruby map <buffer> gf /^ *def <C-R>=expand("<cword>")<cr><cr>
autocmd FileType ruby map <buffer> gc /^ *class <C-R>=expand("<cword>")<cr><cr>
" Use vims comment character instead of hash
autocmd FileType vim map <buffer> ;/ :s/^\( *\)/\1"/<CR><Esc>:nohlsearch <CR>

" center text and put # at both sides. spaces pad
map ;c1 :center<CR>$80a <ESC>80\|Da#<ESC>0r#
" center text and put # at both sides. hyphen pad
map ;c2 :center<CR>$a <ESC>80a-<ESC>80\|lDbdwp0P2ldw80\|Da#<ESC>0r#
" make a banner with stars
" +taking extra care since comment formatting often already puts a # in next
" +line
map ;cba o<ESC>0D80a*<ESC>80\|r#0.
map ;cbl o<ESC>0D80a <ESC>80\|r#0.
" make banner with date
map ;dd :r! date '+\%B \%d, \%Y'<CR>;c1
"map ;dd :exe "normal o" . strftime("%B %d, %Y") <CR>;c1 
" make banner with filename
map ;d0 :r! echo %<CR>;c1
"map ;d0 :exe "normal o" . expand("%:t") <CR>;c1
map  ;dh ;cba;d0;dd;cbl;cba

" align comments with # \t#
map <silent> <Leader>a# \WS:'a,.s/#\([ \t]*\)\(.*\)$/###@@# \2/e<CR>'zk<Leader>tldW@:'y,'zs/^\(\s*\) @@/\1/e<CR>:'y,'zs/ @@ //eg<CR>:'y,'zs/###//eg<CR>\WE
vmap <silent> <Leader>a# :<BS><BS><BS><CR>ma'><Leader>a#
" puts a # around text. Puts final # at column 80. Caution: truncates
" at 80 !!!
let @q = "0:.s/^[ #]*//gi# $80a 80|Da#j"
let @l = "0Di# 76a-a #j"
"" puts a backtick around a word, containing a underscore, and word
"" ending in () - replaces all in file ! - for markdown docs
let @s = ':%s/ \([a-z]*_[a-z0-9_]*\)\>/ `\1`/g:%s/ \([a-z][a-z0-9]*()\)/ `\1`/g'

"" surrounds current word with backticks - for markdown docs - use surround.vim ysiw
let @c = 'viW`>a``<i`'
let @o = 'yy^i#A # changed  :echo strftime("%Y-%m-%d %H:%M")p'
let @o='yy^i#p'
"let @o='^i#A # changed on :r! datebJ'
"let @o='^i#A # changed on dts?kb?kb?kb2011-10-2 '
"let @x = 'viwdpbXhr:'
" convert a string to a symbol (ruby)
let @x = 'elxbhr:'
" place on a variable it duplicated the name and places #{ around it by
" calling ;dl
let @y = 'viwyPa w;llw'
"let @d = 'viWyO,d pa: pa "b;dl'
" create a log debugstatement for varaible under cursor on above line
let @d = 'viWyO,d XXX pa: pa "b;dl'
" write visual area to x.x - save and read into another terminal
let @w = ':w! ~/tmp/x.x'
" read  x.x
let @r = ':r ~/tmp/x.x'
" NOTE to save macro here press C-r C-r q (where q is macro character), see
" :registers also
if $TERM == 'screen'
  set term=xterm-256color
  let g:GNU_Screen_used = 1
else
  let g:GNU_Screen_used = 0
endif
"let @v=':%s/^.*DEBUG -- :/:/g'
" place cursor on param in def, will created initialize and attr_reader
let @i='viwyo   pa  = pI@kOattr_reader :p'
" taken from http://bitbucket.org/number5/dotfiles/src/tip/dot.vimrc -
" YIPPEE !i always wanted that white status line like emacs
"set statusline=[%l,%c\ %P%M]\ %f\ %r%h%w
set cmdheight=1
set laststatus=2

" open files in same location as current file (http://vimcasts.org/episodes/the-edit-command/)
map <leader>ew :e <C-R>=expand("%:p:h") . "/"  <CR>
" open in a split
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
" in command mode do :sp %% (and it will expand to path/directory of current file
cmap %% <C-R>=expand("%:p:h") . "/" <CR>

"http://nvie.com/posts/how-i-boosted-my-vim/
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :sp $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <leader>es :split ~/.vim/bundle/snipmate.vim/snippets/ruby.snippets<CR>
nnoremap <leader>er :split ~/README<cr>
nnoremap <leader>ez :split ~/.zshrc<cr>
nnoremap <leader>ea :split ~/.oh-my-zsh/lib/aliases.zsh
autocmd FileType ruby nmap <buffer> <silent> <leader>es :split ~/.vim/bundle/snipmate.vim/snippets/ruby.snippets
"autocmd FileType sh nmap <buffer> <silent> <leader>es :split ~/.vim/bundle/snipmate.vim/snippets/sh.snippets
" commented ww to try vimwiki which uses this
"map <silent> <leader>ww  :w! ~/tmp/vimxfer<CR>
map <silent> <leader>wa  :w!>> ~/tmp/vimxfer<CR>
nmap <silent> <leader>rr  :r ~/tmp/vimxfer<CR>

" save files when tabbing elsewhere: http://stevelosh.com/blog/2010/09/coming-home-to-vim/
au FocusLost * :wa
nnoremap <leader>a :Ack

nnoremap <leader>ff :<C-u>FufFile **/<CR> 
nnoremap <leader>fb :<C-u>FufBuffer<CR>
let g:fuf_keyOpen = '<C-l>'
let g:fuf_keyOpenSplit = '<CR>'
nnoremap <leader>nt  :NERDTreeToggle
nnoremap <leader>yr   :YRShow
" t is alreadt mapped to align, so takes a second extra
nnoremap <leader>c   :CommandT<CR>
map <leader><leader> :CommandT<cr>

map <silent> <F2> :NERDTreeToggle
map <silent> <F3> :<C-u>FufFile **/<CR> 
nnoremap <silent> <F4> :YRShow<cr>
inoremap <silent> <F4> <ESC>:YRShow<cr>

" extremely irritating
"nnoremap / /\v
"vnoremap / /\v
set ignorecase
set smartcase
set gdefault
nnoremap <leader><space> :noh<cr>
"nnoremap <TAB> %
nmap <TAB> %
vnoremap <TAB> %
" some 7.3 stuff
"http://stevelosh.com/blog/2010/09/coming-home-to-vim/
if version >= 703
    "set relativenumber " i am tired of this 
    "set cursorline  " looks awful - can't make out : ; and . ,
    set ttyfast
    set undofile
    " added undodir on 2011-08-21 http://news.ycombinator.com/item?id=2907730
    "
    " changed to undodir since littering current. It is not saving in tmp.
    set undodir=~/tmp/undodir
    "set colorcolumn=85  " another pain since it masks character
endif
set formatoptions=qrn1

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
" reselect pasted text for indenting etc
nnoremap <leader>v V`]
" add nodoc at end of ruby method
nnoremap <leader>no A  #:nodoc:<ESC>
" for command-t to avoid pkg
set wildignore+=pkg
set wildignore+=*.log,*.bak,*.old,*.orig,*.tmp
set wildmenu
" full gives us enhanced menu at screen bottom, whereas list and longest switch it off
set wildmode=full

" often C-Cr and C-s are not working
let CommandTAcceptSelectionSplitMap='<C-v>'

au! BufNewFile,BufRead crontab.* set nobackup | set nowritebackup 
" Taken from http://stackoverflow.com/questions/164847/what-is-in-your-vimrc
" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
"map N Nzz
"map n nzz

" execute file on :W
" autocmd! FileType ruby set shiftwidth=2 softtabstop=2 tabstop=2 makeprg=ruby\ %
"autocmd FileType ruby command -buffer W write | !ruby %
"autocmd FileType sh command -buffer W write | !./%
"  make file chmod +x auto
autocmd BufWritePost * call NoExtNewFile()
function! NoExtNewFile()
    if getline(1) =~ "^#!.*/bin/"
        if &filetype == ""
            filetype detect
        endif
        silent !chmod a+x <afile>
    endif
endfunction
" reload vimrc
autocmd! BufWritePost .vimrc source %
set swapfile 
noremap <Space> <PageDown>
noremap - <PageUp>
" go to alt file
nnoremap ` <c-^>
" goto exact column, not just line
nnoremap ' `
abbr FN FFI::NCurses

"https://bitbucket.org/sjl/dotfiles/src/1b6ffba66e9f/vim/.vimrc#cl-1023
augroup ft_statuslinecolor
    au!
    au InsertEnter * hi StatusLine ctermbg=red guifg=#FF3145
    au InsertLeave * hi StatusLine ctermbg=darkblue ctermfg=white guifg=#CD5907


    " steve's default, but i can't see text on statusline often
    "au InsertEnter * hi StatusLine ctermfg=196 guifg=#FF3145
    "au InsertLeave * hi StatusLine ctermfg=130 guifg=#CD5907



    

augroup END
noremap H ^
noremap L $

function! EatChar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction

function! MakeSpacelessIabbrev(from, to)
    execute "iabbrev <silent> ".a:from." ".a:to."<C-R>=EatChar('\\s')<CR>"
endfunction

call MakeSpacelessIabbrev('gh/',  'http://github.com/')
call MakeSpacelessIabbrev('ghr/', 'http://github.com/rkumar/rbcurse/')

" Heresy
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Ack for the last search.
nnoremap <silent> <leader>? :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

" only Mac Vim
    if has("gui_macvim")
        set guifont=Menlo\ Regular:h18
        set fuoptions=maxvert,maxhorz
        noremap  <F1> :set invfullscreen<CR>
        inoremap <F1> <ESC>:set invfullscreen<CR>a
    end


set statusline=%f    " Path.
set statusline+=%m   " Modified flag.
set statusline+=%r   " Readonly flag.
set statusline+=%w   " Preview window flag.
" Add time since I am using fullscreen on Lion
" I've got the time on screens caption so i don't need it 
"set statusline+=\ \ %{strftime(\"%d/%m/%y\ -\ \%l:%M\ %p\ ~\ %a\")}
set statusline+=\ \ %{strftime(\"\%l:%M\ %p\ ~\ %a\")}
""
set statusline+=\    " Space.
""
set statusline+=%#redbar#                " Highlight the following as a warning.
set statusline+=%{SyntasticStatuslineFlag()} " Syntastic errors.
set statusline+=%*                           " Reset highlighting.
""
set statusline+=%=   " Right align.
"
"
"" Line and column position and counts.
"set statusline+=\ (line\ %l\/%L,\ col\ %03c)
set statusline+=\ \ %l,%c\ \ \ \ \ %P
"set statusline=[%l,%c\ %P%M]\ %f\ %r%h%w
"
inoremap # X<BS>#
" swap two woeds, even if there's a comma or = in between switch exchange
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l>

" =============================================================================
" Abbreviations - General Editing - Inserting Dates and Times
" =============================================================================
"
" First, some command to add date stamps (with and without time).
" I use these manually after a substantial change to a webpage.
" [These abbreviations are used with the mapping for ",L".]
"
  iab Ydate <C-R>=strftime("%y%m%d")<CR>
" Example: 020523

  "iab Cdate <C-R>=strftime("%d.%m.%y - %H:%M")<CR>
  iab Cdate <C-R>=strftime("%Y-%m-%d - %H:%M")<CR>
" Example: 23.05.02 - 17:06
"
  iab Ytime <C-R>=strftime("%H:%M")<CR>
" Example: 17:06
"
" man strftime:     %T      time as %H:%M:%S
" iab YDT           <C-R>=strftime("%y%m%d %T")<CR>
" Example: 971027 12:00:00
"
" man strftime:     %X      locale's appropriate time representation
  iab YDT           <C-R>=strftime("%y%m%d %X")<CR>
" Example: 020523 17:06:49
"
  iab YDATE <C-R>=strftime("%a %b %d %T %Z %Y")<CR>
" Example: Don Mai 23 17:06:56 CEST 2002

" file name
  iab YFF  <C-R>=expand("%:t")<CR>
" =============================================================================
" Inserting Dates and Times / Updating Date+Time Stamps
" =============================================================================
"     ,L  = "Last update" - replace old time stamp with a new one
"        preserving whitespace and using internal "strftime" command:
"       requires the abbreviation  "YDATE"
  map ,L  1G/Latest change\s*:\s*/e+1<CR>CYDATE<ESC>
  map ,,L 1G/Last update\s*:\s*/e+1<CR>CCdate<ESC>
  map ,,,L 1G/Last Change\s*:\s*/e+1<CR>CYDT<ESC>
  map ,,F 1G/ File\s*:\s*/e+1<CR>CYFF<ESC>
  map ,,N 1G/ Name\s*:\s*/e+1<CR>CYFF<ESC>
  map ,,D 1G/ Date\s*:\s*/e+1<CR>CCdate<ESC>
" yank til end of line, i've never used Y for entire line
map Y y$
" 020628 The following code will add a function heading and position your
" cursor just after Description so that one can document as one proceeds with
" code.
function! FileHeading()
     exe "normal gg"
     " nopaste results in the lines getting indented
     " paste means that the file name and date will not expand, so i have to issue
     " commands to do the replace afterwards.
     exe ":set paste"
     "exe ":set noai"
     exe "normal O# ----------------------------------------------------------------------------- #"
     exe "normal o#         File: YFF "
     exe "normal o#  Description: "
     exe "normal o#       Author: rkumar http://github.com/rkumar/rbcurse/"
     exe "normal o#         Date: Cdate "
     exe "normal o#      License: Same as Ruby's License (http://www.ruby-lang.org/LICENSE.txt)"
     exe "normal o#  Last update: use ,,L"
     exe "normal o#"
     exe "normal O# ----------------------------------------------------------------------------- #"
     exe ":set nopaste"
     exe "normal ,,F"
     exe "normal ,,D"
endfunction
" -> define the keymapping:
map ,fh <esc>mz:execute FileHeading()<CR>`zjj
"
" Sudo to write
cmap w!! w !sudo tee % >/dev/null

inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
"nnoremap <CR> o<ESC>

" Open a Quickfix window for the last search. sjl
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Ack for the last search.
nnoremap <silent> <leader>? :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>

" http://news.ycombinator.com/item?id=3251743
let g:SuperTabDefaultCompletionType = "context"
