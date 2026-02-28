# 
sub f {
    my($d, $count) = @_;
    for (my $i = 0; $i < $count; $i++) {
        if (keys %$d == 0) {
            last;
        }
        my $key = (keys %$d)[-1];
        delete $d->{$key};
    }
    return $d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({}, 200),{})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
