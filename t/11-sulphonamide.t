use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP::Sulphonamide' );
}


my $cvtr = Chemistry::RECAP::Sulphonamide->new();
isa_ok($cvtr,'Chemistry::RECAP::Sulphonamide','Sulphonamide instance');
can_ok($cvtr,'cleave');

{
  my $mol = Chemistry::Mol->parse('CN(C)S(=O)(=O)C sulphonamidetest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Sulphonamidetest');
  aromatize_mol($mol);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol);

  is($mols[0],"CNC", "left");
  is($mols[1],"CS(O)(=O)=O", "right");
}
