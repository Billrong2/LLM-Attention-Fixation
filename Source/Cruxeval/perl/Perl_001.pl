# 
sub f {
    my($a, $b, $c) = @_;
    my %result;
    foreach my $d ($a, $b, $c) {
        %result = (%result, map {$_ => undef} @$d);
    }
    return \%result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 3], [1, 4], [1, 2]),{1 => undef, 2 => undef, 3 => undef, 4 => undef})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
