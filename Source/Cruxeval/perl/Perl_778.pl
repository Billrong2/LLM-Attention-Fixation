# 
sub f {
    my($prefix, $text) = @_;
    if (index($text, $prefix) == 0) {
        return $text;
    } else {
        return $prefix . $text;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("mjs", "mjqwmjsqjwisojqwiso"),"mjsmjqwmjsqjwisojqwiso")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
