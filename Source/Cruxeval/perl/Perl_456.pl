# 
sub f {
    my($s, $tab) = @_;
    return $s =~ s/\t/' ' x $tab/reg;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Join us in Hungary", 4),"Join us in Hungary")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
