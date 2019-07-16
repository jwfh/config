all: andersonLectures

andersonLectures: andersonLectures.fish
	test -f `pwd`/../../bin/andersonLectures || ln -s `pwd`/andersonLectures.fish `pwd`/../../bin/andersonLectures
	chmod u+x `pwd`/../../bin/andersonLectures
