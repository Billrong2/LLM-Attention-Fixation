# 
sub f {
    my($r, $w) = @_;
    my @a;
    if (substr($r, 0, 1) eq substr($w, 0, 1) && substr($w, -1) eq substr($r, -1)) {
        push(@a, $r);
        push(@a, $w);
    } else {
        push(@a, $w);
        push(@a, $r);
    }
    return \@a;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ab", "xy"),["xy", "ab"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
