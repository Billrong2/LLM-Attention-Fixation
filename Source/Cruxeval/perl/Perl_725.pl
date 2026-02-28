# 
sub f {
    my($text) = @_;
    my @result_list = ('3', '3', '3', '3');
    if (@result_list) {
        @result_list = ();
    }
    return length($text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("mrq7y"),5)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
