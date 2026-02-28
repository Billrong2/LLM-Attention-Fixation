# 
sub f {
    my($text) = @_;
    if ($text =~ /,/) {
        my ($before, $after) = split(/,/, $text, 2);
        return $after . ' ' . $before;
    }
    return ',' . (split(/ /, $text))[-1] . ' 0';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("244, 105, -90")," 105, -90 244")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
