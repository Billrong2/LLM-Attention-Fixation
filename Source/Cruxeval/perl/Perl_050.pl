# 
sub f {
    my($lst) = @_;
    $lst = [];
    push(@$lst, (1) x scalar(@$lst + 1));
    return $lst;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["a", "c", "v"]),[1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
