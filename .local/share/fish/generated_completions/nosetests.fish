# nosetests
# Autogenerated from man page /usr/share/man/man1/nosetests.1.gz
# using Deroffing man parser
complete -c nosetests -s V -l version --description 'Output nose version and exit.'
complete -c nosetests -s p -l plugins --description 'Output list of available plugins and exit.'
complete -c nosetests -s v -l verbose --description 'Be more verbose.  [NOSE_VERBOSE].'
complete -c nosetests -l verbosity --description 'Set verbosity; --verbosity=2 is the same as -v.'
complete -c nosetests -s q -l quiet --description 'Be less verbose.'
complete -c nosetests -s c -l config --description 'Load configuration from config file(s).'
complete -c nosetests -s w -l where --description 'Look for tests in this directory.'
complete -c nosetests -l py3where --description 'Look for tests in this directory under Python 3. x.'
complete -c nosetests -s m -l match -l testmatch --description 'Files, directories, function names, and class n… [See Man Page]'
complete -c nosetests -l tests --description 'Run these tests (comma-separated list).'
complete -c nosetests -s l -l debug --description 'Activate debug logging for one or more systems.'
complete -c nosetests -l debug-log --description 'Log debug messages to this file (default: sys. stderr).'
complete -c nosetests -l logging-config -l log-config --description 'Load logging config from this file -- bypasses … [See Man Page]'
complete -c nosetests -s I -l ignore-files --description 'Completely ignore any file that matches this re… [See Man Page]'
complete -c nosetests -s e -l exclude --description 'Don\'t run tests that match regular expression [NOSE_EXCLUDE].'
complete -c nosetests -s i -l include --description 'This regular expression will be applied to file… [See Man Page]'
complete -c nosetests -s x -l stop --description 'Stop running tests after the first error or failure.'
complete -c nosetests -s P -l no-path-adjustment --description 'Don\'t make any changes to sys.'
complete -c nosetests -l exe --description 'Look for tests in python modules that are executable.'
complete -c nosetests -l noexe --description 'DO NOT look for tests in python modules that are executable.'
complete -c nosetests -l traverse-namespace --description 'Traverse through all path entries of a namespace package.'
complete -c nosetests -l first-package-wins -l first-pkg-wins -l 1st-pkg-wins --description 'nose\'s importer will normally evict a package from sys.'
complete -c nosetests -l no-byte-compile --description 'Prevent nose from byte-compiling the source into .'
complete -c nosetests -s a -l attr --description 'Run only tests that have attributes specified b… [See Man Page]'
complete -c nosetests -s A -l eval-attr --description 'Run only tests for whose attributes the Python … [See Man Page]'
complete -c nosetests -s s -l nocapture --description 'Don\'t capture stdout (any stdout output will be… [See Man Page]'
complete -c nosetests -l nologcapture --description 'Disable logging capture plugin.'
complete -c nosetests -l logging-format --description 'Specify custom format to print statements.'
complete -c nosetests -l logging-datefmt --description 'Specify custom date/time format to print statements.'
complete -c nosetests -l logging-filter --description 'Specify which statements to filter in/out.'
complete -c nosetests -l logging-clear-handlers --description 'Clear all other logging handlers.'
complete -c nosetests -l logging-level --description 'Set the log level to capture.'
complete -c nosetests -l with-coverage --description 'Enable plugin Coverage:  Activate a coverage re… [See Man Page]'
complete -c nosetests -l cover-package --description 'Restrict coverage output to selected packages [… [See Man Page]'
complete -c nosetests -l cover-erase --description 'Erase previously collected coverage statistics before run.'
complete -c nosetests -l cover-tests --description 'Include test modules in coverage report [NOSE_COVER_TESTS].'
complete -c nosetests -l cover-min-percentage --description 'Minimum percentage of coverage for tests to pas… [See Man Page]'
complete -c nosetests -l cover-inclusive --description 'Include all python files under working director… [See Man Page]'
complete -c nosetests -l cover-html --description 'Produce HTML coverage information.'
complete -c nosetests -l cover-html-dir --description 'Produce HTML coverage information in dir.'
complete -c nosetests -l cover-branches --description 'Include branch coverage in coverage report [NOS… [See Man Page]'
complete -c nosetests -l cover-xml --description 'Produce XML coverage information.'
complete -c nosetests -l cover-xml-file --description 'Produce XML coverage information in file.'
complete -c nosetests -l pdb --description 'Drop into debugger on failures or errors.'
complete -c nosetests -l pdb-failures --description 'Drop into debugger on failures.'
complete -c nosetests -l pdb-errors --description 'Drop into debugger on errors.'
complete -c nosetests -l no-deprecated --description 'Disable special handling of DeprecatedTest exceptions.'
complete -c nosetests -l with-doctest --description 'Enable plugin Doctest:  Activate doctest plugin… [See Man Page]'
complete -c nosetests -l doctest-tests --description 'Also look for doctests in test modules.'
complete -c nosetests -l doctest-extension --description 'Also look for doctests in files with this exten… [See Man Page]'
complete -c nosetests -l doctest-result-variable --description 'Change the variable name set to the result of t… [See Man Page]'
complete -c nosetests -l doctest-fixtures --description 'Find fixtures for a doctest file in module with… [See Man Page]'
complete -c nosetests -l doctest-options --description 'Specify options to pass to doctest.  Eg.'
complete -c nosetests -l with-isolation --description 'Enable plugin IsolationPlugin:  Activate the is… [See Man Page]'
complete -c nosetests -s d -l detailed-errors -l failure-detail --description 'Add detail to error output by attempting to eva… [See Man Page]'
complete -c nosetests -l with-profile --description 'Enable plugin Profile:  Use this plugin to run … [See Man Page]'
complete -c nosetests -l profile-sort --description 'Set sort order for profiler output.'
complete -c nosetests -l profile-stats-file --description 'Profiler stats file; default is a new temp file on each run.'
complete -c nosetests -l profile-restrict --description 'Restrict profiler output.  See help for pstats.'
complete -c nosetests -l no-skip --description 'Disable special handling of SkipTest exceptions.'
complete -c nosetests -l with-id --description 'Enable plugin TestId:  Activate to add a test i… [See Man Page]'
complete -c nosetests -l id-file --description 'Store test ids found in test runs in this file.'
complete -c nosetests -l failed --description 'Run the tests that failed in the last test run.'
complete -c nosetests -l processes --description 'Spread test run among this many processes.'
complete -c nosetests -l process-timeout --description 'Set timeout for return of results from each tes… [See Man Page]'
complete -c nosetests -l process-restartworker --description 'If set, will restart each worker process once t… [See Man Page]'
complete -c nosetests -l with-xunit --description 'Enable plugin Xunit: This plugin provides test … [See Man Page]'
complete -c nosetests -l xunit-file --description 'Path to xml file to store the xunit report in.'
complete -c nosetests -l xunit-testsuite-name --description 'Name of the testsuite in the xunit xml, generated by plugin.'
complete -c nosetests -l all-modules --description 'Enable plugin AllModules: Collect tests from al… [See Man Page]'
complete -c nosetests -l collect-only --description 'Enable collect-only:  Collect and output test n… [See Man Page]'

