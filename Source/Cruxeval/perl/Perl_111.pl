sub f {
    my ($marks) = @_;
    my $highest = 0;
    my $lowest = 100;
    foreach my $value (values %$marks) {
        if ($value > $highest) {
            $highest = $value;
        }
        if ($value < $lowest) {
            $lowest = $value;
        }
    }
    return [$highest, $lowest];
}

use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({"x" => 67, "v" => 89, "" => 4, "alij" => 11, "kgfsd" => 72, "yafby" => 83}),[89, 4])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
