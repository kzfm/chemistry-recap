use Test::More 'no_plan';
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

BEGIN {
        use_ok( 'Chemistry::RECAP::Amide' );
}


my $cvtr = Chemistry::RECAP::Amide->new();
isa_ok($cvtr,'Chemistry::RECAP::Amide','Amide instance');
can_ok($cvtr,'cleave');

{
  my $mol = Chemistry::Mol->parse('CC(=O)NC amidetest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Amidetest');
  aromatize_mol($mol);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol);

  is($mols[0],"CC=O","amide carbonyl");
  is($mols[1],"CN", "amide amine");
}

{
  my $mol = Chemistry::Mol->parse('CC(=O)NC amidetest', format => 'smiles');
  isa_ok($mol,'Chemistry::Mol','Amidetest');
  aromatize_mol($mol);

  my $mol2 = Chemistry::Mol->parse('CC(=O)NCCCC(=O)NCCl amidetest2', format => 'smiles');
  isa_ok($mol2,'Chemistry::Mol','Amidetest');
  aromatize_mol($mol2);

  my @mols = map {$_->print(format => 'smiles', unique => 1, name => 0)} $cvtr->cleave($mol,$mol2);

  #  warn @mols;
  is($mols[0],"CC=O","amide carbonyl");
  is($mols[1],"CN", "amide amine");
  is($mols[2],"CC=O", "amide amine");
  is($mols[3],"NCCCC=O", "amide amine");
  is($mols[4],"NCCl", "amide amine");

}