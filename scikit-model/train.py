# import googleapiclient.discovery
import json
import numpy as np
import os
import pandas as pd
import pickle
from sklearn.ensemble import RandomForestClassifier
from sklearn.externals import joblib
from sklearn.preprocessing import LabelEncoder


#### Preprocess data ####
# Define the format of your input data including unused columns.
# (These are the columns from the census data files)
COLUMNS = (
    'age',
    'workclass',
    'fnlwgt',
    'education',
    'education-num',
    'marital-status',
    'occupation',
    'relationship',
    'race',
    'sex',
    'capital-gain',
    'capital-loss',
    'hours-per-week',
    'native-country',
    'income-level'
)

# Categorical columns are columns that need to be turned into a numerical
# value to be used by scikit-learn
CATEGORICAL_COLUMNS = (
    'workclass',
    'education',
    'marital-status',
    'occupation',
    'relationship',
    'race',
    'sex',
    'native-country'
)

# Load the training census dataset
with open('./data/adult.data', 'r') as train_data:
    raw_training_data = pd.read_csv(train_data, header=None, names=COLUMNS)
# Remove the column we are trying to predict ('income-level') from our features list
train_features = raw_training_data.drop('income-level', axis=1)
# Create our training labels list
train_labels = (raw_training_data['income-level'] == ' >50K')

# Load the test census dataset
with open('./data/adult.test', 'r') as test_data:
    raw_testing_data = pd.read_csv(test_data, names=COLUMNS, skiprows=1)
# Remove the column we are trying to predict ('income-level') from our features list
test_features = raw_testing_data.drop('income-level', axis=1)
# Create our training labels list
test_labels = (raw_testing_data['income-level'] == ' >50K.')

# Convert the categorical columns to a numerical value in both the
# training and testing dataset
encoders = {col:LabelEncoder() for col in CATEGORICAL_COLUMNS}

for col in CATEGORICAL_COLUMNS:
    train_features[col] = encoders[col].fit_transform(train_features[col])
    test_features[col] = encoders[col].fit_transform(test_features[col])
  

#### Train model ####
# Create and train a classifier
classifier = RandomForestClassifier()
classifier.fit(train_features, train_labels)

# Export the classifier to a file
pickle.dump(classifier, open('model.pkl', 'wb'))

# Generate 5 sample test data points
with open('test_data.json', 'w') as outfile:
  json.dump(test_features.as_matrix().tolist()[0:5], outfile)
