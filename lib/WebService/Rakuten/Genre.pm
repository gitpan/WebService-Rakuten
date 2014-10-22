package WebService::Rakuten::Genre;

use strict;
use warnings;

use base qw/Class::Accessor::Fast/;
__PACKAGE__->mk_accessors(qw/genreId genreName genreLevel/);

=head1 NAME

WebService::Rakuten::Genre - WebService::Rakuten data class

=head1 ACCESSORS

  genreId
  genreName
  genreLevel

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

1;
