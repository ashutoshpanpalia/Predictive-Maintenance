import pandas as pd
import numpy as np

df      = pd.read_csv("200_dataset.csv")
df_test = pd.read_csv("200.csv")
df_Y    = df.status_group #Target
df_X    = df.drop('status_group',axis='columns')
df_X    = df_X.drop('scheme_name',axis='columns')
#df_X    = df_X.drop('id',axis='columns')

#List of columns with correlation more than 0.9
col     = ['lga','extraction_type_group','region_code','extraction_type_class','management_group','source_type','source_class','quality_group','payment_type','latitude','district_code','longitude']
df_X    = df_X.drop(col,axis='columns')
df_test = df_test.drop('scheme_name',axis='columns')
df_test = df_test.drop(col,axis='columns')
#df_test = df_test.drop('id',axis='columns')

#One Hot Encoding Sklearn
from sklearn.preprocessing import LabelEncoder
from sklearn.preprocessing import OneHotEncoder
le = LabelEncoder()# Assigning numerical values and storing in another column
i=0
categories = df_X.columns
num_cat = df_X._get_numeric_data().columns
for col in categories:
    if col in num_cat :
       i=i+1
    else:
        df_X[col]    = le.fit_transform(df_X[col].astype(str))
        df_test[col] = le.fit_transform(df_test[col].astype(str))
        enc          = OneHotEncoder(handle_unknown='ignore')
        enc_df       = pd.DataFrame(enc.fit_transform(df_X[[col]]).toarray())
        df_test      = pd.concat([df_test,enc_df],axis='columns')
        df_test      = df_test.drop(col,axis='columns')
        df_X         = pd.concat([df_X,enc_df],axis='columns')
        df_X         = df_X.drop(col,axis='columns')

from sklearn.preprocessing import StandardScaler
sc = StandardScaler()
X = df_X.values
X[:,:] = sc.fit_transform(X[:,:])
Y=df_Y.values

#Model Creation
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
rf = RandomForestClassifier(n_estimators=200,class_weight= {'functional':1 , 'non functional':1, 'functional needs repair':2.5},criterion='entropy')# Train the model on training data
rf.fit(X,Y)
pred=rf.predict(X)
acc=accuracy_score(pred,Y)
print(acc)


#df_test
df_test = df_test.dropna()#To drop the extra rows involved after OneHotEncoding
#from sklearn.preprocessing import StandardScaler
#sc = StandardScaler()
X = df_test.values
X[:,:] = sc.fit_transform(X[:,:])
a=rf.predict(X)
print(a)
dataframe=pd.DataFrame(a)
import xlsxwriter
dataframe.to_excel(excel_writer="C:/Users/Ashutosh/Desktop/Predictive maintenance/Model/FINAL/output.xlsx")
