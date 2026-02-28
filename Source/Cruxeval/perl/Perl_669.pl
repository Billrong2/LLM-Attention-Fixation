# 
sub f {
    my($t) = @_;
    my($a, $sep, $b) = split /-/, $t, -1;
    if (length($b) == length($a)) {
        return 'imbalanced';
    }
    return $a . (my $new_b = $b); # Replace sep in $b with an empty string
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("fubarbaz"),"fubarbaz")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
