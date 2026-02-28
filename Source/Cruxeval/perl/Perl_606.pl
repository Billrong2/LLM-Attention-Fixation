# 
sub f {
    my($value) = @_;
    my @ls = split(//, $value);
    push @ls, 'NHIB';
    return join('', @ls);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ruam"),"ruamNHIB")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
