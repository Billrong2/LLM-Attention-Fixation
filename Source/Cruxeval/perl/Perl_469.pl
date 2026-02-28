# 
sub f {
    my($text, $position, $value) = @_;
    my $length = length($text);
    my $index = $position % $length;
    if ($position < 0) {
        $index = $length / 2;
    }
    my @new_text = split(//, $text);
    splice(@new_text, $index, 0, $value);
    splice(@new_text, $length - 1, 1);
    return join('', @new_text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("sduyai", 1, "y"),"syduyi")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
