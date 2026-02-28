# 
sub f {
    my($text, $value) = @_;
    my @ls = split('', $text);
    if ((grep { $_ eq $value } @ls) % 2 == 0) {
        while ($value ~~ @ls) {
            @ls = grep { $_ ne $value } @ls;
        }
    } else {
        @ls = ();
    }
    return join('', @ls);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abbkebaniuwurzvr", "m"),"abbkebaniuwurzvr")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
