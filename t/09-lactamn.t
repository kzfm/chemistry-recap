use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP::Lactamn' );
}


my $cvtr = Chemistry::RECAP::Lactamn->new();
isa_ok($cvtr,'Chemistry::RECAP::Lactamn','Lactamn instance');
can_ok($cvtr,'cleave');

{
  my $mol = Chemistry::Mol->parse('CC(C)(C)N1CCCCC1(=O) lactamntest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Lactamntest');
  aromatize_mol($mol);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol);

  is($mols[0],"CC(C)C", "tert buthyl");
  is($mols[1],"O=C1CCCCN1","lactam");
}
