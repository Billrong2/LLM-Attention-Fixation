# 
sub f {
    my($s) = @_;
    my $count = 0;
    my @words = split(' ', $s);
    foreach my $word (@words) {
        $count += $word =~ /^[A-Z][a-z]*$/;
    }
    return $count;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("SOME OF THIS Is uknowN!"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
