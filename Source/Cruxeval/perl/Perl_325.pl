# 
sub f {
    my($s) = @_;
    my @l = split(//, $s);
    foreach my $char (@l) {
        $char = lc($char);
        if ($char !~ /\d/) {
            return 0;
        }
    }
    return 1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(""),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
