function ff {
   find . -name "$1"
}

function fd {
   find . -type d -name "$1"
}

alias git_url='git config --get remote.origin.url'

function get_cmake_setting {
   cmake -LA | sed -n  -r  -e 's/([^:]+)\:\w*=(\w+)/\1=\2/p'
}

alias rmcmake='rm CMakeCache.txt;rm -rf CMakeFiles'

function lvi {
    vi `echo $1 | sed -n  -r  -e 's/([^:]+)\:([0-9]+).*/\+\2 \1/p'`
}

function fmake {
    find . -name "CMakeLists.txt" | xargs grep -n $1
}

alias tmuxa='tmux -CC attach'

function findd {
	find . -type d -name $1
}

alias chkspace='du -h -d 1'

function git_fork_list {
curl -X GET $(echo $1 | sed --quiet --regexp-extended "s/https:\/\/github\.com\/([^\/]+)\/([a-zA-Z0-9_\-]+)\.git/https:\/\/api.github.com\/repos\/\1\/\2\/forks/p")
}

alias mkbuild='mkdir build;cd build'

function viff {
   file_list=($(find . -name $1))
   if [ ${#file_list[@]} -eq 1 ] ; then
       vi ${file_list[0]}
       return 0
   fi

   index=0
   for file in ${file_list[*]}
   do
       index=$(( index + 1 ))
       printf "%d: %s\n" $index $file
   done

   printf "Selec the file to edit:"
   read index

   vi ${file_list[$(( index - 1 ))]}
}

function cdf {
    cd `echo $1 | sed -n -r -e 's/(.*\/)[^\/]+/\1/p'`
}

function dump_ast {
`sed -r -n -e 's/"command": "(.*)(-o +[^ ]+)(.*)\/'$1'",/\1 -Xclang -ast-dump -fsyntax-only -fno-color-diagnostics \3\/'$1'/gp' compile_commands.json`
}

function dump_layout {
	`sed -n -r -e'/.*command.*'$1'.*/s/(.*) -g(.*)/\1\2/gp' compile_commands.json | sed -n -r -e 's/"command": "([^ ]+)(.*)(-o +[^ ]+)(.*)(-c ([^ ]+))",/\1 -cc1 -fdump-record-layouts \6 \2 \4 /gp'`
}

function compile_options {
    sed -r -n --expression='s/\s+"command":\s+"([^"]+) -o [^ ]+ -c ([^ ]+'$1')",/\1 -c /p' compile_commands.json
}

function ast_dump 
{
    `sed -r -n --expression='s/\s+"command":\s+"([^"]+) -o [^ ]+ -c ([^ ]+'$1')",/clang-check -ast-dump \2 -- \1 -c /p' compile_commands.json`
}

function ast_print 
{
    `sed -r -n --expression='s/\s+"command":\s+"([^"]+) -o [^ ]+ -c ([^ ]+'$1')",/clang-check -ast-print \2 -- \1 -c /p' compile_commands.json`
}

