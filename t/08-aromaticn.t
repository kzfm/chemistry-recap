use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP::Aromaticn' );
}


my $cvtr = Chemistry::RECAP::Aromaticn->new();
isa_ok($cvtr,'Chemistry::RECAP::Aromaticn','Aromaticn instance');
can_ok($cvtr,'cleave');

{
  my $mol = Chemistry::Mol->parse('C1=NC=NN1C(C)(C)C aromaticntest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Aromaticntest');
  aromatize_mol($mol);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol);

  is($mols[0],"n1cncn1","triazole");
  is($mols[1],"CC(C)C", "tert buthyl");
}
