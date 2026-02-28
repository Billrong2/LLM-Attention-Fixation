# 
sub f {
    my($text, $char) = @_;
    my $length = length($text);
    my $index = -1;
    for (my $i = 0; $i < $length; $i++) {
        if (substr($text, $i, 1) eq $char) {
            $index = $i;
        }
    }
    if ($index == -1) {
        $index = int($length / 2);
    }
    my @new_text = split(//, $text);
    splice(@new_text, $index, 1);
    return join('', @new_text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("o horseto", "r"),"o hoseto")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
