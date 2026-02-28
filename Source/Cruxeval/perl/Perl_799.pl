# 
sub f {
    my($st) = @_;
    if (substr($st, 0, 1) eq '~') {
        my $e = 's' x (10 - length($st)) . $st;
        return f($e);
    } else {
        return 'n' x (10 - length($st)) . $st;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("eqe-;ew22"),"neqe-;ew22")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
