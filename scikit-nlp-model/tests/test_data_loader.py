import os, unittest
from data_loader import get_data_and_labels

class TestDataLoader(unittest.TestCase):
  def test_should_load_data_and_return_features_labels(self):
    current_dir  = os.path.dirname(os.path.abspath(__file__))
    test_data_path = '{}/fixtures/review_10_samples.json'.format(current_dir)
    with open(test_data_path) as file:
      expected_number_of_examples = sum(1 for line in file)

    texts, labels, _ = get_data_and_labels(test_data_path)
    
    self.assertEqual(len(texts), expected_number_of_examples)
    self.assertEqual(len(labels), expected_number_of_examples)
    
    [self.assertTrue(label == 0 or label == 1) for label in labels]
    [self.assertTrue(isinstance(text, str)) for text in texts]
    

