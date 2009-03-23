use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP::Olefin' );
}


my $cvtr = Chemistry::RECAP::Olefin->new();
isa_ok($cvtr,'Chemistry::RECAP::Olefin','Amide instance');
can_ok($cvtr,'cleave');

{
  my $mol = Chemistry::Mol->parse('ClC(C)=C(Br)C olefintest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Olefintest');
  aromatize_mol($mol);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol);

  is($mols[0],"CCCl","olefin_left");
  is($mols[1],"CCBr", "olefin_right");
}
