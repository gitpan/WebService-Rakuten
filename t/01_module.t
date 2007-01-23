use strict;
use Test::More tests => 29;

use WebService::Rakuten;

my $api = WebService::Rakuten->new(
    dev_id => 'd7bf34c9fe6df9534d72d5dad30390f3',
    aff_id => '040405a8.e004a3bf.040405a9.b6f3879f',
);
ok $api;

my $result = $api->item_search('Wii');
ok $result->status;
isa_ok $result->pager, 'Data::Page';
isa_ok $result->items, 'ARRAY';
isa_ok $result->items->[0], 'WebService::Rakuten::Item';

ok $result->items->[0]->itemName;
ok $result->items->[0]->itemCode;
ok $result->items->[0]->itemPrice >= 0;
ok $result->items->[0]->itemCaption;
ok $result->items->[0]->itemUrl;
ok $result->items->[0]->affiliateUrl;
ok $result->items->[0]->smallImageUrl;
ok $result->items->[0]->mediumImageUrl;
ok $result->items->[0]->availability >= 0;
ok $result->items->[0]->taxFlag >= 0;
ok $result->items->[0]->postageFlag >= 0;
ok $result->items->[0]->creditCardFlag >= 0;
ok $result->items->[0]->shopOfTheYearFlag >= 0;
ok $result->items->[0]->affiliateRate >= 0;
ok $result->items->[0]->startTime;
ok $result->items->[0]->endTime;
ok $result->items->[0]->reviewCount >= 0;
ok $result->items->[0]->reviewAverage >= 0;
ok $result->items->[0]->shopName;
ok $result->items->[0]->shopCode;

my $genre = $api->genre_search(101205);
ok $genre->status;
ok $genre->parent;
ok $genre->current;
ok $genre->child;
