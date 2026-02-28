# 
sub f {
    my($bag) = @_;
    my @values = values %$bag;
    my %tbl;
    foreach my $v (0..99) {
        if (grep {$_ == $v} @values) {
            $tbl{$v} = grep {$_ == $v} @values;
        }
    }
    return \%tbl;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0}),{0 => 5})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
