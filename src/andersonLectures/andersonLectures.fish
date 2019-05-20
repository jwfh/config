#!/usr/bin/env fish

set binaries \
	fish \
	sed \
	curl \
	grep \
	gs \
	pdflatex \
	latex \
	pdfnup \
	node \
	npm \
	decktape \
	remarkjs-pdf \

set INFO '\033[1;33mINFORMATION:\033[0m'
set WARN '\033[0;31mWARNING:\033[0m'
set HELP '
Description
-----------
andersonLectures is a Fish script designed to retrieve RemarkJS lectures from 
the Internet and convert them to PDF using the remarkjs-pdf NPM package, as 
well as a number of Unix utlities such as cURL, sed, and grep. To create merged
and n-up PDFs, the gs and pdfnup programs are used. This requires that 
Ghostscript and the full TeXLive/MacTeX suite be installed on your machine.

Command-line options:
--------------------
andersonLectures takes ONE positional command-line argument: the root URI of the
lectures. For example:

    andersonLectures https://www.engr.mun.ca/~anderson/teaching/7864/lecture/

The trailing forward slash is optional. The script then assumes that lectures
may be found at $ROOT_URI/{[0],1,2,3,...}/index.html.
'

function preflight --description 'Makes a couple of pre-run checks'
	if test (count $argv) -ne 0
		printf 'preflight takes no arguments\n'
		exit 1
	end 
	clear
	for binary in $binaries
		if not command -sq $binary
			printf "$WARN `%s` is not installed in $PATH. Please install it and run again.\n" $binary
			exit 1
		end
	end
	if not uname -a | grep 'Darwin\|FreeBSD' >/dev/null
		printf "$WARN This script has only been verified to work on Darwin and FreeBSD. Usage\non other operating systems may not work as expected.\n\n"
	end
	printf "$INFO %s running on %s\n" (status -f) (uname -s)
end

function parseArgs --description 'Parses $argv for command-line arguments and sets environment accordingly.'
	for i in (seq 1 (count $argv))	
		set argi $argv[$i]
		switch $argi
			case '--help' '-h'
				echo $HELP
				exit 0
			case '*'
				if string match -q -r -- '^https?://.*' $argi
					if test -n "$ROOT_URI"
						printf "$WARN andersonLectures only accepts one URI argument of the form\n'^https?:\/\/[a-zA-Z0-9\-\.\/]*\/?\$'. You provided two or more.\n"
						exit 1
					end 
					set -g ROOT_URI $argi
				end
		end 
	end 

	# Make sure $ROOT_URI is defined... this is really the only argument we need to make sure we got
	if test -z "$ROOT_URI"
		printf "$WARN andersonLectures requires a URI of the form '^https?:\/\/[a-zA-Z0-9\-\.\/]*\/?\$'.\nSee `andersonLectures --help` for more information.\n"
		exit 1
	end
end 

function fetchImages --description 'Uses cURL to download all images for lecture number $argv[1]'
	set argc (count $argv)
	if test $argc -ne 1
		printf "$WARN fetchImages takes exactly two argument\n\nUsage: fetchImages <lecture num>\n"
		exit 1
	end 
	for lec in (seq 1 $argc)
		set argi $argv[$lec]
		if not test "$argi" -eq "$argi" 2> /dev/null
			printf 'Argument #%d ("%s") is not a number.\n' $lec $argi
			exit 1
		end
	end
	if test ! -e $argv[1]/index.html 
		printf "$WARN Lecture #%s does not exist on the file system.\n\n" $argv[1]
		exit 1
	end 
	test -d images; or mkdir images
	printf "$INFO Fetching images for lecture %s...\n" $argv[1]
	for image in (grep -n $argv[1]/index.html -e 'img' | sed 's/^[0-9]*\/index\.html:[0-9]*://' | sed 's/^.*img src=&#34;//;s/&#34;.*$//')
		set leaf (echo "$image" | sed 's/^.*\///')
		if string match -r -q -- '^https?://.*' "$image"
			# HTTP/HTTPS URI
			curl -Lk -o "images/$leaf" "$image"
			sed -i -e "s/$image/\.\.\/images/$leaf" $argv[1]/index.html
		else 
			# Relative (../foo.jpg) URI
		end 
	end
