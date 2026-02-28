# 
sub f {
    my($text, $lower, $upper) = @_;
    return substr($text, $lower, $upper - $lower) =~ m/^[\x00-\x7F]*\z/;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("=xtanp|sugv?z", 3, 6),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
