# 
sub f {
    my($text) = @_;
    my @ls = split(//, $text);
    for(my $x = $#ls; $x >= 0; $x--){
        if(scalar @ls <= 1) { last; }
        if(index('zyxwvutsrqponmlkjihgfedcba', $ls[$x]) == -1){
            splice(@ls, $x, 1);
        }
    }
    return join("", @ls);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("qq"),"qq")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
