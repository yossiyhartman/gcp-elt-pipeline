from datetime import datetime

from google.cloud import storage

if __name__ == "__main__":
    # get bucket
    storage_client = storage.Client()
    bucket = storage_client.bucket("yossi-data-bucket")

    # blobname
    time_of_upload = datetime.now().strftime("%d-%m-%Y")
    object_name = f"{time_of_upload}/data.csv"
    blob = bucket.blob(object_name)

    # upload
    blob.upload_from_filename("./data/dummy_data.csv", content_type="csv")
