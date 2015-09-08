# some default flags
# for more information install clang-3.2-doc package and
# check UsersManual.html
flags = [
'-Wall',
'-Werror',

# std is required
# clang won't know which language to use compiling headers
'-std=c++11',

# '-x' and 'c++' also required
# use 'c' for C projects
'-x',
'c++',

# include third party libraries
#'-isystem',
#'/usr/include/python2.7',
]

# youcompleteme is calling this function to get flags
# You can also set database for flags. Check: JSONCompilationDatabase.html in
# clang-3.2-doc package
def FlagsForFile( filename ):
  return {
    'flags': flags,
    'do_cache': True
  }

