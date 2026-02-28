# 
sub f {
    my($fruits) = @_;
    if ($fruits->[-1] eq $fruits->[0]) {
        return 'no';
    } else {
        shift @{$fruits};
        pop @{$fruits};
        shift @{$fruits};
        pop @{$fruits};
        return $fruits;
    }
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["apple", "apple", "pear", "banana", "pear", "orange", "orange"]),["pear", "banana", "pear"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
