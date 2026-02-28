# 
sub f {
    my($s) = @_;
    my @d = $s =~ /(.*)(ar)(.*)/;
    return join(' ', @d);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("xxxarmmarxx"),"xxxarmm ar xx")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
