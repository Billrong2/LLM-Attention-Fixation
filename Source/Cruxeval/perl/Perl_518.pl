# 
sub f {
    my($text) = @_;
    return !($text =~ /^\d+$/);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("the speed is -36 miles per hour"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