end 

function fetchLecture --description 'Uses cURL to download lecture number $argv[1].'
	set argc (count $argv)
	if test $argc -ne 1
		printf "$WARN fetchLecture takes exactly one argument\n\nUsage: fetchLecture <num>\n"
		exit 1
	end 	
	for lec in (seq 1 $argc)
		set argi $argv[$lec]
		if not test "$argi" -eq "$argi" 2> /dev/null
			printf 'Argument #%d ("%s") is not a number.\n' $lec $argi
			exit 1
		end
	end
	set lec $argv[1]
	if test (curl --output /dev/null --silent --head --write-out "%{http_code}\n" $ROOT_URI/$argv[1]/index.html ^/dev/null) -eq 200
		printf "$INFO Fetching lecture %s from %s...\n" $argv[1] (echo $ROOT_URI | sed -E 's/https?:\/\/[a-zA-Z0-9\.\-]*//')
		test -d "$lec"; or mkdir "$lec"
		curl -Lk -o "$lec/index.html" "$ROOT_URI/$lec/index.html" ^/dev/null
		fetchImages $argv
	else 
		false
	end
end 

function convertLecture --description 'Uses NPM package decktape to convert remark to PDF'
	set argc (count $argv)
	if test $argc -ne 1
		printf "$WARN convertLecture takes exactly one argument\n\nUsage: convertLecture <num>\n"
		exit 1
	end 	
	for lec in (seq 1 $argc)
		set argi $argv[$lec]
		if not test "$argi" -eq "$argi" 2> /dev/null
			printf 'Argument #%d ("%s") is not a number.\n' $lec $argi
			exit 1
		end
	end
	set lec $argv[1]
	if test (curl --output /dev/null --silent --head --write-out "%{http_code}\n" $ROOT_URI/$argv[1]/index.html ^/dev/null) -eq 200
		printf "$INFO Converting lecture %s from %s to PDF...\n$INFO This may take a while. Please be patient." $argv[1] (echo $ROOT_URI | sed -E 's/https?:\/\/[a-zA-Z0-9\.\-]*//')
		test -d "$lec"; or mkdir "$lec"
		decktape remark "$ROOT_URI/$lec/index.html" "$lec/notes.pdf" >/dev/null 

	end 
end 

function fetchAllLectures --description 'Iterates through all available lectures and retrieves each one.'
	if test (count $argv) -ne 0
		printf "$WARN fetchAllLectures takes no arguments.\n"
		exit 1
	end
	set lec 0
	fetchLecture $lec
	set lec (math $lec + 1)
	fetchLecture $lec
	while test $status -eq 0
		set lec (math $lec + 1)
		fetchLecture $lec
		convertLecture $lec
	end
end 

function pdfnumpages --description 'Gets number of pages in PDF file passed as argument'
	if test (count $argv) -ne 1
		printf "$WARN pdfnumpages takes exactly one argument\n\nUsage: pdfnumpages <pdf-file>\n"
		exit 1
	end 
	pdfinfo  $argv | grep Pages | awk '{ print $2 }'
end

function htmltopdf --description 'Uses Node to create a PDF from HTML file containing a RemarkJS slideshow.'
	if test (count $argv) -ne 2
		printf "$WARN htmltopdf takes exactly one argument\n\nUsage: htmltopdf <html-file> <pdf-file>\n"
		exit 1
	end 
	remarkjs-pdf $argv[1] $argv[2] >/dev/null 2>&1
end

