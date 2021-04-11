package TableDataRole::Spec::Seekable;

# AUTHORITY
# DATE
# DIST
# VERSION

use Role::Tiny;

requires 'set_row_iterator_index';

sub get_row_arrayref_at_index {
    my ($table, $index) = @_;
    $table->set_row_iterator_index($index);
    $table->get_row_arrayref;
}

sub get_row_hashref_at_index {
    my ($table, $index) = @_;
    $table->set_row_iterator_index($index);
    $table->get_row_hashref;
}

1;
# ABSTRACT: Required methods for seekable TableData::* modules

=head1 REQUIRED METHODS

=head2 set_row_iterator_index

Usage:

 $table->set_row_iterator_index($index);

C<$index> is a zero-based integer, where 0 refers to the first data row, 1 the
second, and so on. Negative index must also be supported, where -1 means the
last data row, -2 the second last, and so on.

Must die when seeking outside the range of data (e.g. there are only 5 data rows
and this method is called with argument 5 or 6 or -6).


=head1 PROVIDED METHODS

=head2 get_row_arrayref_at_index

Usage:

 my $row = $table->get_row_arrayref_at_index($index); # might die

Basically shortcut for:

 $table->set_row_iterator_index($index);
 $table->get_row_arrayref;

=head2 get_row_hashref_at_index

Usage:

 my $row = $table->get_row_hashref_at_index($index); # might die

Basically shortcut for:

 $table->set_row_iterator_index($index);
 $table->get_row_hashref;


=head1 SEE ALSO

L<TableDataRole::Spec::Basic>
