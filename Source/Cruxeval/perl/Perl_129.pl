# 
sub f {
    my($text, $search_string) = @_;
    my @indexes;
    while (index($text, $search_string) != -1) {
        push @indexes, rindex($text, $search_string);
        $text = substr($text, 0, rindex($text, $search_string));
    }
    return \@indexes;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("ONBPICJOHRHDJOSNCPNJ9ONTHBQCJ", "J"),[28, 19, 12, 6])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
