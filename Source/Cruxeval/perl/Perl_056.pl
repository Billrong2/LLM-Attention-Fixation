# 
sub f {
    my($sentence) = @_;
    foreach my $c (split //, $sentence) {
        if ($c =~ /[^\x00-\x7F]/) {
            return 0;
        }
    }
    return 1;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("1z1z1"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
