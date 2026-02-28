# 
sub f {
    my($text, $repl) = @_;
    my $trans = {};
    @{$trans}{split //, lc $text} = split //, lc $repl;
    
    my @text = split //, $text;
    for my $i (0..$#text) {
        if (exists $trans->{lc $text[$i]}) {
            $text[$i] = $trans->{lc $text[$i]};
        }
    }
    
    return join '', @text;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("upper case", "lower case"),"lwwer case")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
