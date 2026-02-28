# 
sub f {
    my($concat, $di) = @_;
    my %di = %$di;
    my $count = keys %di;
    foreach my $i (0..$count-1) {
        if (index($concat, $di{$i}) != -1) {
            delete $di{$i};
        }
    }
    return "Done!";
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("mid", {"0" => "q", "1" => "f", "2" => "w", "3" => "i"}),"Done!")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
