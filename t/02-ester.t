use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP::Ester' );
}


my $cvtr = Chemistry::RECAP::Ester->new();
isa_ok($cvtr,'Chemistry::RECAP::Ester','Amide instance');
can_ok($cvtr,'cleave');

{
  my $mol = Chemistry::Mol->parse('CC(=O)OC estertest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Estertest');
  aromatize_mol($mol);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol);

  is($mols[0],"CC=O","ester carbonyl");
  is($mols[1],"CO", "ester alchol");
}
