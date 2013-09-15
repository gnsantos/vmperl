#!/usr/bin/perl

use v5.12;
use strict;
use stack;
use operation;

#label e um marcador no codigo do programa
#opcode e o simbolo da instrucao
#arg e o argumento da operacao
#auxiliar e um escalar utilizado para permitir adiquirir o que se precisa de forma mais facil
#labelHash e um hash que mantem registro das labels que ja apareceram
#ref e um escalar que guarda uma referencia anonima para um vetor com (opcode,arg)
#program e um vetor que guarda as instrucoes a serem executadas e seus respectivos argumentos

my $label, my $opcode, my $arg, my $pc, my $auxiliar;
my %labelHash;
my @program, my $ref;
$, = " ";

while(<>){
    chomp($_);
    
    if(/^#.*[\n\f]*/){
	print "";
    }

    else{
	if(/(\b[a-zA-Z]*\b:\s*)[\n\f#]*$/){ #linha contendo apenas uma label
	    ($label) = $1 =~ /[a-zA-Z]+/g; #retira o : do nome da label
	    $labelHash{$label} = $pc; #usa a label como key de um hash. O valor armazenado 
	    #e a posicao no programa em que aparece o codigo a ser executado
	}

	else{
	    if(/(\b[a-zA-Z]*\b:\s*)?(\b[a-zA-Z]{2,4}\b[^:]?)(\w*)\s*[\n\f#]*/){ #identifica uma linha que pode ou nao conter uma label, e que contem um comando, e pode ou nao conter um arg
		$auxiliar = $2; #copia o comando lido para auxiliar para presevar integridade
		$arg = $3; #passa o argumento para arg
		($label) = $1 =~ /[a-zA-Z]+/g; #passa a label sem os : e sem espaco para $label
		($opcode) = $auxiliar =~ /[a-zA-Z]{2,4}/g; #passa o nome do comando para opcode
		$ref = [$opcode,$arg]; #cria uma referencia anonima para (opcode,arg)
		push @program, $ref; #insere o par ordenado no vetor-programa
		if(defined($label)){
		    $labelHash{$label} = @program - 1; #caso a label exista, insere-a no hash
		}
	    }
	}
    }
}

our $stack = new stack();

for($pc = 0; $pc < @program; $pc += 1){
    print "$program[$pc]->[0]\n";
    $stack->makeOperation($program[$pc]->[0], $program[$pc]->[1]);
}
