## no critic: TestingAndDebugging::RequireUseStrict
package TableDataRole::Spec::GetRowByPos;

use Role::Tiny;

# AUTHORITY
# DATE
# DIST
# VERSION

### mixins

with 'Role::TinyCommons::Collection::GetItemByPos';

### requires

requires 'get_row_at_pos_hashref';

### aliases, for convenience and clarity

sub get_row_at_pos {
    my $self = shift;
    $self->get_item_at_pos(@_);
}

### implementation

1;
# ABSTRACT: TableData::* that can access a row by position

=head1 DESCRIPTION

Mix this role to C<TableData::*> modules that can access rows by position. You
will need to supply an implementation for C<get_item_at_pos>


=head1 MIXED-IN ROLES

L<Role::TinyCommons::Collection::GetItemByPos>


=head1 REQUIRED METHODS

=head2 get_item_at_pos

Usage:

 my $row = $td->get_item_at_pos($index);

Mixed in from L<Role::TinyCommons::Collection::GetItemByPos>.

=head2 get_row_at_pos_hashref


=head1 PROVIDED METHODS

=head2 get_row_at_pos

Alias for L</get_item_at_pos>.


=head1 SEE ALSO
