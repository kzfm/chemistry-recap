use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP::Urea' );
}


my $cvtr = Chemistry::RECAP::Urea->new();
isa_ok($cvtr,'Chemistry::RECAP::Urea','Urea instance');
can_ok($cvtr,'cleave');

{
  my $mol = Chemistry::Mol->parse('CN(C)C(=O)N(CCl)C ureatest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Ureatest');
  aromatize_mol($mol);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol);

  is($mols[0],"CNC","urea left");
  is($mols[1],"CNCCl", "urea right");
}
