# 
sub f {
    my($text) = @_;
    for my $i (reverse(1..length($text)-1)) {
        if (lc(substr($text, $i, 1)) eq substr($text, $i, 1)) {
            return substr($text, 0, $i);
        }
    }
    return '';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("SzHjifnzog"),"SzHjifnzo")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
