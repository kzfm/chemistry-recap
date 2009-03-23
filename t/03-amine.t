use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP::Amine' );
}


my $cvtr = Chemistry::RECAP::Amine->new();
isa_ok($cvtr,'Chemistry::RECAP::Amine','Amide instance');
can_ok($cvtr,'cleave');

{
  my $mol = Chemistry::Mol->parse('CN(CC)CCC aminetest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Aminetest');
  aromatize_mol($mol);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol);

  is($mols[0],"C","amine first");
  is($mols[1],"CC", "amine second");
  is($mols[2],"CCC", "amine third");
}
