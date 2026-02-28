# 
sub f {
    my($counts) = @_;
    my %dict;
    foreach my $k (keys %$counts) {
        my $v = $counts->{$k};
        my $count = $counts->{$k};
        unless (exists $dict{$count}) {
            $dict{$count} = [];
        }
        push @{$dict{$count}}, $k;
    }
    $counts = {%$counts, %dict};
    return $counts;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"2" => 2, "0" => 1, "1" => 2}),{"2" => 2, "0" => 1, "1" => 2, 2 => ["2", "1"], 1 => ["0"]})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
