#Classifica��o das Imagems - Parte 01
#Carrega os pacotes necess�rios
library(dplyr)
library(randomForest)
library(e1071)
library(caret)
library(caTools)

#Carrega o arquivo com as amostras extraidas
dados = read.table('F:/GEO/R/PDI_com_R_2022/M�dulo 5 - Processamento/Amostras/amostras_extraidas.csv', header = T, sep = ',')[,-1]
#Mostra os 5 primeiros registros do objeto
head(dados)

#Checa a estrutura dos dados (precisa estar em formato de fator)
str(dados)
#Converte a estrutura dos dados para o tipo fator
dados$Classe = as.factor(dados$Classe)

###Separa��o dos dados para treinamento e valida��o
#Fixa o sorteio de valores
set.seed(1234)

#Separa dados para treinamento (a fun��o 'sample.split' separa por propor��o de classe (70% de valores de cada classe))
amostras_treino = sample.split(dados$Classe, SplitRatio = 0.7)
#Mostra o objeto 
amostras_treino

#Separa dados de treino (sele��o dos �ndices verdadeiros) e valida��o (sele��o dos �ndices falsos) (teste)
train = dados[amostras_treino,]
valid = dados[amostras_treino == F,]

#Salva os dados em um CSV
write.csv(train, 'Classifica��o//dados_treino.csv')
write.csv(valid, 'Classifica��o//dados_valid.csv')
