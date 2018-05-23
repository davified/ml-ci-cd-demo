import os, unittest
import numpy as np
import pandas as pd
from constants import COLUMNS
from utils import load_data

class TestUtils(unittest.TestCase):
  def setUp(self):
    current_dir  = os.path.dirname(os.path.abspath(__file__))
    self.test_data = os.path.join(current_dir, './fixtures/samples.csv')
    self.test_df = pd.read_csv(self.test_data, header=None, names=COLUMNS)

    self.NO_OF_EXAMPLES = self.test_df.shape[0]
    self.NO_OF_FEATURES = self.test_df.shape[1] - 1

  def test_should_load_data_and_return_features_labels(self):
    features, labels = load_data(data_filepath=self.test_data, y_column='income-level', y_class_1=' >50K')

    self.assertEqual(np.array(features).shape, (self.NO_OF_EXAMPLES, self.NO_OF_FEATURES))
    self.assertEqual(np.array(labels).shape, (self.NO_OF_EXAMPLES,))

    self.assertEqual(features, self.test_df.drop('income-level', axis=1).as_matrix().tolist())
    self.assertTrue(all(label == 0 or label == 1 for label in labels))


    
