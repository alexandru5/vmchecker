# See LICENSE file for license details.
MAKEFLAGS += --no-print-directory

all:
	@echo " run make tester-dist or make storer-dist"


storer-dist:
	./bin/initialise_course.py storer

tester-dist:
	@bin/assert_python_modules_installed.py paramiko pyinotify
	./bin/initialise_course.py tester
	mkdir -p ./executor_jobs/

tester-install: tester-dist
	test -d /etc/init.d/    || mkdir /etc/init.d/
	test -d /etc/vmchecker/ || mkdir /etc/vmchecker/
	cp etc/init.d/vmchecker /etc/init.d/vmchecker
	cp etc/vmchecker/config.list /etc/vmchecker/config.list

storer-install: storer-dist
	test -d /etc/vmchecker  || mkdir /etc/vmchecker/
	cp etc/vmchecker/config.list /etc/vmchecker/config.list


clean:
	rm -f *~ */*~
	rm -f bin/*~ bin/*.pyc
	@for d in queue tmpunzip; do				\
		if [ -d $$d ]; then				\
			rmdir  --ignore-fail-on-non-empty $$d;	\
		fi;						\
	done;
