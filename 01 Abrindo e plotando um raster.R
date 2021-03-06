#Define o diret�rio para uma �rea de trabalho do R
setwd("F:/GEO/R/PDI_com_R_2022/M�dulo 4 - Pr�-processamento/Dados_curso/Imagens_sentinel/Imagem_Bruta")

#Carrega os pacotes
library(raster)
library(rgdal)
library(sp)
library(terra)

#Carrega a imagem
b5 = raster("T22KGV_20210104T132231_B05_20m.jp2")
#Plota a imagem
plot(b5)
#Plota a imagem em n�veis de cinza
plot(b5, col = gray(1:100/100))

#importa v�rios arquivos de uma vez
#um de cada vez: all_bands = stack(diret�rios para os arquivos)
#v�rios de uma vez:
arquivos = list.files("F:/GEO/R/PDI_com_R_2022/M�dulo 4 - Pr�-processamento/Dados_curso/Imagens_sentinel/Imagem_Bruta",
                      pattern = "_B", full.names = T)

#visualiza o objeto 'arquivos'
arquivos
all_bands = stack(arquivos)
all_bands

#Mostra o nome e o �ndice de cada banda:
names(all_bands)

#Plota a composi��o colorida (de acordo com a ordem de empilhamento das bandas)
plotRGB(all_bands, r = 3, g = 2, b = 1, axes = T, stretch = 'lin', main = "Sentinel Cor Verdadeira") 
plotRGB(all_bands, r = 9, g = 2, b = 1, axes = T, stretch = 'lin', main = "Sentinel Falsa Cor") 
plotRGB(all_bands, r = 9, g = 3, b = 2, axes = T, stretch = 'lin', main = "Sentinel Falsa Cor 2") 

#Define um recorte
recorte = crop(all_bands, extent(780000, 800000, 7460000, 7490000))

#Plota a imagem recortada
plotRGB(recorte, r = 9, g = 3, b = 2, axes = T, stretch = 'lin', main = "Sentinel Falsa Cor 2") 
plotRGB(recorte, r = 9, g = 2, b = 1, axes = T, stretch = 'lin', main = "Sentinel Falsa Cor") 
