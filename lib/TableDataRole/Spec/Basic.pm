package TableDataRole::Spec::Basic;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;

requires 'new';

requires 'as_csv';
requires 'get_column_count';
requires 'get_column_names';
requires 'get_row_arrayref';
requires 'get_row_count';
requires 'get_row_hashref';
requires 'reset_iterator';

1;
# ABSTRACT: Required methods for all TableData::* modules

=head1 REQUIRED METHODS

=head2 new

Usage:

 my $table = TableData::Foo->new([ %args ]);

Constructor. Must accept a pair of argument names and values.

=head2 as_csv

Usage:

 my $csv = $table->as_csv;

Must return the whole table data as CSV (string). May reset the row iterator
(see L</get_row_arrayref> and L</reset_iterator>).

=head2 get_column_count

Usage:

 my $n = $table->get_column_count;

Must return the number of columns of the table.

=head2 get_column_names

Usage:

 my @colnames = $table->get_column_names;
 my $colnames = $table->get_column_names;

Must return a list (or arrayref) containing the names of columns, ordered. For
ease of use, when in list context the method must return a list, and in scalar
context must return an arrayref.

=head2 get_row_arrayref

Usage:

 my $arrayref = $table->get_row_arrayref;

Must return the next row of the table as arrayref: if called the first time,
must return the first row; then the second, and so on. Must return undef if
there are no more rows in the table.

Can be interspersed with L</get_row_hashref>. A call to either
C<get_row_arrayref> or C<get_row_hashref> move the internal row iterator.

Beware of methods that may reset the row iterator. For safety it is recommended
that you call L</reset_iterator> first, then get all the rows you want at one
go.

See also L</reset_iterator>.

=head2 get_row_count

Usage:

 my $count = $table->get_row_count;

Must return the number of data rows in the table. May reset the row iterator
(see L</get_row_arrayref> and L</reset_iterator>).

=head2 get_row_hashref

Usage:

 my $hashref = $table->get_row_hashref;

Just like L</get_row_arrayref>, but must return the row as hashref instead of
arrayref.

See also L</reset_iterator>.

=head2 reset_iterator

Usage:

 $table->reset_iterator;

Can be used to reset the iterator so the next call to L</get_row_arrayref> or
L</get_row_hashref>.
