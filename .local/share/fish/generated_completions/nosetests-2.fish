# nosetests-2
# Autogenerated from man page /usr/share/man/man1/nosetests-2.7.1.gz
# using Deroffing man parser
complete -c nosetests-2 -s V -l version --description 'Output nose version and exit.'
complete -c nosetests-2 -s p -l plugins --description 'Output list of available plugins and exit.'
complete -c nosetests-2 -s v -l verbose --description 'Be more verbose.  [NOSE_VERBOSE].'
complete -c nosetests-2 -l verbosity --description 'Set verbosity; --verbosity=2 is the same as -v.'
complete -c nosetests-2 -s q -l quiet --description 'Be less verbose.'
complete -c nosetests-2 -s c -l config --description 'Load configuration from config file(s).'
complete -c nosetests-2 -s w -l where --description 'Look for tests in this directory.'
complete -c nosetests-2 -l py3where --description 'Look for tests in this directory under Python 3. x.'
complete -c nosetests-2 -s m -l match -l testmatch --description 'Files, directories, function names, and class n… [See Man Page]'
complete -c nosetests-2 -l tests --description 'Run these tests (comma-separated list).'
complete -c nosetests-2 -s l -l debug --description 'Activate debug logging for one or more systems.'
complete -c nosetests-2 -l debug-log --description 'Log debug messages to this file (default: sys. stderr).'
complete -c nosetests-2 -l logging-config -l log-config --description 'Load logging config from this file -- bypasses … [See Man Page]'
complete -c nosetests-2 -s I -l ignore-files --description 'Completely ignore any file that matches this re… [See Man Page]'
complete -c nosetests-2 -s e -l exclude --description 'Don\'t run tests that match regular expression [NOSE_EXCLUDE].'
complete -c nosetests-2 -s i -l include --description 'This regular expression will be applied to file… [See Man Page]'
complete -c nosetests-2 -s x -l stop --description 'Stop running tests after the first error or failure.'
complete -c nosetests-2 -s P -l no-path-adjustment --description 'Don\'t make any changes to sys.'
complete -c nosetests-2 -l exe --description 'Look for tests in python modules that are executable.'
complete -c nosetests-2 -l noexe --description 'DO NOT look for tests in python modules that are executable.'
complete -c nosetests-2 -l traverse-namespace --description 'Traverse through all path entries of a namespace package.'
complete -c nosetests-2 -l first-package-wins -l first-pkg-wins -l 1st-pkg-wins --description 'nose\'s importer will normally evict a package from sys.'
complete -c nosetests-2 -l no-byte-compile --description 'Prevent nose from byte-compiling the source into .'
complete -c nosetests-2 -s a -l attr --description 'Run only tests that have attributes specified b… [See Man Page]'
complete -c nosetests-2 -s A -l eval-attr --description 'Run only tests for whose attributes the Python … [See Man Page]'
complete -c nosetests-2 -s s -l nocapture --description 'Don\'t capture stdout (any stdout output will be… [See Man Page]'
complete -c nosetests-2 -l nologcapture --description 'Disable logging capture plugin.'
complete -c nosetests-2 -l logging-format --description 'Specify custom format to print statements.'
complete -c nosetests-2 -l logging-datefmt --description 'Specify custom date/time format to print statements.'
complete -c nosetests-2 -l logging-filter --description 'Specify which statements to filter in/out.'
complete -c nosetests-2 -l logging-clear-handlers --description 'Clear all other logging handlers.'
complete -c nosetests-2 -l logging-level --description 'Set the log level to capture.'
complete -c nosetests-2 -l with-coverage --description 'Enable plugin Coverage:  Activate a coverage re… [See Man Page]'
complete -c nosetests-2 -l cover-package --description 'Restrict coverage output to selected packages [… [See Man Page]'
complete -c nosetests-2 -l cover-erase --description 'Erase previously collected coverage statistics before run.'
complete -c nosetests-2 -l cover-tests --description 'Include test modules in coverage report [NOSE_COVER_TESTS].'
complete -c nosetests-2 -l cover-min-percentage --description 'Minimum percentage of coverage for tests to pas… [See Man Page]'
complete -c nosetests-2 -l cover-inclusive --description 'Include all python files under working director… [See Man Page]'
complete -c nosetests-2 -l cover-html --description 'Produce HTML coverage information.'
complete -c nosetests-2 -l cover-html-dir --description 'Produce HTML coverage information in dir.'
complete -c nosetests-2 -l cover-branches --description 'Include branch coverage in coverage report [NOS… [See Man Page]'
complete -c nosetests-2 -l cover-xml --description 'Produce XML coverage information.'
complete -c nosetests-2 -l cover-xml-file --description 'Produce XML coverage information in file.'
complete -c nosetests-2 -l pdb --description 'Drop into debugger on failures or errors.'
complete -c nosetests-2 -l pdb-failures --description 'Drop into debugger on failures.'
complete -c nosetests-2 -l pdb-errors --description 'Drop into debugger on errors.'
complete -c nosetests-2 -l no-deprecated --description 'Disable special handling of DeprecatedTest exceptions.'
complete -c nosetests-2 -l with-doctest --description 'Enable plugin Doctest:  Activate doctest plugin… [See Man Page]'
complete -c nosetests-2 -l doctest-tests --description 'Also look for doctests in test modules.'
complete -c nosetests-2 -l doctest-extension --description 'Also look for doctests in files with this exten… [See Man Page]'
complete -c nosetests-2 -l doctest-result-variable --description 'Change the variable name set to the result of t… [See Man Page]'
complete -c nosetests-2 -l doctest-fixtures --description 'Find fixtures for a doctest file in module with… [See Man Page]'
complete -c nosetests-2 -l doctest-options --description 'Specify options to pass to doctest.  Eg.'
complete -c nosetests-2 -l with-isolation --description 'Enable plugin IsolationPlugin:  Activate the is… [See Man Page]'
complete -c nosetests-2 -s d -l detailed-errors -l failure-detail --description 'Add detail to error output by attempting to eva… [See Man Page]'
complete -c nosetests-2 -l with-profile --description 'Enable plugin Profile:  Use this plugin to run … [See Man Page]'
complete -c nosetests-2 -l profile-sort --description 'Set sort order for profiler output.'
complete -c nosetests-2 -l profile-stats-file --description 'Profiler stats file; default is a new temp file on each run.'
complete -c nosetests-2 -l profile-restrict --description 'Restrict profiler output.  See help for pstats.'
complete -c nosetests-2 -l no-skip --description 'Disable special handling of SkipTest exceptions.'
complete -c nosetests-2 -l with-id --description 'Enable plugin TestId:  Activate to add a test i… [See Man Page]'
complete -c nosetests-2 -l id-file --description 'Store test ids found in test runs in this file.'
complete -c nosetests-2 -l failed --description 'Run the tests that failed in the last test run.'
complete -c nosetests-2 -l processes --description 'Spread test run among this many processes.'
complete -c nosetests-2 -l process-timeout --description 'Set timeout for return of results from each tes… [See Man Page]'
complete -c nosetests-2 -l process-restartworker --description 'If set, will restart each worker process once t… [See Man Page]'
complete -c nosetests-2 -l with-xunit --description 'Enable plugin Xunit: This plugin provides test … [See Man Page]'
complete -c nosetests-2 -l xunit-file --description 'Path to xml file to store the xunit report in.'
complete -c nosetests-2 -l xunit-testsuite-name --description 'Name of the testsuite in the xunit xml, generated by plugin.'
complete -c nosetests-2 -l all-modules --description 'Enable plugin AllModules: Collect tests from al… [See Man Page]'
complete -c nosetests-2 -l collect-only --description 'Enable collect-only:  Collect and output test n… [See Man Page]'

