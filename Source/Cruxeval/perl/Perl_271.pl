# 
sub f {
    my($text, $c) = @_;
    my @ls = split('', $text);
    if (index($text, $c) == -1) {
        die "Text has no $c\n";
    }
    splice(@ls, rindex($text, $c), 1);
    return join('', @ls);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("uufhl", "l"),"uufh")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
