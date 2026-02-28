# 
sub f {
    my($dictionary) = @_;
    return { %$dictionary };
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({563 => 555, 133 => undef}),{563 => 555, 133 => undef})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
