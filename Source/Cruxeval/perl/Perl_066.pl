# 
sub f {
    my($text, $prefix) = @_;
    my $prefix_length = length($prefix);
    if (substr($text, 0, $prefix_length) eq $prefix) {
        return reverse substr($text, ($prefix_length - 1) / 2, ($prefix_length + 1) / 2 - 1);
    } else {
        return $text;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("happy", "ha"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
