use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP' );
}


my $recap = Chemistry::RECAP->new();
isa_ok($recap,'Chemistry::RECAP','RECAP instance');
can_ok($recap,'cleave');

{

  my @mols = $recap->cleave("c1ccccc1-c2ccccc2CCCC(=O)NCCl");

  is($mols[0],"c1ccccc1", "benzene");
  is($mols[1],"O=CCCCc1ccccc1", "benzene");
  is($mols[2],"NCCl", "amine");
}
