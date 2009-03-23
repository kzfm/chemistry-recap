package Chemistry::RECAP;

use warnings;
use strict;
use UNIVERSAL::require;
use Chemistry::File::SMILES;
use Chemistry::Ring 'aromatize_mol';

use Chemistry::RECAP::Amide;
use Chemistry::RECAP::Amine;
use Chemistry::RECAP::Aromaticc;
use Chemistry::RECAP::Aromaticn;
use Chemistry::RECAP::Ester;
use Chemistry::RECAP::Ether;
use Chemistry::RECAP::Lactamn;
use Chemistry::RECAP::Olefin;
use Chemistry::RECAP::Qnitrogen;
use Chemistry::RECAP::Sulphonamide;
use Chemistry::RECAP::Urea;

our @RECAP_rules = qw/Amide Amine Aromaticc Aromaticn Ester Ether Lactamn Olefin Qnitrogen Sulphonamide Urea/;


=head1 NAME

Chemistry::RECAP - Cleave compound RECAP Rules

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Chemistry::RECAP;

    my $recap = Chemistry::RECAP->new();
    $recap->cleave("smiles")

=head1 FUNCTIONS

=head2 new

=cut

sub new {
  my $class = shift;
  my $self = {};
  for my $type (@RECAP_rules){
    my $class = 'Chemistry::RECAP::' . $type;
    my $obj = $class->new();
    push @{$self->{cleavages}}, $obj;
  }
  return bless $self, $class;
}

=head2 cleave

=cut

sub cleave {
  my @fragments;
  my ($self,$smiles) = @_;
  die "SMILES not found" if ($smiles eq "");

  my $compound = Chemistry::Mol->parse($smiles, format => 'smiles');
  push @fragments, $compound;
  for my $cleavage_type (@{$self->{cleavages}}) {
    @fragments = $cleavage_type->cleave(@fragments);
  }
  return map {$_->print(format => 'smiles', unique => 1, name => 0)} @fragments;
}

=head1 AUTHOR

kzfm, C<< <kerolinq at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-chemistry-recap at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Chemistry-RECAP>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Chemistry::RECAP


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Chemistry-RECAP>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Chemistry-RECAP>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Chemistry-RECAP>

=item * Search CPAN

L<http://search.cpan.org/dist/Chemistry-RECAP/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 kzfm, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Chemistry::RECAP
