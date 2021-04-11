package TableData::Test::Spec::Basic;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;

use Role::Tiny::With;

with 'TableDataRole::Spec::Basic';

my $rows = [
    {a=>1, b=>2},
    {a=>3, b=>4},
    {a=>"5 2", b=>"6,2"},
];

sub new {
    my $class = shift;
    bless {index=>0}, $class;
}

sub _rows {
    my $table = shift;
    $rows;
}

sub get_row_arrayref {
    my $self = shift;
    return undef unless $rows->[ $self->{index} ];
    my $hashref = $rows->[ $self->{index}++ ];
    [map {$hashref->{$_}} sort keys %$hashref];
}

sub get_row_hashref {
    my $self = shift;
    return undef unless $rows->[ $self->{index} ];
    $rows->[ $self->{index}++ ];
}

sub get_row_iterator_index {
    my $self = shift;
    $self->{index};
}

sub reset_row_iterator {
    my $self = shift;
    $self->{index} = 0;
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
