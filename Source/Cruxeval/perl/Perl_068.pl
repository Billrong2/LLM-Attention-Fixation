# 
sub f {
    my($text, $pref) = @_;
    if (index($text, $pref) == 0) {
        my $n = length $pref;
        my @parts = split(/\./, substr($text, $n));
        @parts = @parts[1..$#parts];
        push @parts, split(/\./, substr($text, 0, $n));
        pop @parts;
        $text = join('.', @parts);
    }
    return $text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("omeunhwpvr.dq", "omeunh"),"dq")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
