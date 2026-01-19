class AutomatoFinitoDeterminista:
    def __init__(self, estados, alfabeto, ftransicao, estado_inicial, estados_finais):
        self.estados = estados
        self.alfabeto = alfabeto
        self.ftransicao = ftransicao
        self.estado_inicial = estado_inicial
        self.estado_atual = estado_inicial
        self.estados_finais = estados_finais

    def reset(self):
        self.estado_atual = self.estado_inicial

    def debug(self):
        print(f"Estado atual: {self.estado_atual}")

    def process_input(self, input_sequence):
        for i, simb in enumerate(input_sequence):
            if simb not in self.alfabeto:
                print(f"'{simb}' não pertence ao alfabeto da linguagem.")
                print("Vou ignorar e continuar.")
            
            elif self.estado_atual not in self.ftransicao or simb not in self.ftransicao[self.estado_atual]:
                print(f"Não há transição possível para o estado '{self.estado_atual}' com o símbolo '{simb}'.")
                print(f"O símbolo '{simb}' na posição {i+1} está a provocar o erro.")
            else:
                self.estado_atual = self.ftransicao[self.estado_atual][simb]

        return self.estado_atual in self.estados_finais