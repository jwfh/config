# perf-annotate
# Autogenerated from man page /usr/share/man/man1/perf-annotate.1.gz
# using Deroffing man parser
complete -c perf-annotate -s i -l input --description 'Input file name.  (default: perf. data unless stdin is a fifo).'
complete -c perf-annotate -s d -l dsos --description 'Only consider symbols in these dsos.'
complete -c perf-annotate -s s -l symbol --description 'Symbol to annotate.'
complete -c perf-annotate -s f -l force --description 'Don\\(cqt complain, do it.'
complete -c perf-annotate -s v -l verbose --description 'Be more verbose.  (Show symbol address, etc).'
complete -c perf-annotate -s D -l dump-raw-trace --description 'Dump raw trace in ASCII.'
complete -c perf-annotate -s k -l vmlinux --description 'vmlinux pathname.'
complete -c perf-annotate -s m -l modules --description 'Load module symbols.'
complete -c perf-annotate -s l -l print-line --description 'Print matching source lines (may be slow).'
complete -c perf-annotate -s P -l full-paths --description 'Don\\(cqt shorten the displayed pathnames.'
complete -c perf-annotate -l stdio --description 'Use the stdio interface.'
complete -c perf-annotate -l tui --description 'Use the TUI interface.'
complete -c perf-annotate -l gtk --description 'Use the GTK interface.'
complete -c perf-annotate -s C -l cpu --description 'Only report samples for the list of CPUs provided.'
complete -c perf-annotate -l asm-raw --description 'Show raw instruction encoding of assembly instructions.'
complete -c perf-annotate -l source --description 'Interleave source code with assembly code.'
complete -c perf-annotate -l symfs --description 'Look for files with symbols relative to this directory.'
complete -c perf-annotate -s M -l disassembler-style --description 'Set disassembler style for objdump.'
complete -c perf-annotate -l objdump --description 'Path to objdump binary.'
complete -c perf-annotate -l skip-missing --description 'Skip symbols that cannot be annotated.'
complete -c perf-annotate -l group --description 'Show event group information together.'

