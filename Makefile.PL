use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Chemistry::RECAP',
    AUTHOR              => 'kzfm <kerolinq@gmail.com>',
    VERSION_FROM        => 'lib/Chemistry/RECAP.pm',
    ABSTRACT_FROM       => 'lib/Chemistry/RECAP.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'UNIVERSAL::require' => 0,
        'Chemistry::Ring' => 0,
        'Chemistry::File::SMARTS' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Chemistry-RECAP-*' },
);
