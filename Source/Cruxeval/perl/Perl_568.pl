# 
sub f {
    my($num) = @_;
    my $num = shift;
    my $letter = 1;
    foreach my $i ('1','2','3','4','5','6','7','8','9','0') {
        $num =~ s/$i//g;
        if (length($num) == 0) { last; }
        $num = substr($num, $letter) . substr($num, 0, $letter);
        $letter += 1;
    }
    return $num;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("bwmm7h"),"mhbwm")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
