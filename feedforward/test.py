import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.neural_network import MLPRegressor
from sklearn.metrics import accuracy_score
import matplotlib.pyplot as plt

# import data
data=pd.read_csv(r"C:\Users\yp\Desktop\tufts\thesis\data.csv")
x=data[['entry_tension','friction_coefficient']] #input
y=data['exit_tension'] #output

# split sets
x_train,x_test,y_train,y_test=train_test_split(x,y,test_size=0.3) #30% for testing

# mlp regression
mlp=MLPRegressor(shuffle=True,solver='lbfgs',alpha=0.001,hidden_layer_sizes=(10,10))
#print(mlp)

mlp.fit(x_train,y_train)
y_pred=mlp.predict(x_test)
print(y_pred)
print(y_test)
#msq=[]
#for i in range(len(y_pred)):
#    msq.append(np.mean(np.square(y_pred[i]-y_test[i])))



