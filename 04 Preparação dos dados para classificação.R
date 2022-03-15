#Processamento
#Carrega pacotes
library(raster)
library(rgdal)
library(rgeos)

#Carrega os dados
img = stack("F:/GEO/R/PDI_com_R_2022/Módulo 4 - Pré-processamento/Dados_curso/Imagens_sentinel/Imagem_Recortada_Botucatu/botucatu_com_IV.tif")
#Mostra os nomes dos rasters empilhados
names(img)

#Importa CSV com os nomes das bandas
nomes_bandas = read.table('F:/GEO/R/PDI_com_R_2022/Módulo 4 - Pré-processamento/Dados_curso/Imagens_sentinel/Imagem_Recortada_Botucatu/nomes_bandas.csv', header = T, sep = ',')
print(nomes_bandas)

#Coloca o nome das bandas de acordo com a segunda coluna do CSV
names(img) = nomes_bandas[,2]

#Importa amostras
amostras = readOGR("F:/GEO/R/PDI_com_R_2022/Módulo 5 - Processamento/Amostras/amostras.shp")
View(data.frame(amostras))

#Une as linhas por classe temática
unidos.shp = gUnaryUnion(spgeom = amostras, id = amostras$Classe)
unidos.shp

#Extrai atributos do raster para o SHP (a contagem passa a ser por  nº de pixels e não mais de polígono em cada classe)
atributos = raster::extract(x = img, y = unidos.shp)

#Coloca os nomes das classes nos atributos
#Mostra os nomes das colunas do objeto 'unidos.shp'
names(unidos.shp)

#Cria data frames separados por classe
Agricultura = data.frame(Classe = "Agricultura", atributos[[1]])
Agua = data.frame(Classe = "Agua", atributos[[2]])
Area_Urbama = data.frame(Classe = "Area Urbana", atributos[[3]])
Eucalipto = data.frame(Classe = "Eucalipto", atributos[[4]])
Floresta = data.frame(Classe = "Floresta", atributos[[5]])
Pastagem = data.frame(Classe = "Pastagem", atributos[[6]])
Solo_Exposto = data.frame(Classe = "Solo Exposto", atributos[[7]])

#Une os data frames
amostras.final = rbind(Agricultura, Agua, Area_Urbama, Eucalipto, Floresta, Pastagem, Solo_Exposto)

#Salvar como CSV
write.csv(amostras.final, "F:/GEO/R/PDI_com_R_2022/Módulo 5 - Processamento/Amostras/amostras_extraidas.csv")
