# 
sub f {
    my($text, $suffix) = @_;
    if ($suffix eq '') {
        $suffix = undef;
    }
    return substr($text, -length($suffix)) eq $suffix;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("uMeGndkGh", "kG"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
