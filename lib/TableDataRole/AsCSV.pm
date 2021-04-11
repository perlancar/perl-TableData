package TableDataRole::AsCSV;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

use Role::Tiny;

sub as_csv {
    state $csv = do {
        require Text::CSV;
        Text::CSV->new({ binary=>1, auto_diag=>1 });
    };

    my $table = shift;

    my $res = "";
    $table->reset_row_iterator;
    $csv->combine( $table->get_column_names ); # XXX check status?
    $res .= $csv->string . "\n";
    while (defined(my $row = $table->get_row_arrayref)) {
        $csv->combine(@$row); # XXX check status
        $res .= $csv->string . "\n";
    }
    $res;
}

1;
# ABSTRACT: Provide as_csv() method

=head2 as_csv

Usage:

 my $csv = $table->as_csv;

Return the whole table data as CSV (string). Will reset the row iterator.

This implementation will call L</reset_row_iterator>, call L</get_row_arrayref>
repeatedly, format the rows as CSV and return it. If your source data is already
in CSV format, you can simply return the CSV data instead.
