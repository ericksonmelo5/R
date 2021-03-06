#Classifica��o de imagens por Random Forest e SVM
#Carrega os pacotes
library(dplyr)
library(randomForest)
library(e1071)
library(caret)

#Carrega o arquivo CSV de treino (sem a primeira coluna)
treino = read.table('Classifica��o/dados_treino.csv', header = T, sep = ',')[,-1]
#Mostra as primeiras linhas do objeto
head(treino)
#Converte para fator
treino$Classe = as.factor(treino$Classe)
#Carrega o arquivo CSV de valida��o (sem a primeira coluna)
valid = read.table('Classifica��o/dados_valid.csv', header = T, sep = ',')[,-1]
#Mostra as primeiras linhas do objeto
head(valid)
#Converte para fator
valid$Classe = as.factor(valid$Classe)

#1) Random Forest (observar os nomes das colunas para escrever igual)
#Fixa valores aleat�rios
set.seed(1234)

#O Random Forest pode ser utilizado relacionando a vari�vel dependente com quaisquer outras ou com todas as outras 
#No exemplo abaixo a vari�vel Classe est� relacionada com as vari�veis b02, b03 e NDVI
#RF = randomForest(Classe~b02+b03+NDVI)
# Por sua vez, no exemplo abaixo o . significa que a vari�vel dependente (Classe) est� relacionada a todas as vari�veis
#ntree recomendado no m�ximo 500; e ntry geralmente � a raiz quadrada da quantidade de vari�veis
RF = randomForest(Classe~., data = treino, ntree = 100, mtry = 6, importance = T)

#Plota as vari�veis de import�ncia, isto �, aquelas consideradas mais influentes pelo modelo
varImpPlot(RF)
#ou
importance(RF)

#2) SVM
#Fixa valores aleat�rios
set.seed(1234)
#Pode-se testar outros kernels  (ver documenta��o da fun��o svm)
SVM = svm(Classe~., kernel = 'polynomial', data = treino)

#Valida os modelos: aplica o modelo treinado aos dados de valida��o 
pred.RF = predict(RF, valid)
pred.SVM = predict(SVM, valid)

#Cria as matrizes de confus�o
CM.RF = confusionMatrix(data = pred.RF, reference = valid$Classe)
CM.SVM = confusionMatrix(data = pred.SVM, reference = valid$Classe)

#Visualiza a matriz de confus�o
print(CM.RF)
print(CM.SVM)

#Salva os modelos
saveRDS(object = RF, file = "Classifica��o/classificacao_rf.rds")
saveRDS(object = SVM, file = "Classifica��o/classificacao_svm.rds")