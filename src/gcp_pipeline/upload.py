from datetime import datetime

from google.cloud import storage

if __name__ == "__main__":
    storage_client = storage.Client()

    # get bucket
    bucket = storage_client.bucket("yossi-data-bucket")

    time_of_upload = datetime.now().strftime("%d-%m-%Y")
    object_name = time_of_upload + "/extraction-01/data.csv"
    blob = bucket.blob(object_name)
    blob.upload_from_filename("./data/dummy_data.csv", content_type="csv")
