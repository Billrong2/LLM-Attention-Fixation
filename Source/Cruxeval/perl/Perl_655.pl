# 
sub f {
    my($s) = @_;
    $s =~ s/a//g;
    $s =~ s/r//g;
    return $s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("rpaar"),"p")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
