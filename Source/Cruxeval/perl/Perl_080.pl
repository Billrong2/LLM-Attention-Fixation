# 
sub f {
    my($s) = @_;
    return scalar reverse $s =~ s/\s+$//r;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ab        "),"ba")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
