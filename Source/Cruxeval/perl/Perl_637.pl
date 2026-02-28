# 
sub f {
    my($text) = @_;
    my @text = split(' ', $text);
    foreach my $t (@text) {
        if ($t !~ /^\d+$/) {
            return 'no';
        }
    }
    return 'yes';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("03625163633 d"),"no")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
