package TableData::Test::Spec::Seekable;

# AUTHORITY
# DATE
# DIST
# VERSION

use parent 'TableData::Test::Spec::Basic';
use Role::Tiny::With;

with 'TableDataRole::Spec::Seekable';

sub set_row_iterator_index {
    my ($table, $index) = @_;

    $index = int($index);
    if ($index >= 0) {
        die "Index out of range" unless $index < @{ $table->_rows };
        $table->{index} = $index;
    } else {
        die "Index out of range" unless -$index <= @{ $table->_rows };
        $table->{index} = @{ $table->_rows } + $index;
    }
}

1;
