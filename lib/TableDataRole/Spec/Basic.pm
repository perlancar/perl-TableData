 ## no critic: TestingAndDebugging::RequireUseStrict
 package TableDataRole::Spec::Basic;

use Role::Tiny;

# AUTHORITY
# DATE
# DIST
# VERSION

# constructor
requires 'new';

# mixin
with 'Role::TinyCommons::Iterator::Resettable';

# additional method names to return hashref
requires 'get_next_row_hashref';

# column information
requires 'get_column_count';
requires 'get_column_names';

###

# aliases, for convenience and clarity

sub has_next_row {
    my $self = shift;
    $self->has_next_item(@_);
}

sub get_next_row_arrayref {
    my $self = shift;
    $self->get_next_item(@_);
}

sub get_row_count {
    my $self = shift;
    $self->get_item_count(@_);
}

sub get_all_rows_arrayref {
    my $self = shift;
    $self->get_all_items(@_);
}

sub get_all_rows_hashref {
    my $self = shift;

    my @items;
    $self->reset_iterator;
    while ($self->has_next_item) {
        my $row = $self->get_next_row_hashref;
        push @items, $row;
    }
    @items;
}

sub each_row_arrayref {
    my $self = shift;
    $self->each_item(@_);
}

sub each_row_hashref {
    my ($self, $coderef) = @_;

    $self->reset_iterator;
    my $index = 0;
    while ($self->has_next_item) {
        my $row = $self->get_next_row_hashref;
        my $res = $coderef->($row, $self, $index);
        return 0 unless $res;
        $index++;
    }
    return 1;
}

1;
# ABSTRACT: Basic interface for all TableData::* modules

=head1 DESCRIPTION

C<TableData::*> modules let you iterate rows using a resettable iterator
interface (L<Role::TinyCommons::Iterator::Resettable>). They also let you get
information about the columns.

 category                     method name                note
 --------                     -----------                -------
 instantiating                new(%args)

 iterating rows               has_next_item()
                              has_next_row()             Alias for has_next_item()
                              get_next_item()
                              get_next_row_arrayref()    Alias for get_next_item()
                              get_next_row_hashref()
                              reset_iterator()

 iterating rows (alt)         each_item()
                              each_row_arrayref()        Alias for each_item()
                              each_row_hashref()

 getting all rows             get_all_items()
                              get_all_rows_arrayref()    Alias for get_all_items()
                              get_all_rows_hashref()

 getting column information   get_column_names()
                              get_column_count()


=head1 REQUIRED METHODS

=head2 new

Usage:

 my $table = TableData::Foo->new([ %args ]);

Constructor. Must accept a pair of argument names and values.

=head2 has_next_item

Usage:

 $table->has_next_item; # bool

Must return true if table has next row when iterating, false otherwise.

From L<Role::TinyCommons::Iterator::Resettable>.

=head2 reset_iterator

Usage:

 $table->reset_iterator;

Reset iterator so that the next L</get_next_item> retrieves the first row.

From L<Role::TinyCommons::Iterator::Resettable>.

=head2 get_iterator_pos

Usage:

 $table->get_iterator_pos;

Get iterator position.

From L<Role::TinyCommons::Iterator::Resettable>.

=head2 get_next_item

Usage:

 my $row_arrayref = $table->get_next_item;

Must return the next row as arrayref. See also L</get_next_row_hashref>.

=head2 get_next_row_hashref

Usage:

 my $row_hashref = $table->get_next_row_hashref;

Must return the next row as arrayref. See also L</get_next_row_arrayref> (a.k.a.
L</get_next_item>).

=head2 get_column_count

Usage:

 my $n = $table->get_column_count;

Must return the number of columns of the table.

All tables must have finite number of columns.

=head2 get_column_names

Usage:

 my @colnames = $table->get_column_names;
 my $colnames = $table->get_column_names;

Must return a list (or arrayref) containing the names of columns, ordered. For
ease of use, when in list context the method must return a list, and in scalar
context must return an arrayref.


=head1 PROVIDED METHODS

=head2 get_item_count

Usage:

 my $count = $table->get_item_count;

Return the number of data rows in the table. Resets the row iterator (see
L</get_row_arrayref> and L</reset_iterator>).

A table with infinite data rows can return -1.

The default implementation will call L</reset_iterator>, call L</has_next_item>
and L</get_next_item> repeatedly until there is no more row, then return the
counted number of rows. If your source data is already in an array or some other
form where the count is easily known, you can replace the implementation with a
more efficient one.

=head2 get_row_count

Alias for L</get_item_count>.

=head2 has_next_row

Alias for L</has_next_item>.

=head2 get_next_row_arrayref

Alias for L</get_next_item>.

=head2 get_all_items

Usage:

 my @rows = $table->get_all_items;

Return all rows as a list of arrayrefs. Resets the row iterator. Basically
shortcut for:

 my @rows;
 $table->reset_iterator;
 while ($table->has_next_item) {
     push @rows, $table->get_next_item;
 }
 @rows;

You can provide a more efficient implementation if your source data allows it.

A table with infinite data rows can throw an exception if this method is called.

=head2 get_all_rows_arrayref

Alias for L</get_all_items>.

=head2 get_all_rows_hashref

Usage:

 my @rows = $table->get_all_rows_hashref;

Return all rows as a list of hashrefs. Resets the row iterator. Basically
shortcut for:

 my @rows;
 $table->reset_iterator;
 while ($table->has_next_item) {
     push @rows, $table->get_next_row_hashref;
 }
 @rows;

You can provide a more efficient implementation if your source data allows it.

A table with infinite data rows can throw an exception if this method is called.

=head2 each_item

Usage:

 $table->each_item($coderef);

Call C<$coderef> for each row. If C<$coderef> returns false, will immediately
return false and skip the rest of the rows. Otherwise, will return true.
Basically:

 $table->reset_iterator;
 my $index = 0;
 while ($table->has_next_item) {
     my $row = $table->get_next_item;
     my $res = $coderef->($row, $table, $index);
     return 0 unless $res;
     $index++;
 }
 return 1;

See also L</each_row_hashref>.

=head2 each_row_arrayref

Alias for L</each_item>.

=head2 each_row_hashref

Usage:

 $table->each_row_hashref($coderef);

Call C<$coderef> for each row. If C<$coderef> returns false, will immediately
return false and skip the rest of the rows. Otherwise, will return true.
Basically:

 $table->reset_iterator;
 my $index = 0;
 while ($table->has_next_item) {
     my $row = $table->get_next_row_hashref;
     my $res = $coderef->($row, $table, $index);
     return 0 unless $res;
     $index++;
 }
 return 1;

See also L</each_row_arrayref> (a.k.a. L</each_item>).


=head1 SEE ALSO
