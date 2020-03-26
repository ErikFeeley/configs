if exists('g:vscode')
    set lazyredraw
else
    set termguicolors

    " something about safe write.... makes hot reload happier??? yeah.
    " This is very important do it! Some hot reaload or tooling breaks if this
    " is not set!!!!!!!!!!
    set backupcopy=yes

    " forget being compatable with good ole VI
    set nocompatible

    " filetype stuff
    filetype on
    filetype plugin on
    filetype indent on

    set lazyredraw

    set wildmenu

    set number relativenumber

    set mouse=n

    set cc=80

    " Tab settings
    set tabstop=4       " number of visual spaces per TAB
    set softtabstop=4   " number of spaces in tab when editing
    set shiftwidth=4    " number of spaces to use for autoindent
    set expandtab       " tabs are space

    " Language specific tab settings
    autocmd Filetype javascript setlocal ts=2 sw=2 sts=2
    autocmd Filetype javascriptreact setlocal ts=2 sw=2 sts=2
    autocmd Filetype typescript setlocal ts=2 sw=2 sts=2 
    autocmd Filetype typescriptreact setlocal ts=2 sw=2 sts=2

    " more split options
    " better navigation
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

    " Quick-save
    nmap <leader>w :w<CR>

    " ctrl c as escape
    inoremap <C-c> <Esc>
    vnoremap <C-c> <Esc>

    " set sane splits
    set splitright
    set splitbelow

    set fillchars+=vert:\ 
    hi VertSplit cterm=NONE

    " Begin plugin section
    call plug#begin('~/.local/share/nvim/plugged')

    " syntax highlighting!
    syntax enable
    " duh
    set background=dark
    Plug 'chriskempson/base16-vim'
    colorscheme base16-tomorrow-night
    "colorscheme base16-atelier-dune

    " LANGUAGE SUPPORT

    Plug 'hashivim/vim-terraform'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
    set cmdheight=2

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    if has('patch8.1.1068')
      " Use `complete_info` if your (Neo)Vim version supports it.
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current line.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Introduce function text object
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <TAB> for selections ranges.
    " NOTE: Requires 'textDocument/selectionRange' support from the language server.
    " coc-tsserver, coc-python are the examples of servers that support it.
    nmap <silent> <TAB> <Plug>(coc-range-select)
    xmap <silent> <TAB> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Mappings using CoCList:
    " Show all diagnostics.
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR> 

    " END COC CONFIG -----------------------------------------------

    " if you want to disable auto detect, comment out those two lines
    "let g:airline#extensions#disable_rtp_load = 1
    "let g:airline_extensions = ['branch', 'hunks', 'coc']

    let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
    let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
    command! -nargs=0 Prettier :CocCommand prettier.formatFile


    " GO!
    Plug 'fatih/vim-go'
    " disable vim-go :GoDef short cut (gd)
    " this is handled by LanguageClient [LC]
    let g:go_def_mapping_enabled = 0
    " let coc handle K to bring up pop up stuff
    let g:go_doc_keywordprg_enabled = 0

    " maybe need this?
    let g:go_def_mode='gopls'
    let g:go_info_mode='gopls'

    " GO HIGHLIGHTING
    let g:go_highlight_array_whitespace_error = 1
    let g:go_highlight_chan_whitespace_error = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_space_tab_error = 1
    let g:go_highlight_trailing_whitespace_error = 0 " annoying cuz it lights up on new lines
    let g:go_highlight_operators = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_function_parameters = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_generate_tags = 1
    let g:go_highlight_variable_declarations = 1
    let g:go_highlight_variable_assignments = 1

    " C# support kinda fights with the LSP thingy but still needed for better code
    " actions
    Plug 'omnisharp/omnisharp-vim' 

    " just try polyglot
    Plug 'sheerun/vim-polyglot'

    " polyglot uses elmcast vim for syntax highlighting which has keybinds
    " setup... kill them...
    let g:elm_setup_keybindings = 0

    Plug 'scrooloose/nerdtree' " File explorer
    map <C-n> :NERDTreeToggle<CR>
    let NERDTreeShowHidden=1

    " goto fuzzy file finder schtuff
    Plug '/usr/bin/fzf'
    Plug 'junegunn/fzf.vim'
    " Fuzzy Finder Settings
    nnoremap <silent> <C-p> :call fzf#vim#files('.', {'options': '--prompt ""'})<CR>
    nnoremap <silent> <leader>g :call fzf#vim#gitfiles('.', {'options': '--prompt ""'})<CR> 

    let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o -path 'elm-stuff/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

    let g:fzf_layout = { 'window': 'call FloatingFZF()' }

    function! FloatingFZF()
      let buf = nvim_create_buf(v:false, v:true)
      call setbufvar(buf, '&signcolumn', 'no')

      let height = float2nr(&lines / 3)
      let width = float2nr(&columns / 2)
      let horizontal = float2nr((&columns - width) / 2)
      let vertical = float2nr((&lines - height) / 2)

      let opts = {
            \ 'relative': 'editor',
            \ 'row': vertical,
            \ 'col': horizontal,
            \ 'width': width,
            \ 'height': height,
            \ 'style': 'minimal'
            \ }

      call nvim_open_win(buf, v:true, opts)
    endfunction

    " highlight for yank
    Plug 'machakann/vim-highlightedyank'

    " cool status / tabline thingy
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Ctag stuff
    Plug 'universal-ctags/ctags'
    Plug 'craigemery/vim-autotag'

    " Git plugins
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " ONLY FOR OMNISHARP
    "Plug 'dense-analysis/ale'

    " Initialize plugin system
    call plug#end()
    " End plugin section

    "********* PLUGIN SETTINGS

    " OmniSharp

    " GET ALE JUST FOR OMNISHARP
    " Tell ALE to use OmniSharp for linting C# files, and no other linters.
    "let g:ale_sign_column_always = 1
    "let g:ale_linters_explicit = 1
    "let g:ale_linters = { 'cs': ['OmniSharp'] }
    "let g:ale_virtualtext_cursor = 1
    "let g:ale_set_signs=1
    "let g:ale_set_highlights = 1
    "let g:ale_echo_cursor = 0
    " timeout in seconds to wait for a response from the server
    let g:OmniSharp_timeout = 5
    " Use the stdio version of OmniSharp-roslyn:
    let g:OmniSharp_server_stdio = 1

    let g:OmniSharp_start_server = 1

    " Don't autoselect first omnicomplete option, show options even if there is only
    " one (so the preview documentation is accessible). Remove 'preview' if you
    " don't want to see any documentation whatsoever.
    set completeopt=longest,menuone,preview

    " Set the type lookup function to use the preview window instead of echoing it
    let g:OmniSharp_typeLookupInPreview = 0

    " Fetch semantic type/interface/identifier names on BufEnter and highlight them when 3 its all the time
    let g:OmniSharp_highlight_types = 3

    let g:omnicomplete_fetch_full_documentation = 1
    let g:OmniSharp_selector_ui = 'fzf'

    augroup omnisharp_commands
        autocmd!

        " Show type information automatically when the cursor stops moving
        autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

        " The following commands are contextual, based on the cursor position.
        autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

        " Finds members in the current buffer
        autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

        autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
        autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
        autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
        autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

        " Find all code errors/warnings for the current solution and populate the quickfix window
        autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
    augroup END

    " Contextual code actions (uses fzf, CtrlP or unite.vim when available)
    nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
    " Run code actions with text selected in visual mode to extract method
    xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

    " Rename with dialog
    nnoremap <Leader>nm :OmniSharpRename<CR>
    nnoremap <F2> :OmniSharpRename<CR>
    " Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
    command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

    nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

    " Start the omnisharp server for the current solution
    nnoremap <Leader>ss :OmniSharpStartServer<CR>
    nnoremap <Leader>sp :OmniSharpStopServer<CR>

    " Enable snippet completion
    "let g:OmniSharp_want_snippet=1


    " VIM-AIRLINE SETTINGS
    "let g:airline_theme='tomorrow'
    let g:airline_powerline_fonts = 1
endif
