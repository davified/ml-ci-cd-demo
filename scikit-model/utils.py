import pandas as pd
from constants import COLUMNS


def load_data(data_filepath, y_column, y_class_1):
  with open(data_filepath, 'r') as data:
    raw_training_data = pd.read_csv(data, header=None, names=COLUMNS)

  # Remove y_column from features list
  features = raw_training_data.drop(y_column, axis=1).as_matrix().tolist()
  labels = (raw_training_data[y_column] == y_class_1).as_matrix().tolist()

  return features, labels
  