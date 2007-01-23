package WebService::Rakuten::Item;

use strict;
use warnings;

use URI;
use base qw/Class::Accessor::Fast/;

my @Fields = qw/itemName itemCode itemPrice itemCaption itemUrl affiliateUrl smallImageUrl mediumImageUrl availability taxFlag postageFlag creditCardFlag shopOfTheYearFlag affiliateRate startTime endTime reviewCount reviewAverage shopName shopCode shopUrl genreId/;
__PACKAGE__->mk_accessors(@Fields);

=head1 NAME

WebService::Rakuten::Item - WebService::Rakuten data class

=head1 ACCESSORS

  itemName
  itemCode
  itemPrice
  itemCaption
  itemUrl
  affiliateUrl
  smallImageUrl
  mediumImageUrl
  availability
  taxFlag
  postageFlag
  creditCardFlag
  shopOfTheYearFlag
  affiliateRate
  startTime
  endTime
  reviewCount
  reviewAverage
  shopName
  shopCode
  shopUrl
  genreId

=head1 SEE ALSO

L<WebService::Rakuten>

=head1 AUTHOR

Hideaki Tanaka E<lt>tanakahda@gmail.comE<gt>

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

=head1 METHODS

=head2 new

=cut

sub new {
    my $class = shift;
    my $self  = bless $class->SUPER::new(@_), $class;
    $self->init(@_);
    $self;
}

=head2 init

=cut

sub init {
    my $self = shift;
    $self->$_( URI->new($self->$_) ) for grep { m/Url$/ } @Fields;
}

1;
