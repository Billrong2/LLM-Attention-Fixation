# 
sub f {
    my($items, $target) = @_;
    my @items = split(' ', $items);
    foreach my $i (@items) {
        if(index($target, $i) >= 0) {
            return index($items, $i) + 1;
        }
        if(index($i, '.') == length($i)-1 || index($i, '.') == 0) {
            return 'error';
        }
    }
    return '.';
}
use Test::Deep;


sub testhumaneval {
    my $candidate = \&f;
        if(eq_deeply($candidate->("qy. dg. rnvprt rse.. irtwv tx..", "wtwdoacb"),"error")) {
        print "ok!" }else{
        exit 1;
        }
}

testhumaneval();
