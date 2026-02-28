# 
sub f {
    my($forest, $animal) = @_;
    my $index = index($forest, $animal);
    my @result = split('', $forest);
    while ($index < length($forest)-1) {
        $result[$index] = substr($forest, $index+1, 1);
        $index++;
    }
    if ($index == length($forest)-1) {
        $result[$index] = '-';
    }
    return join('', @result);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("2imo 12 tfiqr.", "m"),"2io 12 tfiqr.-")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
