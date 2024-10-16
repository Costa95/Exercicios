class Investimento:
    def __init__(self, nome, quantidade, valor_por_unidade):
        self.nome = nome
        self.quantidade = quantidade
        self.valor_por_unidade = valor_por_unidade
  
    def valor_total(self):
        return self.quantidade * self.valor_por_unidade
  
    def __str__(self):
        return f"{self.nome}: {self.quantidade} unidades a R${self.valor_por_unidade:.2f} cada"
  
class Acao(Investimento):
    def __init__(self, nome, quantidade, valor_por_unidade, dividendos):
        super().__init__(nome, quantidade, valor_por_unidade)
        self.dividendos = dividendos
  
    def valor_total(self):
        return super().valor_total() + self.dividendos
  
    def __str__(self):
        return super().__str__() + f", Dividendos: R${self.dividendos:.2f}"
  
class Titulo(Investimento):
    def __init__(self, nome, quantidade, valor_por_unidade, taxa_juros):
        super().__init__(nome, quantidade, valor_por_unidade)
        self.taxa_juros = taxa_juros
    
    def __str__(self):
        return super().__str__() + f", Taxa de Juros: {self.taxa_juros * 100:.2f}%"
    
class FundoMutuo(Investimento):
    def __init__(self, nome, quantidade, valor_por_unidade, taxa_administracao):
        super().__init__(nome, quantidade, valor_por_unidade)
        self.taxa_administracao = taxa_administracao
    
    def __str__(self):
        return super().__str__() + f", Taxa de Administração: {self.taxa_administracao * 100:.2f}%"
    
class Portfolio:
    def __init__(self):
        self.investimentos = []
    
    def adicionar_investimento(self, investimento):
        self.investimentos.append(investimento)
    
    def remover_investimento(self, nome):
        for investimento in self.investimentos:
            if investimento.nome == nome:
                self.investimentos.remove(investimento)
                return f"{nome} removido do portfólio."
        return f"{nome} não encontrado no portfólio."
    
    def valor_total(self):
        return sum(investimento.valor_total() for investimento in self.investimentos)
    
    def relatorio(self):
        relatorio = "Resumo do Portfólio:\n"
        for investimento in self.investimentos:
            relatorio += str(investimento) + "\n"
        relatorio += f"Valor total do portfólio: R${self.valor_total():.2f}"
        return relatorio
    
#Função para coletar dados do usuário
def coletar_dados_investimento():
    tipo = input("Digite o tipo de investimento (acao, titulo, fundo): ").strip().lower()
    nome = input("Digite o nome do investimento: ").strip()
    quantidade = int(input("Digite a quantidade: "))
    valor_por_unidade = float(input("Digite o valor por unidade (utilizando o ponto como vírgula): "))
        
    if tipo == "acao":
        dividendos = float(input("Digite o valor dos dividendos: "))
        return Acao(nome, quantidade, valor_por_unidade, dividendos)
    elif tipo == "titulo":
        taxa_juros = float(input("Digite a taxa de juros (utilizando decimal com ponto): "))
        return Titulo(nome, quantidade, valor_por_unidade, taxa_juros)
    elif tipo == "fundo":
        taxa_administracao = float(input("Digite a taxa de administração (utilizando decimal com ponto): "))
        return FundoMutuo(nome, quantidade, valor_por_unidade, taxa_administracao)
    else:
        print("Tipo de investimento inválido.")
        return None

#Simulação e Testes
if __name__ == "__main__":
    portfolio = Portfolio()
        
    while True:
        print("\nMenu:")
        print("1. Adicionar Investimento")
        print("2. Remover Investimento")
        print("3. Exibir Relatório do Portfólio")
        print("4. Sair")
        
        opcao = input("Escolha uma opção: ").strip()
        
        if opcao == "1":
            investimento = coletar_dados_investimento()
            if investimento:
                portfolio.adicionar_investimento(investimento)
                print(f"{investimento.nome} adicionado ao portfólio.")
        elif opcao == "2":
            nome = input("Digite o nome do investimento a ser removido: ")
            print(portfolio.remover_investimento(nome))
        elif opcao == "3":
            print(portfolio.relatorio())
        elif opcao == "4":
            print("Saindo...")
            break
        else:
            print("Opção inválida. Tente novamente.")          
  