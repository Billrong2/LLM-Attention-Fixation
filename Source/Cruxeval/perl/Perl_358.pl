# 
sub f {
    my($text, $value) = @_;
    my @indexes;
    for(my $i = 0; $i < length($text); $i++) {
        if(substr($text, $i, 1) eq $value && ($i == 0 || substr($text, $i-1, 1) ne $value)) {
            push @indexes, $i;
        }
    }
    if(scalar @indexes % 2 == 1) {
        return $text;
    }
    return substr($text, $indexes[0]+1, $indexes[-1]-$indexes[0]-1);
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("btrburger", "b"),"tr")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
