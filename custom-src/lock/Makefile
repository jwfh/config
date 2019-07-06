all: lock.sh
	test -f `pwd`/../../bin/lock || ln -s `pwd`/lock.sh `pwd`/../../bin/lock

clean:
	rm -f `pwd`/../../bin/lock
