sub f {
    my($d) = @_;
    my @keys;
    while (my ($k, $v) = each %$d) {
        push @keys, "$k => $v";
    }
    return \@keys;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"-4" => "4", "1" => "2", "-" => "-3"}),["-4 => 4", "1 => 2", "- => -3"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
