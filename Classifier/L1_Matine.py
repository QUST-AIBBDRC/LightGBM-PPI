import os
import numpy as np
import pandas as pd
from sklearn.feature_selection import SelectKBest
from sklearn.feature_selection import mutual_info_classif
from sklearn.preprocessing import scale,StandardScaler
from sklearn.preprocessing import normalize,Normalizer
from sklearn.feature_selection import SelectFromModel
from sklearn.linear_model import Lasso,LassoCV
from sklearn.linear_model import ElasticNet,ElasticNetCV
from sklearn.ensemble import ExtraTreesClassifier
from sklearn.svm import LinearSVC,SVC


def mutual_mutual(data,label,k=300):
    model_mutual= SelectKBest(mutual_info_classif, k=k)
    new_data=model_mutual.fit_transform(data, label)
    return new_data
def elasticNet(data,label,alpha =np.array([0.01, 0.02, 0.03,0.04, 0.05, 0.06, 0.07, 0.08,0.09, 0.1])):
    enetCV = ElasticNetCV(alphas=alpha,l1_ratio=0.1,max_iter=2000).fit(data,label)
    enet=ElasticNet(alpha=enetCV.alpha_, l1_ratio=0.1,max_iter=2000)
    enet.fit(data,label)
    mask = enet.coef_ != 0
    new_data = data[:,mask]
    return new_data,mask
def lassodimension(data,label,alpha=np.array([0.001,0.002,0.003,0.004, 0.005, 0.006, 0.007, 0.008,0.009, 0.01])):
    lassocv=LassoCV(cv=5, alphas=alpha,max_iter=2000).fit(data, label)
    x_lasso = lassocv.fit(data,label)
    mask = x_lasso.coef_ != 0 
    new_data = data[:,mask]  
    return new_data,mask 
def selectFromLinearSVC(data,label,lamda):
    lsvc = LinearSVC(C=lamda, penalty="l1", dual=False).fit(data,label)
    model = SelectFromModel(lsvc,prefit=True)
    new_data= model.transform(data)
    return new_data	
def selectFromExtraTrees(data,label):
    clf = ExtraTreesClassifier(n_estimators=100, criterion='gini', max_depth=None, 
                               min_samples_split=2, min_samples_leaf=1, min_weight_fraction_leaf=0.0, 
                               max_features='auto', max_leaf_nodes=None, min_impurity_decrease=0.0, 
                               min_impurity_split=None, bootstrap=False, oob_score=False, n_jobs=1, 
                               random_state=None, verbose=0, warm_start=False, class_weight=None)#entropy
    clf.fit(data,label)
    importance=clf.feature_importances_ 
    model=SelectFromModel(clf,prefit=True)
    new_data = model.transform(data)
    return new_data,importance
