# 
sub f {
    my($aDict) = @_;
    return { reverse %$aDict };
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({1 => 1, 2 => 2, 3 => 3}),{1 => 1, 2 => 2, 3 => 3})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
