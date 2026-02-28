# 
sub f {
    my($array, $elem) = @_;
    my @array = @{$array};
    $elem = "$elem";
    my $d = 0;
    
    foreach my $i (@array){
        if("$i" eq $elem){
            $d += 1;
        }
    }
    
    return $d;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->([-1, 2, 1, -8, -8, 2], 2),2)) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
