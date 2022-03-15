#Análise exploratório das classes
#pacotes
library(ggplot2)
library(dplyr)

#Carrega a amostra
amostras = read.table('F:/GEO/R/PDI_com_R_2022/Módulo 5 - Processamento/Amostras/amostras_extraidas.csv', header = T, sep = ',')[,-1]
#Visualiza o objeto
amostras

#1) Calcular o espectro de reflectância média para cada classe
#Agrupa os dados da amostra por classe
agrupado = group_by(amostras, Classe)

#Calcula a média de reflectância de cada banda
media_ref = summarise_each(agrupado, mean)
print(media_ref)

#2) Cria gráficos
#Calculo da matriz transposta
refs = t(media_ref[,2:10])

#Recebe cores pré-definidas
cores = c("yellow", "blue", "green", "darkgreen", "orange", "brown", "pink")

#Recebe os comprimentos de onda médios de cada faixa
wavelength = c(490, 560, 660, 705, 740, 770, 850, 1600, 2200)

#2.1) Plota o gráfico de comportamento espectral de cada classe
matplot(x = wavelength, y = refs, type = 'l', lwd = 2, lty = 1,
        xlab = "Comprimento de onda (nm)", ylab = "Reflectancia x10000", col = cores, ylim = c(0,8000))

#Adiciona legenda
legend('top', legend = media_ref$Classe, lty = 1, col = cores, ncol = 3, lwd = 4)


#2.2) Cria um boxplot para cada classe cada banda/índice usando o ggplot2
#Carrega o pacote necessário
require(reshape2)

#Junta dados em uma tabela longa, utilizada na criação de gráficos
dados.melt = melt(amostras)

#Configura o boxplot
ggplot(data = dados.melt, aes(Classe, value, fill = Classe)) + 
  geom_boxplot() + 
  facet_wrap(~variable, scale = 'free') + 
  theme(panel.grid.major = element_line(colour = "#d3d3d3"),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        text=element_text(family = "Tahoma"),
        axis.title = element_text(face="bold", size = 10),
        axis.text.x = element_text(colour="white", size = 0),
        axis.text.y = element_text(colour="black", size = 10),
        axis.line = element_line(size=1, colour = "black")) +
  theme(plot.margin = unit(c(1,1,1,1), "lines"))
