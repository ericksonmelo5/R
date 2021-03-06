#Recorte para a �rea de interesse
#Define o diret�rio para a �rea de trabalho o R
setwd("F:/GEO/R/PDI_com_R_2022/M�dulo 4 - Pr�-processamento/Dados_curso/Imagens_sentinel/Imagem_Bruta")

#Carrega os pacotes necess�rios
library(rgdal)
library(raster)
library(sp)

#Carrega imagens
arq = list.files("F:/GEO/R/PDI_com_R_2022/M�dulo 4 - Pr�-processamento/Dados_curso/Imagens_sentinel/Imagem_Bruta",
                      pattern = "_B", full.names = T)
#Empilha as imagens
img = stack(arq)

#Carrega o SHP
botucatu = readOGR("F:/GEO/R/PDI_com_R_2022/M�dulo 4 - Pr�-processamento/Dados_curso/Shapefiles_classificacao/MunicipioBotucatu/Botucatu.shp")
plot(botucatu)

#Mostra o sistema de coordenadas dos dados
crs(img)
crs(botucatu)

#Converte o SRC
botucatu.utm = spTransform(x=botucatu, CRSobj = crs(img))
crs(botucatu.utm)

#Recorta por m�scara
botucatu.mask = mask(x = img, mask = botucatu.utm)

#Recorta o recorte (para ajustar ao novo ret�ngulo envolvente)
botucatu.crop = crop(botucatu.mask, botucatu.utm)

#Mostra as imagens recortadas pelas fun��es 'mask' e 'crop' lado a lado 
par(mfrow=c(1,2))
plot(botucatu.mask$T22KGV_20210104T132231_B8A_20m)
plot(botucatu.crop$T22KGV_20210104T132231_B8A_20m)

#Salva a imagem recortada (crop)
writeRaster(x = botucatu.crop, filename = "F:/GEO/R/PDI_com_R_2022/M�dulo 4 - Pr�-processamento/Dados_curso/Imagens_sentinel/Imagem_Recortada_Botucatu/Recorte.tif")
