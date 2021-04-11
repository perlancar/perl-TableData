#!perl

use 5.010001;
use strict;
use warnings;
use Test::More 0.98;

use Role::Tiny;
use TableData::Test::Spec::Basic;

my $table = TableData::Test::Spec::Basic->new;
Role::Tiny->apply_roles_to_object($table, 'TableDataRole::AsCSV');

subtest "as_csv" => sub {
    is($table->as_csv, <<'_');
a,b
1,2
3,4
"5 2","6,2"
_
};

done_testing;
