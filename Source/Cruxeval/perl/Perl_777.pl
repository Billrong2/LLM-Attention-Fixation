# 
sub f {
    my($names, $excluded) = @_;
    my @names = @{$names};
    my $excluded = $excluded;
    for(my $i = 0; $i < scalar @names; $i++){
        if(index($names[$i], $excluded) != -1){
            $names[$i] =~ s/$excluded//g;
        }
    }
    return \@names;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->(["avc  a .d e"], ""),["avc  a .d e"])) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
