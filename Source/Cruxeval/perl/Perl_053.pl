# 
sub f {
    my($text) = @_;
    my %occ;
    my %name = ('a' => 'b', 'b' => 'c', 'c' => 'd', 'd' => 'e', 'e' => 'f');
    my @chars = split(//, $text);
    foreach my $ch (@chars) {
        my $mapped_ch = $name{$ch} // $ch;
        $occ{$mapped_ch} = $occ{$mapped_ch} + 1 || 1;
    }
    return [values %occ];
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("URW rNB"),[1, 1, 1, 1, 1, 1, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
