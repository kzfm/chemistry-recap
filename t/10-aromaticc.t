use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP::Aromaticc' );
}


my $cvtr = Chemistry::RECAP::Aromaticc->new();
isa_ok($cvtr,'Chemistry::RECAP::Aromaticc','Aromaticc instance');
can_ok($cvtr,'cleave');

{
  my $mol = Chemistry::Mol->parse('c1ccccc1-c2ccccc2 aromaticctest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Aromaticctest');
  aromatize_mol($mol);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol);

  is($mols[0],"c1ccccc1", "benzene");
  is($mols[1],"c1ccccc1", "benzene");
}
