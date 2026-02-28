# 
sub f {
    my($a) = @_;
    for (my $i = 0; $i < 10; $i++) {
        my @chars = split //, $a;
        my $j;
        for ($j = 0; $j < @chars; $j++) {
            if ($chars[$j] ne '#') {
                $a = substr($a, $j);
                last;
            }
        }
        if ($j == @chars) {
            $a = "";
            last;
        }
    }
    
    while (substr($a, -1) eq '#') {
        $a = substr($a, 0, -1);
    }
    
    return $a;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("##fiu##nk#he###wumun##"),"fiu##nk#he###wumun")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
