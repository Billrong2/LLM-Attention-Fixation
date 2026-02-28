# 
sub f {
    my($text, $char) = @_;
    my $new_text = $text;
    my @a;
    while ($new_text =~ /$char/) {
        push(@a, index($new_text, $char));
        substr($new_text, index($new_text, $char), 1) = '';
    }
    return \@a;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("rvr", "r"),[0, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
