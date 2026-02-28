# 
sub f {
    my($text, $pref) = @_;
    if (ref($pref) eq 'ARRAY') {
        return join(', ', map { substr($text, 0, length($_)) eq $_ } @$pref);
    } else {
        return substr($text, 0, length($pref)) eq $pref;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("Hello World", "W"),"")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
