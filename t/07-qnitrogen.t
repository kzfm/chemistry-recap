use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP::Qnitrogen' );
}


my $cvtr = Chemistry::RECAP::Qnitrogen->new();
isa_ok($cvtr,'Chemistry::RECAP::Qnitrogen','Qnitrogen instance');
can_ok($cvtr,'cleave');

{
  my $mol = Chemistry::Mol->parse('C[N+](CC)(CCC)CCCC qnitrogentest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Qnitrogentest');
  aromatize_mol($mol);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol);

  is($mols[0],"C","qnitrogen first");
  is($mols[1],"CC", "qnitrogen second");
  is($mols[2],"CCC", "qnitrogen third");
  is($mols[3],"CCCC", "qnitrogen forth");
}
