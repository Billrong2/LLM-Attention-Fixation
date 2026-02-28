# 
sub f {
    my($text) = @_;
    my @a = ();
    for my $i (0 .. length($text) - 1) {
        if (!(substr($text, $i, 1) =~ /^\d$/)) {
            push(@a, substr($text, $i, 1));
        }
    }
    return join('', @a);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("seiq7229 d27"),"seiq d")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
