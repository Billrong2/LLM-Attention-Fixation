# 
sub f {
    my($text) = @_;
    foreach my $c (split('', $text)) {
        if ($c !~ /^\d$/) {
            return 0;
        }
    }
    return length($text) > 0 ? 1 : 0;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("99"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
