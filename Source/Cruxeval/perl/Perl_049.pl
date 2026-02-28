# 
sub f {
    my($text) = @_;
    if ($text =~ /^\w+$/) {
        return join('', grep { /\d/ } split('', $text));
    } else {
        return join('', split('', $text));
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("816"),"816")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
