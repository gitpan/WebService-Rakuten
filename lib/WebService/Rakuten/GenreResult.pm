package WebService::Rakuten::GenreResult;

use strict;
use warnings;

use base qw/Class::Accessor::Fast/;
__PACKAGE__->mk_accessors(qw/status status_message parent current child/);

=head1 NAME

WebService::Rakuten::GenreResult - WebService::Rakuten data class

=head1 ACCESSORS

  status
  status_message
  parent
  current
  child

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
