# 
sub f {
    my($text, $rules) = @_;
    foreach my $rule (@$rules) {
        if ($rule eq '@') {
            $text = reverse $text;
        } elsif ($rule eq '~') {
            $text = uc $text;
        } elsif ($text && substr($text, -1) eq $rule) {
            $text = substr($text, 0, length($text) - 1);
        }
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("hi~!", ["~", "`", "!", "&"]),"HI~")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
