#!/usr/bin/perl

#Exercicio Programa I - Batalha de Robos
#MAC0242 - Laboratorio de Programacao II
#Professor Marco Dimas Gubitoso

#Fellipe Souto Sampaio 
#Número USP: 7990422 e-mail: fellipe.sampaio@usp.com

#Gervásio Protásio dos Santos Neto 
#Número USP: 7990996 e-mail: gervasio.neto@usp.br

#Vinícius Jorge Vendramini
#Número USP: 7991103 e-mail: vinicius.vendramini@usp.br

#IME-USP
#2 semestre 2013

use v5.12;
use strict;
use warnings;
use operation;
package stack ;

#Construtor da Classe stack
sub new {
    my $class= shift;
    my $self = {
        labels => {},
        instLen => undef,
    	lista => [],
    	vectorMem => [],
        PC => 0,
    	PUSH  => \&pile,
    	POP   => \&removeItem,
    	DUP   => \&dup,
    	STO => \&storeMem,
        PRN => \&prnOp,
    	RCL => \&pushMem,
        JMP => \&jmpInstruction,
    	JIF => \&falseStk,
        JIT => \&trueStk,
        opera => undef
    };
    my $new = new operation();
    $self->{opera} = $new;
    bless $self, $class;
    return $self;

}

#Insere no hashing labels a posicao do vetor de instrucao que o salto condicionado
#deve executar.
sub insertLabel{
    my $self = shift;
    my $addres = shift;
    my $value = shift;
    $self->{labels}->{$addres} = $value;
}
#Retorna o valor do PC (Programming Counter)
sub retPC{
    my $self = shift;
    return $self->{PC};
}
#Avanca para a proxima instrucao do vetor de instrucoes
sub nextInstruction{
    my $self = shift;
    $self->{PC} += 1;
}
#Realiza uma operacao de pilha ou chama os metodos do objeto operation sob os elementos
#da pilha
sub makeOperation{
    my $self = shift;
    (my $opCode, my $arg) = @_;

    if(exists $self->{$opCode}){
    	my $stat = $self->{$opCode};
    	&$stat($self,$arg);
    }
    else{
	   	my $teste = $self->{opera}->checkOpt($opCode);
        if ($teste){
            my $result = $self->{opera}->makeAritmetic(unstack($self),unstack($self),$opCode);
            pile($self,$result);            
        }
        else{
            #print "Instrucao invalida!\n";
        }
    }

    
}
#Retorna o topo sem remove-lo
sub showTop{
    my $self = shift;
    my $ln = scalar @{$self->{lista}};
    my $last = $self->{lista}[$ln - 1];
    #print "My last = $last \n";
    return $last;
}

#Salto incondicionado
sub jmpInstruction{
    my $self = shift;
    my $addres = shift;
    my $temp = $self->{labels}->{$addres};
    # print "Valor do Temp : $temp\n";
    $self->{PC} = $temp -1;
}
#estou assumindo que o teste é feito com o topo da pilha,
#depois de efetuada a comparação, independente da resposta 
#lógica o topo é descartado.

#Verifica se o elemento do topo é falso, se sim salta e remove, caso contrário só remove.
sub falseStk{
    my $self = shift;
    my $arg = shift;
    my $top = showTop($self);
    if ($top == 0){ 
        jmpInstruction($self,$arg);
        removeItem($self);
    }
    else { removeItem($self);} 
}
#Verifica se o elemento do topo é verdadeiro, se sim salta e remove, caso contrário só remove.
sub trueStk{
    my $self = shift;
    my $arg = shift;
    my $top = showTop($self);
    if ($top != 0){ 
        jmpInstruction($self,$arg);
        removeItem($self); 
    }
    else { removeItem($self);} 
}
#Inverte o topo com o subtopo
sub shiftStack{
    my $self = shift;
    my $val1 = pop(@{$self->{lista}});
    my $val2 = pop(@{$self->{lista}});
    push (@{$self->{lista}}, $val1);
    push (@{$self->{lista}}, $val2);
}
#empilha o elemento Vi do vetor de dados na pilha
sub pushMem{
    my $self = shift;
    my $pos = shift;
    my $value = $self->{vectorMem}[$pos];
    # print "Inserindo : [$pos] = $value \n";
    push (@{$self->{lista}}, $value);
    #printaMem($self);

}
#Desempilha o topo da pilha e armazena na posicao Vi do vetor de dados.
sub storeMem{
    my $self = shift;
    my $indx = shift;
    my $temp = unstack($self);
    $self->{vectorMem}[$indx] = $temp;
}
#Empilha no topo da pilha
sub pile{
    my ($self, $Item) = @_;
    push (@{$self->{lista}}, $Item);
}
#Remove o topo da pilha.
sub removeItem{
    my $self = shift;
    pop(@{$self->{lista}});
}
#Remove um elemento da pilha e o imprime.
sub prnOp{
    my $item = &removeItem;
    print "$item\n"; 
}
#Duplica o topo da pilha
sub dup{
    my $self = shift;
    my $temp = showTop($self);
    push (@{$self->{lista}}, $temp);

}
#Remove o topo e retorna o item
sub unstack{
    my $self = shift;
    return pop(@{$self->{lista}});
}

#Imprime a pilha
sub printaStack{
    my $self = shift;
    my $ln = scalar @{$self->{lista}};
    print "Itens na Pilha = $ln \n";
    #print ("\n");
    my $indx = 0;
    for (; $indx < $ln; $indx++){
        if ($self->{lista}[$indx]) {
            print "$self->{lista}[$indx]    ";
        }
        else{
            print "0  ";
        }
    }
    print "\n";
}
#Imprime o vetor de memória
sub printaMem{
    my $self = shift;
    my $ln = scalar @{$self->{vectorMem}};
    print "Itens no Vetor = $ln \n";
    my $ind = 0;
    for (; $ind < $ln; $ind++){
        if ($self->{vectorMem}[$ind]) {
            print "$self->{vectorMem}[$ind]    ";
        }
        else{
            print "0  ";
        }
    }
    print "\n";
}
1;
