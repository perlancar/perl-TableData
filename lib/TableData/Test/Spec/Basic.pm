package TableData::Test::Spec::Basic;

use strict;
use warnings;

use Role::Tiny::With;

with 'TableDataRole::Spec::Basic';

# AUTHORITY
# DATE
# DIST
# VERSION

my $rows = [
    {a=>1, b=>2},
    {a=>3, b=>4},
    {a=>"5 2", b=>"6,2"},
];
my $columns = [qw/a b/];

sub new {
    my $class = shift;
    bless {pos=>0}, $class;
}

sub _rows {
    $rows;
}

sub reset_iterator {
    my $self = shift;
    $self->{pos} = 0;
}

sub get_iterator_pos {
    my $self = shift;
    $self->{pos};
}

sub has_next_item {
    my $self = shift;
    $self->{pos} < @$rows;
}

sub get_next_item {
    my $self = shift;
    die "StopIteration" if $self->{pos} >= @$rows;
    my $row_hashref = $rows->[ $self->{pos}++ ];
    [map {$row_hashref->{$_}} @$columns];
}

sub get_next_row_hashref {
    my $self = shift;
    die "StopIteration" if $self->{pos} >= @$rows;
    $rows->[ $self->{pos}++ ];
}

sub get_row_hashref {
    my $self = shift;
    return unless $rows->[ $self->{index} ];
    $rows->[ $self->{index}++ ];
}

sub get_column_count {
    my $self = shift;
    scalar(keys %{$rows->[0]});
}

sub get_column_names {
    my $self = shift;
    my @names = sort keys %{$rows->[0]};
    wantarray ? @names : \@names;
}

1;

# ABSTRACT: A test table data

=for Pod::Coverage ^(.+)$
