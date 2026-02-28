# 
sub f {
    my($values, $item1, $item2) = @_;
    if ($values->[-1] == $item2) {
        if ($values->[0] && !grep { $_ == $values->[0] } @{$values}[1..$#{$values}]) {
            push @{$values}, $values->[0];
        }
    }
    elsif ($values->[-1] == $item1) {
        if ($values->[0] == $item2) {
            push @{$values}, $values->[0];
        }
    }
    return $values;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([1, 1], 2, 3),[1, 1])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
