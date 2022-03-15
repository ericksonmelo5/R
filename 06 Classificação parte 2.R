#Classificação de imagens por Random Forest e SVM
#Carrega os pacotes
library(dplyr)
library(randomForest)
library(e1071)
library(caret)

#Carrega o arquivo CSV de treino (sem a primeira coluna)
treino = read.table('Classificação/dados_treino.csv', header = T, sep = ',')[,-1]
#Mostra as primeiras linhas do objeto
head(treino)
#Converte para fator
treino$Classe = as.factor(treino$Classe)
#Carrega o arquivo CSV de validação (sem a primeira coluna)
valid = read.table('Classificação/dados_valid.csv', header = T, sep = ',')[,-1]
#Mostra as primeiras linhas do objeto
head(valid)
#Converte para fator
valid$Classe = as.factor(valid$Classe)

#1) Random Forest (observar os nomes das colunas para escrever igual)
#Fixa valores aleatórios
set.seed(1234)

#O Random Forest pode ser utilizado relacionando a variável dependente com quaisquer outras ou com todas as outras 
#No exemplo abaixo a variável Classe está relacionada com as variáveis b02, b03 e NDVI
#RF = randomForest(Classe~b02+b03+NDVI)
# Por sua vez, no exemplo abaixo o . significa que a variável dependente (Classe) está relacionada a todas as variáveis
#ntree recomendado no máximo 500; e ntry geralmente é a raiz quadrada da quantidade de variáveis
RF = randomForest(Classe~., data = treino, ntree = 100, mtry = 6, importance = T)

#Plota as variáveis de importância, isto é, aquelas consideradas mais influentes pelo modelo
varImpPlot(RF)
#ou
importance(RF)

#2) SVM
#Fixa valores aleatórios
set.seed(1234)
#Pode-se testar outros kernels  (ver documentação da função svm)
SVM = svm(Classe~., kernel = 'polynomial', data = treino)

#Valida os modelos: aplica o modelo treinado aos dados de validação 
pred.RF = predict(RF, valid)
pred.SVM = predict(SVM, valid)

#Cria as matrizes de confusão
CM.RF = confusionMatrix(data = pred.RF, reference = valid$Classe)
CM.SVM = confusionMatrix(data = pred.SVM, reference = valid$Classe)

#Visualiza a matriz de confusão
print(CM.RF)
print(CM.SVM)

#Salva os modelos
saveRDS(object = RF, file = "Classificação/classificacao_rf.rds")
saveRDS(object = SVM, file = "Classificação/classificacao_svm.rds")