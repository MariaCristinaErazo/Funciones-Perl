use strict;
use warnings;

my @z_arr = (1,2,3,4,5,6,7,8);

my @resultado = ();

@resultado = reshape(\@z_arr, 1, 2);
#map {print $_,"\t"}@z_arr;

sub reshape{
    my $num_elem = @_;
    
    my $shapei_str =pop @_;
    my $shapej_str =pop @_;
    my ($bidim_arr_ref) = @_;
    my @bidim_arr = @{$bidim_arr_ref};
    
    if ($num_elem == 0) {
        print "\nTypeError: reshape() missing required argument 'shape' (pos 1)\n";
    }elsif ($num_elem == 1){
        print "\nTypeError: reshape() missing required argument 'shape' (pos 2)\n";
    }elsif($num_elem == 3 && $shapei_str*$shapej_str==@bidim_arr){
        my @res = ();
        my $cont = 0;
        for (my $i=0 ; $i<$shapej_str ; $i++){
            for (my $j=0 ; $j<$shapei_str ; $j++){
                $res[$i][$j]=$bidim_arr[$cont];
                $cont = $cont+1;
            }
        }
        print "\nRESULTADO\n";
        map {map{print $_, "\t"}@{$_}; print"\n"}@res;
    }else{
        print "\nTypeError: reshape() unspected error\n";
    }
}