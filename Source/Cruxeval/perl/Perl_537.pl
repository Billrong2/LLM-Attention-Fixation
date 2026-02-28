# 
sub f {
    my($text, $value) = @_;
    my @new_text = split(//, $text);
    eval { push(@new_text, $value); };
    my $length = @new_text;
    return '[' . $length . ']';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("abv", "a"),"[4]")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
