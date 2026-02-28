# 
sub f {
    my($d) = @_;
    my @sorted_keys = sort { $b <=> $a } keys %$d;
    my $key1 = $sorted_keys[0];
    my $val1 = delete $d->{$key1};
    my $key2 = $sorted_keys[1];
    my $val2 = delete $d->{$key2};
    return { $key1 => $val1, $key2 => $val2 };
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({2 => 3, 17 => 3, 16 => 6, 18 => 6, 87 => 7}),{87 => 7, 18 => 6})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
