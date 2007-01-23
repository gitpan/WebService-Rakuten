use inc::Module::Install;
name 'WebService-Rakuten';
all_from 'lib/WebService/Rakuten.pm';

requires 'Class::Accessor::Fast';
requires 'Carp';
requires 'URI';
requires 'LWP';
requires 'Readonly';
requires 'XML::Simple';
requires 'Data::Page';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
