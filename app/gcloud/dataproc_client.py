import googleapiclient.discovery


class DataprocClient:
    def __init__(self, options):
        self.project = options["project"]
        self.region = options["region"]
        self.zone = options["zone"]
        self.master_num = options["master_num"]
        self.worker_num = options["worker_num"]
        self.filename = options["filename"]

    def get_client(self):
        """Builds a client to the dataproc API."""
        dataproc = googleapiclient.discovery.build('dataproc', 'v1')
        return dataproc

    def list_clusters(self):
        result = self.get_client().projects().regions().clusters().list(
            projectId=self.project,
            region=self.region).execute()
        return result

    def create_cluster(self, cluster_name):
        print('Creating cluster...')
        cluster_data = {
            'projectId': self.project,
            'clusterName': cluster_name,
            "config": {
                "configBucket": "",
                "gceClusterConfig": {
                    "subnetworkUri": "default",
                    "zoneUri": self.zone
                },
                "masterConfig": {
                    "numInstances": self.master_num,
                    "machineTypeUri": "n1-standard-2",
                    "diskConfig": {
                        "bootDiskSizeGb": 500,
                        "numLocalSsds": 0
                    }
                },
                "workerConfig": {
                    "numInstances": self.worker_num,
                    "machineTypeUri": "n1-standard-1",
                    "diskConfig": {
                        "bootDiskSizeGb": 500,
                        "numLocalSsds": 0
                    }
                }
            }
        }
        result = self.get_client().projects().regions().clusters().create(
            projectId=self.project,
            region=self.region,
            body=cluster_data).execute()
        return result

    def submit_pyspark_job(self, cluster_name, bucket_name):
        """Submits the Pyspark job to the cluster, assuming `filename` has
        already been uploaded to `bucket_name`"""
        job_details = {
            'projectId': self.project,
            "job": {
                "placement": {
                    "clusterName": cluster_name
                },
                "pysparkJob": {
                    "mainPythonFileUri": "gs://{}/{}".format(bucket_name, self.filename),
                    "jarFileUris": [
                        "gs://realtime-bucket/mongo-spark-connector_2.11-2.2.1.jar",
                        "gs://realtime-bucket/mongo-java-driver-3.6.1.jar",
                        "gs://realtime-bucket/bson-3.6.1.jar"
                    ]
                }
            }
        }
        result = self.get_client().projects().regions().jobs().submit(
            projectId=self.project,
            region=self.region,
            body=job_details).execute()
        return result

    def delete_cluster(self, cluster_name):
        print('Tearing down cluster')
        result = self.get_client().projects().regions().clusters().delete(
            projectId=self.project,
            region=self.region,
            clusterName=cluster_name).execute()
        return result

    def provision_and_submit(self, cluster_name, bucket_name):
        res = self.list_clusters()
        cluster_exist = False
        for name in res:
            clusters = res[name]
            existing_cluster_name = clusters[0]["clusterName"]
            if existing_cluster_name == cluster_name:
                cluster_exist = True
                break
        if not cluster_exist:
            res = self.create_cluster(cluster_name=cluster_name)

        res = self.submit_pyspark_job(cluster_name, bucket_name)
        print("Job id:  ", res)


if __name__ == '__main__':
    project = "tw-data-engineering-demo"
    region = "asia-southeast1"
    zone = "asia-southeast1-b"
    bucket_name = "realtime-bucket"
    cluster_name = "new-cluster"

    dataproc_client = DataprocClient({
        "project": project,
        "region": region,
        "zone": zone,
        "master_num": 1,
        "worker_num": 2,
        "filename": "processing.py"
    })
    res = dataproc_client.provision_and_submit(cluster_name, bucket_name)
    print(res)
