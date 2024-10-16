  #Função recursiva para calcular o VPL

vpl_recursiva <- function(fluxo_caixa, taxa, tempo = 0){
  if (tempo == length(fluxo_caixa)) {
    return(0)
  }
  
  vpa <- fluxo_caixa[tempo + 1] / (1 + taxa)^tempo
    return(vpa + vpl_recursiva(fluxo_caixa, taxa, tempo + 1))
}

  #Vetor de fluxo de caixa aleatório
set.seed(123)
fluxo_caixa <- rnorm(100, mean = 5000, sd = 1000)

  #Armazenando os resultados
resultados <- data.frame(Taxa = numeric(0), VPL = numeric(0))

  #Calculando o VPL para cada taxa de desconto
for (taxa in seq(0.01, 0.10, by = 0.01)) {
  vpl <- vpl_recursiva(fluxo_caixa, taxa)
  resultados <- rbind(resultados, data.frame(Taxa = taxa, VPL = vpl))
}

  #Função para formatar os valores com o mesmo número de casas decimais
formatar_val <- function(taxa, vpl) {
  sprintf("Taxa: %.2f%%, VPL: %.2f", taxa * 100, vpl)
}

  #Criando uma tabela formatada para exibir os resultados
df_formatado <- data.frame(Resultado = apply(resultados, 1, function(x) {
  formatar_val(x[1], x[2])
}))

   #Exibe a tabela com as taxas e os VPLs formatados
library(knitr)
kable(df_formatado, 
      align = "c", 
      col.names = c("Resultado (Taxa e VPL)"))