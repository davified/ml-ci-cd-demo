import os

from google.cloud import storage


class StorageClient:
    def __init__(self, options):
        self.bucket_name = options["bucket_name"]

    def upload_blob(self, file_path):
        """Uploads a file to the bucket."""
        storage_client = storage.Client()
        bucket = storage_client.get_bucket(self.bucket_name)
        blob_name = self.get_blob_name(file_path)
        blob = bucket.blob(blob_name)
        blob.upload_from_filename(file_path)

        print('File {} uploaded to {}.'.format(
            file_path, blob_name))

    @staticmethod
    def get_blob_name(file_path):
        parts = file_path.split("/")
        return parts[len(parts) - 1]

    def get_file_names(self, folder_path):
        return os.listdir(folder_path)

    def upload_files(self, folder_path):
        file_names = self.get_file_names(folder_path)
        for file_name in file_names:
            self.upload_blob("{}/{}".format(folder_path, file_name))


if __name__ == '__main__':
    storageClient = StorageClient({
        "bucket_name": "realtime-bucket",
    })

    folder_path = "/Users/mxxiao/projects/realtime/realtime-clouds/jars"
    storageClient.upload_blob(folder_path)
    storageClient.upload_files(folder_path)
