# 
sub f {
    my($orig) = @_;
    my $copy = $orig;
    push(@$copy, 100);
    pop(@$orig);
    return $copy;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 2, 3]),[1, 2, 3])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
