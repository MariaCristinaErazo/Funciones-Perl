# reshape nos permite en una matriz cambiar columnas
#pasan a filas
#!/usr/bin/perl
use warnings;
use strict;
use Data::Dump qw(dump);


my @test_arr=([8,4,1],[3,1,9],[8,15,1]);
print "Matriz original\n";
#Se imprime el arreglo original
map {map{print $_, "\t"}@{$_}; print"\n"}@test_arr;

print "\n";
print "\nMatriz transpuesta\n";
#creo una matriz la cual guarda el resultado de la matrix transpuesta
my @resultado_arr = transpose(\@test_arr, 1, 0);

map {print $_,"\t"}@resultado_arr;

#funcion transpuesta
sub transpose{
# crear los parametros que recibe la funcion transpose
my($matriz, $ejex, $ejey)= @_;

my @transpuesta =();

if ($ejex == 1 && $ejey ==0) {
    #realizar la funcion transpuesta
    for my $row(@$matriz){
        for my $column(0 .. $#{$row}){
            push(@{$transpuesta[$column]}, $row ->[$column]);
        }
    }
    for my $new_row(@transpuesta){
        my $line_to_print = '';
        for my $new_col (@{$new_row}){
            $line_to_print .= "$new_col\t";
        }
        $line_to_print =~ s/\t$//;
        print "$line_to_print\n";
    }
}


}





