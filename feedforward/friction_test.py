import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

def merge(list1, list2):
    merged_list = tuple(zip(list1, list2))
    return merged_list

data=pd.read_excel(r'C:\Users\yp\Desktop\tufts\thesis\data.xlsx',engine='openpyxl')
entry_tension = data['entry_tension'].tolist()
friction_coeff=data['friction_coefficient'].tolist()
a=merge(entry_tension,friction_coeff)
b=exit_tension=data['exit_tension'].tolist()
ans=b.pop()
print(ans/200)

# a= testing sum, b=result
a=np.array(a,dtype=float)#input
b=np.array(b,dtype=float).reshape(len(b),1) #output

# scale training data
a=a/np.max(a,axis=0)
b=b/200

# split training data and testing data
a_train=np.split(a,[len(a)-1])[0]
a_test=np.split(a,[len(a)-1])[1]

class network(object):
    def __init__(self):
    #parameters
        self.inputSize=2
        self.outputSize=1
        self.hiddenSize=10

    # generating weights
        self.w1=np.random.randn(self.inputSize,self.hiddenSize)
        self.w2=np.random.randn(self.hiddenSize,self.outputSize)

    def forward(self, X):
        # forward propagation through our network
        self.z = np.dot(X, self.w1)  # dot product of X (input) and first set of 3x2 weights
        self.z2 = self.sigmoid(self.z)  # activation function
        self.z3 = np.dot(self.z2, self.w2)  # dot product of hidden layer (z2) and second set of 3x1 weights
        o = self.sigmoid(self.z3)  # final activation function
        return o

    def sigmoid(self, s):
        # activation function
        return 1 / (1 + np.exp(-s))

    def sigmoidPrime(self,s):
        return s*(1-s)

    def backward(self,a,b,o): # a=input, b=actual results, o=predicted result
        self.o_error=b-o
        self.o_delta=self.o_error*self.sigmoidPrime(o)

        self.h2_error=self.o_delta.dot(self.w2.T)

        self.h2_delta=self.h2_error*self.sigmoidPrime(self.z2)
        self.w1+=a.T.dot(self.h2_delta) # adjust input->hidden
        self.w2+=self.z2.T.dot(self.o_delta) #adjust hidden->output

    def train(self,a,b):
        o=self.forward(a)
        self.backward(a,b,o)

nn = network()
msq=[]
for i in range(1000): # trains the nn 1,000 times
  nn.train(a_train,b)
  msq.append(np.mean(np.square(b - nn.forward(a_train))))


print("Input: \n" + str(a_train))
print("Actual Output: \n" + str(b))
print("Predicted Output: \n" + str(nn.forward(a_train)))
print("Input (scaled): \n" + str(a_test))
print("Output: \n" + str(nn.forward(a_test)))
print('mean square error: \n' + str(msq[len(msq)-1]))

print('real error percentage: \n'+str((ans/200-nn.forward(a_test))/(ans/200)))
plt.plot(msq)
plt.show()
