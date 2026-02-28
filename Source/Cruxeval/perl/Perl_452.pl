# 
sub f {
    my($text) = @_;
    my $counter = 0;
    foreach my $char (split('', $text)) {
        if ($char =~ /[a-zA-Z]/) {
            $counter++;
        }
    }
    return $counter;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("l000*"),1)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
