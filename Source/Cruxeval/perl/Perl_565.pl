# 
sub f {
    my($text) = @_;
    my @vowels = ('a', 'e', 'i', 'o', 'u');
    my $max_index = -1;
    
    foreach my $ch (@vowels) {
        my $index = index($text, $ch);
        $max_index = $index if $index > $max_index;
    }
    
    return $max_index;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("qsqgijwmmhbchoj"),13)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
