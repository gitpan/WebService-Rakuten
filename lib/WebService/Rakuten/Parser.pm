package WebService::Rakuten::Parser;

use strict;
use warnings;

use Data::Page;
use XML::Simple;
$XML::Simple::PREFERRED_PARSER = 'XML::Parser';

use WebService::Rakuten::ItemResult;
use WebService::Rakuten::Item;
use WebService::Rakuten::GenreResult;
use WebService::Rakuten::Genre;

=head1 NAME

WebService::Rakuten::Parser - Class methods for parsing Rakuten WebService's response

=head1 METHODS

=head2 parse_items

Parse ItemSearch Response

=cut

sub parse_items {
    my ($class, $res) = @_;
    my $rs;

    if ($res->is_error) {
        $rs = WebService::Rakuten::ItemResult->new( {
                  status         => 'AgentError',
                  status_message => $res->status_line,
              } );
    } else {
        my $parser = XML::Simple->new(ForceArray => [qw/Item/]);
        my $data = $parser->XMLin($res->content);
        $rs = WebService::Rakuten::ItemResult->new( {
                  status         => $data->{Header}->{Status},
                  status_message => $data->{Header}->{StatusMsg},
              } );
        if ($rs->status eq 'Success') {
            my @items = map WebService::Rakuten::Item->new($_), 
                @{ $data->{Body}->{ItemSearch}->{Items}->{Item} };
            $rs->pager( Data::Page->new(
                             $data->{Body}->{ItemSearch}->{count},
                             $data->{Body}->{ItemSearch}->{hits},
                             $data->{Body}->{ItemSearch}->{page}
                      ) ),
            $rs->items( \@items ),
        }
    }

    return $rs;
}

=head2 parse_genres

Parse GenreSearch Response

=cut

sub parse_genres {
    my ($class, $res) = @_;
    my $rs;

    if ($res->is_error) {
        $rs = WebService::Rakuten::GenreResult->new( {
                  status         => 'AgentError',
                  status_message => $res->status_line,
              } );
    } else {
        my $parser = XML::Simple->new(ForceArray => [qw/parent child/]);
        my $data = $parser->XMLin($res->content);
        $rs = WebService::Rakuten::GenreResult->new( {
                  status         => $data->{Header}->{Status},
                  status_message => $data->{Header}->{StatusMsg},
              } );
        if ($rs->status eq 'Success') {
            $rs->current( WebService::Rakuten::Genre->new(
                    $data->{Body}->{GenreSearch}->{current}) );
            for (qw/parent child/) {
                 $rs->$_( map WebService::Rakuten::Genre->new($_),
                    @{ $data->{Body}->{GenreSearch}->{$_} } );
            }
        }
    }

    return $rs;
}

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
