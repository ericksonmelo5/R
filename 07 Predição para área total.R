#Predi��o para �rea total (quantifica��o dos valores classificados)
#Carrega os pacotes
library(raster)
library(randomForest)
library(e1071)
library(caret)
library(prettymapr)

#Carrega os modelos
RF = readRDS('Classifica��o/classificacao_rf.rds')
SVM = readRDS('Classifica��o/classificacao_svm.rds')

#Carrega os rasters empilhados
img = stack('F:/GEO/R/PDI_com_R_2022/M�dulo 4 - Pr�-processamento/Dados_curso/Imagens_sentinel/Imagem_Recortada_Botucatu/botucatu_com_IV.tif')
#Mostra os t�tulos das colunas do objeto 'img'
names(img)

#Carrega os nomes das bandas pr�-salvo
nomes = read.table('F:/GEO/R/PDI_com_R_2022/M�dulo 4 - Pr�-processamento/Dados_curso/Imagens_sentinel/Imagem_Recortada_Botucatu/nomes_bandas.csv', header=T, sep = ',')
#Mostra os t�tulos das colunas do objeto 'nomes'
names(nomes)

#Atribui os nomes �s bandas
names(img) = nomes[,2]
#Mostra os t�tulos das colunas do objeto 'img'
names(img)

#Prediz para o raster a partir de um modelo ajustado (executa a predi��o do modelo no raster)
RF.raster = predict(img, RF)
SVM.raster = predict(img, SVM)

###Plotagem do raster
#Define as coras
cores = c("yellow", "blue", "pink","green","darkgreen", "orange","brown")

#Define nomes das classes para legenda
classes = c("Agricultura", "�gua", "�rea Urbana", "Eucalipto", "Floresta", "Pastagem", "Solo Exposto")

#Cria um jpeg da aplica��o do Random Forest
jpeg(filename = "Classifica��o/RF_class.jpeg", width = 15, height = 15, res = 200, units = 'in')
plot(RF.raster, legend = F, col = cores, main = "Classifica��o Random Forest \n Botucatu - SP",
     cex.axis = 1.5, cex.main = 1.5)
legend('topleft', legend = classes, fill = cores, border = F, cex = 2)
addscalebar()
addnortharrow(cols = c("black",'black'), scale = 0.755)
dev.off()

#Cria um jpeg da aplica��o do SVM
jpeg(filename = "Classifica��o/SVM_class.jpeg", width = 15, height = 15, res = 200, units = 'in')
plot(SVM.raster, legend = F, col = cores, main = "Classifica��o SVM \n Botucatu - SP",
     cex.axis = 1.5, cex.main = 1.5)
legend('topleft', legend = classes, fill = cores, border = F, cex = 2)
addscalebar()
addnortharrow(cols = c("black",'black'), scale = 0.755)
dev.off()

#Salva os rasters
writeRaster(RF.raster, 'Classifica��o/RF.class.tiff')
writeRaster(SVM.raster, 'Classifica��o/SVM.class.tiff')