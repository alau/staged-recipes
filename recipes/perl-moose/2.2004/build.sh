#!/bin/bash

#cpanm --installdeps .
perl -V
which gcc

cpanm ExtUtils::MakeMaker
cpanm --installdeps .

# If it has Build.PL use that, otherwise use Makefile.PL

if [ -f Build.PL ]; then
    perl Build.PL
    perl ./Build
    perl ./Build test
    # Make sure this goes in site
    perl ./Build install --installdirs site
elif [ -f Makefile.PL ]; then
    # Make sure this goes in site
    perl Makefile.PL INSTALLDIRS=site
    cat Makefile
    make
    make test
    make install
else
    echo 'Unable to find Build.PL or Makefile.PL. You need to modify build.sh.'
    exit 1
fi
