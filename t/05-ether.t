use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP::Ether' );
}


my $cvtr = Chemistry::RECAP::Ether->new();
isa_ok($cvtr,'Chemistry::RECAP::Ether','Amide instance');
can_ok($cvtr,'cleave');

{
  my $mol = Chemistry::Mol->parse('ClCOCC ethertest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Ethertest');
  aromatize_mol($mol);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol);

  is($mols[0],"CCl","ether_left");
  is($mols[1],"CC", "ether_right");
}
