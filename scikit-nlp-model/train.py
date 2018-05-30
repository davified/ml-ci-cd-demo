import os, pickle
from data_loader import get_data_and_labels
from sklearn.feature_extraction.text import CountVectorizer, TfidfTransformer
from sklearn.model_selection import train_test_split

current_dir  = os.path.dirname(os.path.abspath(__file__))
texts, labels, _ = get_data_and_labels('{}/data/review_400000_samples.json'.format(current_dir))

data_train, data_val, labels_train, labels_val = train_test_split(texts, labels, random_state=0)

# Train model
from sklearn.ensemble import RandomForestClassifier
from sklearn.pipeline import Pipeline

text_clf = Pipeline([('vect', CountVectorizer()),
                     ('tfidf', TfidfTransformer()),
                     ('clf', RandomForestClassifier())
                    ])
text_clf = text_clf.fit(data_train, labels_train)

# Export the model to a file
build_directory='build'
if not os.path.exists(build_directory):
    os.makedirs(build_directory)
pickle.dump(text_clf, open('./{}/model.pkl'.format(build_directory), 'wb'))

print('Model trained and saved at {}/{}'.format(os.getcwd(), build_directory))
