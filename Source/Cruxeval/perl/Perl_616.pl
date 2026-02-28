# 
sub f {
    my($body) = @_;
    my @ls = split(//, $body);
    my $dist = 0;
    for my $i (0..$#ls-1) {
        if ($ls[$i - 2 >= 0 ? $i - 2 : 0] eq "\t") {
            $dist += (1 + ($ls[$i - 1] =~ tr/\t//)) * 3;
        }
        $ls[$i] = '[' . $ls[$i] . ']';
    }
    return join("", @ls) =~ s/\t/    /gr;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("

y
"),"[
][
][y]
")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
