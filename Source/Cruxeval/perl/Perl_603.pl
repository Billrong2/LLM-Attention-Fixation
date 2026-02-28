# 
sub f {
    my($sentences) = @_;
    my @sentences = split(/\./, $sentences);
    if (grep(!/^\d+$/, @sentences)) {
        return 'not oscillating';
    } else {
        return 'oscillating';
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("not numbers"),"not oscillating")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
