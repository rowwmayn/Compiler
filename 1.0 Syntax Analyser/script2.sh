set -e

yacc -d -y --debug --verbose syntax_analyzer_student_version.y
echo 'Generated the parser C file as well as the header file'


g++ -w -c -o y.o y.tab.c
echo 'Generated the parser object file'


flex lex_analyzer.l
echo 'Generated the scanner C file'

g++ -fpermissive -w -c -o l.o lex.yy.c
echo 'Generated the scanner object file'

g++ y.o l.o -o a.exe
echo 'Executable a.exe generated successfully'

echo 'Running the Syntax Analyzer...'
./a.exe input.txt