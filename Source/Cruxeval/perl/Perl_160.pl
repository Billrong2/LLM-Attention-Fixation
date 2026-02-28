# 
sub f {
    my($dictionary) = @_;
    while(!exists $dictionary->{1} || scalar keys %$dictionary == 0){
        %$dictionary = ();
        last;
    }
    return $dictionary;
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->({1 => 47698, 1 => 32849, 1 => 38381, 3 => 83607}),{1 => 38381, 3 => 83607})) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
