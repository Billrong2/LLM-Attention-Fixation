# 
sub f {
    my($x) = @_;
    if (lc($x) eq $x) {
        return $x;
    } else {
        return reverse($x);
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ykdfhp"),"ykdfhp")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
