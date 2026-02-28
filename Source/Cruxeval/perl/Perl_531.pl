sub f {
    my ($text, $x) = @_;
    if (index($text, $x) != 0) {
        return f(substr($text, 1), $x);
    } else {
        return $text;
    }
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Ibaskdjgblw asdl ", "djgblw"),"djgblw asdl ")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
