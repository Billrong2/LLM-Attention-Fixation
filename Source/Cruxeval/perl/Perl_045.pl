# 
sub f {
    my($text, $letter) = @_;
    my %counts;
    foreach my $char (split(//, $text)) {
        if (!exists $counts{$char}) {
            $counts{$char} = 1;
        } else {
            $counts{$char} += 1;
        }
    }
    return $counts{$letter} // 0;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("za1fd1as8f7afasdfam97adfa", "7"),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