function rmlastpage --description 'Removes the last page of PDF $argv[1] and saves the resulting file as $argv[2].'
	if test (count $argv) -ne 2
		printf "$WARN rmlastpage takes exactly two arguments\n\nUsage: rmlastpage <html-file> <pdf-file>\n"
		exit 1
	end 
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
		-dFirstPage=1 \
		-dLastPage=(math (pdfnumpages  $argv[1])-1) \
		-sOutputFile=$argv[2] $argv[1] \
		>/dev/null 2>&1
end

function pdfmerge --description 'Merges PDFs $argv[2:] and saves the resultant file as $argv[1].'
	if test (count $argv) -le 2
		printf "$WARN pdfmerge takes at least three argument\n\nUsage: pdfmerge <out-file> <pdf-file-1> ... <pdf-file-n>\n"
		exit 1
	end 
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
		-sOutputFile=$argv[1] \
		$argv[2..-1] \
		>/dev/null 2>&1
end

function twoperpage --description 'Uses pdfnup(1) to export PDF file $argv[1] with two slides per page. Optionally can save output in $argv[2].'
	if test (count $argv) -ne 1; and test (count $argv) -ne 2
		printf "$WARN twoperpage takes exactly one or two argument(s)\n\nUsage: twoperpage <pdf-file> [<out-dir>]\n"
		exit 1
	end 
	if test (count $argv) -eq 1
		pdfnup --nup '1x2' --no-landscape --paper 'letter' \
			--preamble '\usepackage{geometry}\geometry{margin=0.25in}' \
			$argv[1] \
			>/dev/null 2>&1
	else 
		pdfnup --nup '1x2' --no-landscape --paper 'letter' \
			--preamble '\usepackage{geometry}\geometry{margin=0.25in}' \
			-o $argv[2] \
			$argv[1] \
			>/dev/null 2>&1
	end
end

function combineLectures --description '\
	Combines PDF notes for lectures $argv[1] to $argv[2]. 
	If PDFs do not exist for each lecture, but the HTML version of the notes does exist, 
	remarkjs-pdf will be called to perform the conversion.'
	set argc (count $argv)
	if test $argc -ne 2
		printf "$WARN Exactly two arguments are required.\n\nUsage: combineLectures <first-lecture> <last-lecture>\n"
		exit 1
	end
	for lec in (seq 1 $argc)
		set argi $argv[$lec]
		if not test "$argi" -eq "$argi" 2> /dev/null
			printf 'Argument #%d ("%s") is not a number.\n' $lec $argi
			exit 1
		end
	end
	if test $argv[1] -ge $argv[2]
		printf 'Argument #1 must be less than argument #2.\n'
		exit 1
	end 
	set first $argv[1]
	set last $argv[2]

	# Check that all the required files exist and if not, attempt to create them
	if not test -d .combine-tmp 
		mkdir .combine-tmp
	end 
	for lec in (seq $first $last)
		if not test -f .combine-tmp/$lec.pdf
			if not test -f Lecture\ $lec/notes.pdf
				if test -f Lecture\ $lec/index.html
					printf 'PDF file %s doesn\'t exist. Creating it now...\n' $lec/notes.pdf
					htmltopdf Lecture\ $lec/index.html Lecture\ $lec/notes.pdf 
					twoperpage Lecture\ $lec/notes.pdf Lecture\ $lec/
				else
					printf 'PDF file $s doesn\'t exist and no source HTML file was found.\n' Lecture\ $lec/notes.pdf
					exit 1
				end
			end
			printf 'Creating mergable PDF for lecture #%d...\n' $lec
			rmlastpage Lecture\ $lec/notes.pdf .combine-tmp/$lec.pdf
		end
	end
	printf 'Combining lectures %d through %d...\n' $first $last
	pdfmerge Lectures\ $first-$last.pdf .combine-tmp/{(seq $first $last | tr '\n' ',' | sed 's/,$//')}.pdf
	twoperpage Lectures\ $first-$last.pdf 
	rm -rf .combine-tmp
end 

parseArgs $argv
preflight

printf "$INFO Preflight checks passed. Downloading lectures from %s...\n" $ROOT_URI

fetchAllLectures
