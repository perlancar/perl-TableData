## no critic: TestingAndDebugging::RequireUseStrict
package TableDataRole::Spec::GetRowByKey;

use Role::Tiny;

# AUTHORITY
# DATE
# DIST
# VERSION

### requirements

requires 'get_row_by_key';

requires 'get_row_by_key_hashref';

1;
# ABSTRACT: Interface to get a row by a key value

=head1 DESCRIPTION

EXPERIMENTAL.

This interface is for getting a row by a key value. User supplies field name and
field value and expects to get a row that has that field value.


=head1 REQUIRED METHODS

=head2 get_row_by_key

Usage:

 my $row_arrayref = $table->get_row_by_key($field_name => $field_value);

=head2 get_row_by_key_hashref

The hashref-returning variant for L</get_row_by_key>.

Usage:

 my $row_hashref = $table->get_row_by_key_hashref($field_name => $field_value);


=head1 SEE ALSO
