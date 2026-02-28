# 
sub f {
    my($pattern, $items) = @_;
    my @result;
    foreach my $text (@$items) {
        my $pos = rindex($text, $pattern);
        if ($pos >= 0) {
            push @result, $pos;
        }
    }
    
    return \@result;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(" B ", [" bBb ", " BaB ", " bB", " bBbB ", " bbb"]),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
