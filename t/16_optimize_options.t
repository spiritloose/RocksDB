use strict;
use warnings;

use Test::More;
use RocksDB;
use File::Temp;

my @optimize_options = qw(
    IncreaseParallelism 
    PrepareForBulkLoad
    OptimizeForPointLookup
    OptimizeLevelStyleCompaction
    OptimizeUniversalStyleCompaction
);
for my $opt (@optimize_options) {
    my $name = File::Temp::tmpnam;
    my $db = RocksDB->new($name, {
        $opt => undef,
        create_if_missing => 1,
    });
    ok $db, $opt;
    undef $db;
    RocksDB->destroy_db($name);
}

done_testing;
