# 
sub f {
    my($text) = @_;
    for(my $i = 0; $i < length($text); $i++) {
        if(substr($text, 0, $i) =~ /^two/) {
            return substr($text, $i);
        }
    }
    return 'no';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("2two programmers"),"no")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
