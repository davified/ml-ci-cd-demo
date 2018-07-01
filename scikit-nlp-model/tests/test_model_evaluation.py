import os, unittest, pickle
from sklearn import metrics
from sklearn.model_selection import train_test_split

from data_loader import get_data_and_labels

RECALL_THRESHOLD = 0.85
PRECISION_THRESHOLD = 0.85

class TestModelEvaluation(unittest.TestCase):
  def setUp(self):
    tests_dir = os.path.dirname(os.path.abspath(__file__))

    with open("{}/../build/model.pkl".format(tests_dir),'rb') as model_file:
      self.model = pickle.load(model_file)

    # Load validation data
    data_filepath = os.path.join(tests_dir, '../../data/reviews_400K.json')

    data, labels, _filenames = get_data_and_labels(data_filepath)

    self.X_train, self.X_val, self.y_train, self.y_val = train_test_split(data, labels)

  def test_should_have_recall_score_above_minimum_threshold(self):
    y_predicted = self.model.predict(self.X_val)
    recall = metrics.recall_score(self.y_val, y_predicted.round())

    self.assertTrue(recall > RECALL_THRESHOLD, "recall of {} is below threshold of {}".format(recall, RECALL_THRESHOLD))

  def test_should_have_precision_score_above_minimum_threshold(self):
    y_predicted = self.model.predict(self.X_val)
    precision = metrics.precision_score(self.y_val, y_predicted.round())

    self.assertTrue(precision > PRECISION_THRESHOLD, "precision of {} is below threshold of {}".format(precision, PRECISION_THRESHOLD))

  # add statistical_test property tag so that we can skip these tests in run_unit_tests.sh
  test_should_have_recall_score_above_minimum_threshold.statistical_test = True
  test_should_have_precision_score_above_minimum_threshold.statistical_test = True
