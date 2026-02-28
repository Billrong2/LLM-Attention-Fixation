# 
sub f {
    my($text, $sub) = @_;
    my @index;
    my $starting = 0;
    while ($starting != -1) {
        $starting = index($text, $sub, $starting);
        if ($starting != -1) {
            push @index, $starting;
            $starting += length($sub);
        }
    }
    return \@index;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("egmdartoa", "good"),[])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
