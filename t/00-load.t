#!perl -T

use Test::More tests => 12;

BEGIN {
	use_ok( 'Chemistry::RECAP' );
	use_ok( 'Chemistry::RECAP::Amide' );
	use_ok( 'Chemistry::RECAP::Ester' );
	use_ok( 'Chemistry::RECAP::Amine' );
	use_ok( 'Chemistry::RECAP::Urea' );
	use_ok( 'Chemistry::RECAP::Ether' );
	use_ok( 'Chemistry::RECAP::Olefin' );
	use_ok( 'Chemistry::RECAP::Qnitrogen' );
	use_ok( 'Chemistry::RECAP::Aromaticn' );
	use_ok( 'Chemistry::RECAP::Lactamn' );
	use_ok( 'Chemistry::RECAP::Aromaticc' );
	use_ok( 'Chemistry::RECAP::Sulphonamide' );
}

diag( "Testing Chemistry::RECAP $Chemistry::RECAP::VERSION, Perl $], $^X" );
