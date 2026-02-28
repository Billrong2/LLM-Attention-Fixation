# 
sub f {
    my($text) = @_;
    my @s = split('\n', $text);
    return scalar @s;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("145

12fjkjg"),3)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
