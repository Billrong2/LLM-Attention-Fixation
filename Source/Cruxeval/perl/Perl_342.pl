# 
sub f {
    my($text) = @_;
    return ($text =~ tr/-//) == length($text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("---123-4"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
