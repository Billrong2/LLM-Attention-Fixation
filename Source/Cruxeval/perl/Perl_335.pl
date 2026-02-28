# 
sub f {
    my($text, $to_remove) = @_;
    my @new_text = split('', $text);
    if (index($text, $to_remove) != -1) {
        my $index = index($text, $to_remove);
        splice(@new_text, $index, 1, '?');
        @new_text = grep { $_ ne '?' } @new_text;
    }
    return join('', @new_text);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("sjbrlfqmw", "l"),"sjbrfqmw")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
