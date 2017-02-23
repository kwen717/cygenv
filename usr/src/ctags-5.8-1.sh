#!/bin/sh
set -x

if ! tar cjf ctags-5.8-1-src.tar.bz2 ctags-5.8-1 ctags-5.8-1.sh README ; then exit 1 ; fi
cd ctags-5.8-1
./configure CC=gcc-4 		--enable-etags --disable-external-sort --prefix=/usr 		--enable-tmpdir=/tmp --mandir='$(prefix)/share/man' &&
	make &&
	make install prefix=../usr ||
	exit 1

cd ..
strip usr/bin/*.exe

DOCDIR=usr/share/doc/ctags-5.8
mkdir -p $DOCDIR $DOCDIR/../Cygwin
set +x
for f in COPYING *.html FAQ INSTALL* NEWS README
do
	cp ctags-5.8-1/$f $DOCDIR
done
set -x
cp README $DOCDIR/../Cygwin/ctags-5.8.README

find usr \! -type d | tar cjfT ctags-5.8-1.tar.bz2 -
rm -rf usr
ls -l ctags-5.8-1*.bz2
