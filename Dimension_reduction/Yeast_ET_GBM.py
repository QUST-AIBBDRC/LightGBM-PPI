import numpy as np
import pandas as pd
import scipy.io as sio
import lightgbm as lgb
from sklearn.feature_selection import SelectFromModel
from sklearn.preprocessing import scale,StandardScaler
from L1_Matine import selectFromExtraTrees
from sklearn.metrics import roc_curve, auc
from sklearn.model_selection import StratifiedKFold
#from LR_test import logistic_LR
import utils.tools as utils

data_train = sio.loadmat(r'G:\4_Yeast.mat')
data=data_train.get('Yeast_new_GBM')#
row=data.shape[0]
column=data.shape[1]
index = [i for i in range(row)]
np.random.shuffle(index)
index=np.array(index)
data_=data[index,:]
shu=data_[:,np.array(range(1,column))]
#shu=scale(shu)#
label=data_[:,0]
label[label==0]=-1

data_5,importance=selectFromExtraTrees(shu,label)

X=data_5
label[label==-1]=0
y=label
sepscores = []
skf= StratifiedKFold(n_splits=5)
for train, test in skf.split(X,y): 
    gbm = lgb.LGBMClassifier(n_estimators=100,max_depth=5,learning_rate=0.2)
    hist=gbm.fit(X[train], y[train],eval_set=[(X[test], y[test])])
    #utils.plothistory(hist)
    #prediction probability
    y_score=gbm.predict_proba(X[test])
    y_test=utils.to_categorical(y[test])    
    fpr, tpr, _ = roc_curve(y_test[:,0], y_score[:,0])
    roc_auc = auc(fpr, tpr)
    y_class= utils.categorical_probas_to_classes(y_score)
    y_test_tmp=y[test]
    acc, precision,npv, sensitivity, specificity, mcc,f1 = utils.calculate_performace(len(y_class), y_class, y_test_tmp)
    sepscores.append([acc, precision,npv, sensitivity, specificity, mcc,f1,roc_auc])
    gbm=[]
    print('gbm:acc=%f,precision=%f,npv=%f,sensitivity=%f,specificity=%f,mcc=%f,f1=%f,roc_auc=%f'
          % (acc, precision,npv, sensitivity, specificity, mcc,f1, roc_auc))
scores=np.array(sepscores)
print("acc=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[0]*100,np.std(scores, axis=0)[0]*100))
print("precision=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[1]*100,np.std(scores, axis=0)[1]*100))
print("npv=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[2]*100,np.std(scores, axis=0)[2]*100))
print("sensitivity=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[3]*100,np.std(scores, axis=0)[3]*100))
print("specificity=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[4]*100,np.std(scores, axis=0)[4]*100))
print("mcc=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[5]*100,np.std(scores, axis=0)[5]*100))
print("f1=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[6]*100,np.std(scores, axis=0)[6]*100))
print("roc_auc=%.2f%% (+/- %.2f%%)" % (np.mean(scores, axis=0)[7]*100,np.std(scores, axis=0)[7]*100))
result1=np.mean(scores,axis=0)
#result=np.array(result1,result2)
#result=np.append(result1,result2)
H1=result1.tolist()
sepscores.append(H1)
#result=np.array(sepscores)
result=sepscores
#np.savetxt('result.txt',sepscores)
#np.savetxt('result_yeast_100_LR_1.5_10.txt',mask_5)
data_csv = pd.DataFrame(data=result)






	
	