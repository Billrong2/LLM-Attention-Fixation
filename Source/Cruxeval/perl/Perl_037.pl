# 
sub f {
    my($text) = @_;
    my @text_arr;
    for (my $j = 0; $j < length($text); $j++) {
        push @text_arr, substr($text, $j);
    }
    return \@text_arr;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("123"),["123", "23", "3"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
