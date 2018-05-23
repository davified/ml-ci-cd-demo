import unittest, pickle
import pandas as pd
from sklearn import metrics

from constants import COLUMNS

RECALL_THRESHOLD = 0.1
PRECISION_THRESHOLD = 0.1

class TestModelEvaluation(unittest.TestCase):
  def setUp(self):
    with open("./build/model.pkl",'rb') as model_file:
      self.model = pickle.load(model_file)
    with open('../data/adult.test', 'r') as test_data:
      raw_testing_data = pd.read_csv(test_data, names=COLUMNS, skiprows=1)

    self.test_features = raw_testing_data.drop('income-level', axis=1).as_matrix().tolist()
    self.test_labels = (raw_testing_data['income-level'] == ' >50K.').as_matrix().tolist()

  def test_should_have_recall_score_above_minimum_threshold(self):
    y_predicted = self.model.predict(self.test_features)
    recall = metrics.recall_score(self.test_labels, y_predicted.round())

    self.assertTrue(recall > RECALL_THRESHOLD, "recall of {} is below threshold of {}".format(recall, RECALL_THRESHOLD))

  def test_should_have_precision_score_above_minimum_threshold(self):
    y_predicted = self.model.predict(self.test_features)
    precision = metrics.precision_score(self.test_labels, y_predicted.round())

    self.assertTrue(precision > PRECISION_THRESHOLD, "precision of {} is below threshold of {}".format(precision, PRECISION_THRESHOLD))

  test_should_have_recall_score_above_minimum_threshold.statistical_test = True
  test_should_have_precision_score_above_minimum_threshold.statistical_test = True