#Indices de vegetação
#Carrega os pacotes
library(raster)

#Carrega a imagem empilhada
img = stack("F:/GEO/R/PDI_com_R_2022/Módulo 4 - Pré-processamento/Dados_curso/Imagens_sentinel/Imagem_Recortada_Botucatu/Recorte.tif")
#Visualiza o objeto 'img'
img

#Coloca os nomes das bandas no objeto 'img'
names(img) = c("b02", "b03", "b04", "b05", "b06", "b07", "b8A", "b11", "b12") 
names(img)

#verifica se o nome da 8A caiu certo
plot(img$b8A)

#Calcula o NVDI
NDVI = (img$b8A-img$b04)/(img$b8A+img$b04)
#Plota o NDVI
plot(NDVI)

#Visualiza o objeto 'img', que possui 9 layers
img

#Adiciona o NDVI ao stack
img$NDVI = NDVI

#Visualiza o objeto 'img', que agora possui 10 layers
img

#Plota o NDVI
plot(img$NDVI)
#Limpa o dado de NDVI da memória, já que ele está salvo no objeto 'img'
rm(NDVI)


#Otros índices
#Simple Ratio
img$SR = img$b8A/img$b04
#Mostra os nomes das colunas do objeto 'img'
names(img)

#Índice de Vegetação Melhorado - EVI
img$EVI = (2.5*((img$b8A-img$b04)/10000))/(img$b8A/10000+6*img$b04/10000-7.5*img$b02/10000+1)
#Plota o EVI
plot(img$EVI)

#Indice de água por diferença normalizada
img$NDWI = (img$b03-img$b12)/(img$b03+img$b12)
#Plota o NDWI
plot(img$NDWI)

#Plota tudo (4x4)
par(mfrow = c(2,2))
plot(img$NDVI, col = gray(0:100/100), main = "NDVI")
plot(img$SR, col = gray(0:100/100), main = "SR")
plot(img$EVI, col = gray(0:100/100), main = "EVI")
plot(img$NDWI, col = gray(0:100/100), main = "NDWI")

#Plota dois índices
par(mfrow = c(1,2))
plot(img$NDVI, col = gray(0:100/100), main = "NDVI")
plot(img$NDWI, col = gray(0:100/100), main = "NDWI")

#Empilha os apenas os Índices de Vegetação
ivs = stack(img$NDVI, img$SR, img$EVI, img$NDWI)
#Mostra os nomes
names(ivs)

#Salva as imagens empilhadas
writeRaster(x = img, filename = "F:/GEO/R/PDI_com_R_2022/Módulo 4 - Pré-processamento/Dados_curso/Imagens_sentinel/Imagem_Recortada_Botucatu/botucatu_com_IV.tif")

#Salva os nomes das bandas em um objeto para importações futuras
nomes_img = names(img)
write.csv(x = nomes_img, file = "F:/GEO/R/PDI_com_R_2022/Módulo 4 - Pré-processamento/Dados_curso/Imagens_sentinel/Imagem_Recortada_Botucatu/nomes_bandas.csv")

#Salva apenas o empilhamento dos IVs
writeRaster(x = ivs, filename = "F:/GEO/R/PDI_com_R_2022/Módulo 4 - Pré-processamento/Dados_curso/Imagens_sentinel/Imagem_Recortada_Botucatu/botucatu_IVs.tif")