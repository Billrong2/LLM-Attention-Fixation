# 
sub f {
    my($n) = @_;
    $n =~ s/[^0-24-9]//g; # remove all characters that are not in the set [0-24-9]
    return $n eq $_[0]; # if the resulting string is equal to the original string, return True
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(1341240312),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
