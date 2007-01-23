package WebService::Rakuten;
use strict;
use warnings;

our $VERSION = '0.02';

use Carp;
use URI;
use LWP::UserAgent;
use Readonly;
use WebService::Rakuten::Parser;

Readonly my $API_VERSION => '2006-12-26';
Readonly my $ENDPOINT    => 'http://api.rakuten.co.jp/rws/1.1/rest';

=head1 NAME

WebService::Rakuten - A Perl interface to the Rakuten WebService API

=head1 SYNOPSIS

  use WebService::Rakuten;

  my $api = WebService::Rakuten->new(
      dev_id => 'YOUR DEVELOPER ID',
      aff_id => 'YOUR AFFILIATE ID',
  );

  # Item Search
  my $rs = $api->item_search(
      'Wii',
      {
          shopCode => 'xyz',
          hits     => 30,
          page     => 1,
          sort     => '-itemPrice',
      }
  );

  if ($res->status eq 'Success') {
      for (@{ $rs->items }) {
          print $_->itemName;
          print $_->itemCode;
          print $_->itemPrice;
          print $_->itemCaption;
          print $_->itemUrl;
          print $_->affiliateUrl;
          print $_->smallImageUrl;
          print $_->mediumImageUrl;
          print $_->availability;
          print $_->taxFlag;
          print $_->postageFlag;
          print $_->creditCardFlag;
          print $_->shopOfTheYearFlag;
          print $_->affiliateRate;
          print $_->startTime;
          print $_->endTime;
          print $_->reviewCount;
          print $_->reviewAverage;
          print $_->shopName;
          print $_->shopCode;
          print $_->shopUrl;
          print $_->genreId;
      }
  }

  # Genre Search
  $rs = $api->genre_search(
      0,
      { genrePath => 0 }
  );

  if ($res->status eq 'Success') {
      for (@{ $rs->childs }) {
          print $_->genreId;
          print $_->genreName;
          print $_->genreLavel;
      }
  }

=head1 DESCRIPTION

WebService::Rakuten is a simple Perl interface to the Rakuten 
WebService API.

Rakuten Ichiba is the biggest online shopping mall in Japan. 
For details, see http://www.rakuten.co.jp/.

=head1 FUNCTIONS

=head2 new(dev_id => 'Developer ID', aff_id => 'Affiliate ID')

Returns an instance of this module. You must create an instace
before searching.

Developer ID required. If you have Affiliate ID, you can set 
affiliate link to products. 

=cut

sub new {
    my ($class, %options) = @_;
    croak 'Developer ID required.' unless $options{dev_id};
    my $ua = LWP::UserAgent->new();
    $ua->env_proxy;
    $ua->agent(join '/', __PACKAGE__, $VERSION);
    bless { %options, ua => $ua }, $class;
}

=head2 item_search($keyword, \%options)

Returns search results. Results is a 
WebService::Rakuten::ItemResult object. It's contains status,
pager and WebService::Rakuten::Item objects.

=cut

sub item_search {
    my ($self, $keyword, $options) = @_;
    croak 'Search keyword required.' unless $keyword;
    utf8::encode($keyword) if utf8::is_utf8($keyword);

    my $uri = URI->new($ENDPOINT);
    $uri->query_form(
        developerId => $self->{dev_id},
        affiliateId => $self->{aff_id},
        version     => $API_VERSION,
        operation   => 'ItemSearch',
        keyword     => $keyword,
        %$options
    );

    my $res = $self->{ua}->get($uri);

    WebService::Rakuten::Parser->parse_items($res);
}

=head2 genre_search($genre_id, \%options)

Returns genre search results. It's contains status and genre 
objects (parent/current/child).

=cut

sub genre_search {
    my ($self, $genre_id, $options) = @_;
    croak 'Genre ID required.' unless $genre_id;

    my $uri = URI->new($ENDPOINT);
    $uri->query_form(
        developerId => $self->{dev_id},
        affiliateId => $self->{aff_id},
        version     => $API_VERSION,
        operation   => 'GenreSearch',
        genreId     => $genre_id,
        %$options
    );

    my $res = $self->{ua}->get($uri);

    WebService::Rakuten::Parser->parse_genres($res);
}

=head1 SEE ALSO

=over

=item * http://webservice.rakuten.co.jp/

=back

=head1 AUTHOR

Hideaki Tanaka E<lt>tanakahda@gmail.comE<gt>

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

1;
