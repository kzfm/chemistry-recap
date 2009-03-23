package Chemistry::RECAP::Urea;

use warnings;
use strict;
use Chemistry::Ring 'aromatize_mol';
use Chemistry::File::SMARTS;

=head1 NAME

Chemistry::RECAP::Urea - The great new Chemistry::RECAP::Urea!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Chemistry::RECAP::Urea;

    my $foo = Chemistry::RECAP::Urea->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 new

=cut

sub new {
  my $class    = shift;
  my $self = {};
  my $SMARTS = 'NC(=O)N';
  $self->{pattern} = Chemistry::Pattern->parse($SMARTS, format => 'smarts');
  return bless $self, $class;
}


=head2 cleave

=cut

sub cleave {
  my ($self,@fragments) = @_;
  my @new_fragments;

  for my $fragment (@fragments) {
    aromatize_mol($fragment);
    while ($self->{pattern}->match($fragment)){
      my @fg = $self->{pattern}->atom_map;
      my @bd = $self->{pattern}->bond_map;
      $fg[1]->delete;
      $fg[2]->delete;
      $fg[0]->implicit_hydrogens($fg[0]->implicit_hydrogens()+1);
      $fg[3]->implicit_hydrogens($fg[3]->implicit_hydrogens()+1);
    }
    push @new_fragments , $fragment->separate;
  }
  return @new_fragments;
}

=head1 AUTHOR

kzfm, C<< <kerolinq at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-chemistry-recap at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Chemistry-RECAP>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Chemistry::RECAP::Urea


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

1; # End of Chemistry::RECAP::Urea
