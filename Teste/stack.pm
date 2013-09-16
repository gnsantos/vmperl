#o "strict" te obriga a declarar todas as variáveis - ou seja, se quiser fazer variável global, 
#deve usar "our", e para fazer variáveis locais, deve fazer "my".
#Isso é um "pragma" do Perl, que funciona como uma "diretiva de compilação" para a linguagem. 
#Vai te evitar problemas de criar variáveis sem querer (o "espirra e cria uma variável" do Gubi)
#
#By The Lord of The Perl (Renatão)
#
use v5.12;
use strict;
use warnings;
use operation;
package stack ;
#Construtor da Classe package
sub new {
    my $class= shift;
    my $self = {
        labels => {},
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
	    #indx => 0
    };
    my $new = new operation();
    $self->{opera} = $new;
    # Print all the values just for clarification.
    bless $self, $class;
    return $self;

}

# sub newOpt{
#     my $self = shift;
#     my $new = new operation();
#     $self->{opera} = $new;
# }
sub insertLabel{
    my $self = shift;
    my $addres = shift;
    my $value = shift;
    $self->{labels}->{$addres} = $value;

    # print "($addres -x- $self->{labels}->{$addres}) \n";
}

sub retPC{
    my $self = shift;
    return $self->{PC};
}

sub nextInstruction{
    my $self = shift;
    $self->{PC} += 1;
}

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
            # if ($result == 0) {print ">> Resultado : 0\n";}
            # else{print ">> Resultado : $result \n";}
            pile($self,$result);            
        }
        else{
            # print "Chave NOT\n";
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
#Troca os item do topo com o que está abaixo

sub jmpInstruction{
    my $self = shift;
    my $addres = shift;
    my $temp = $self->{labels}->{$addres};
    print "Valor do Temp : $temp\n";
    $self->{PC} = $temp;
}

sub falseStk{
    my $self = shift;
    my $arg = shift;
    my $top = showTop($self);
    if ($top == 0){ jmpInstruction($self,$arg) }
    else { removeItem($self);} 
}
sub trueStk{
    my $self = shift;
    my $arg = shift;
    my $top = showTop($self);
    if ($top != 0){ jmpInstruction($self,$arg) }
    else { removeItem($self);} 
}

sub shiftStack{
    my $self = shift;
    my $val1 = pop(@{$self->{lista}});
    my $val2 = pop(@{$self->{lista}});
    push (@{$self->{lista}}, $val1);
    push (@{$self->{lista}}, $val2);
    #print ">>>> Val1 == $val1 xxxxx Val2 == $val2";
}
#empilha o elemento Vi do vetor de dados na pilha
sub pushMem{
    my $self = shift;
    my $pos = shift;
    my $value = $self->{vectorMem}[$pos];
    push (@{$self->{lista}}, $value);

}

sub storeMem{
    my $self = shift;
    my $indx = shift;
    my $temp = unstack($self);
    $self->{vectorMem}[$indx] = $temp;
    # print "#$indx = $self->{vectorMem}[$indx]\n"
}
#Empilha no topo da pilha
sub pile{

    my ($self, $Item) = @_;
    #print "vak = $Item \n";
    push (@{$self->{lista}}, $Item);
    #$self->{indx}++;
}
#Remove o topo da pilha
sub removeItem{
    my $self = shift;
    pop(@{$self->{lista}});
}

sub prnOp{
    my $item = &removeItem;
    print "$item\n"; 
}

#Duplica o topo da pilha
sub dup{
    my $self = shift;
    my $temp = showTop($self);
    #push (@{$self->{lista}}, $temp);
    push (@{$self->{lista}}, $temp);

}
#Remove o topo e retorna o item
sub unstack{
    my $self = shift;
    #$l = $self->{lista};
    #print "valor de l = $l \n";
    #$k = $self->{lista}[$l - 1];
    #print "Valor de k = $k \n\n";
    #$self->{indx}--;
    return pop(@{$self->{lista}});
}

#Imprime a pilha
sub printaStack{
    my $self = shift;
    my $ln = scalar @{$self->{lista}};
    print "Itens na Pilha = $ln \n";
    print ("\n");
    my $indx = 0;
    for (; $indx < $ln; $indx++){
        if ($self->{lista}[$indx]) {
            print ">>#$indx $self->{lista}[$indx]\n";
        }
        else{print ">>#$indx 0\n";}
    }
}

sub printaMem{
    my $self = shift;
    my $ln = scalar @{$self->{vectorMem}};
    print ("\n");
    my $ind = 0;
    for (; $ind < $ln; $ind++){
	print ">> $self->{vectorMem}[$ind]";	
    }
}
1;
