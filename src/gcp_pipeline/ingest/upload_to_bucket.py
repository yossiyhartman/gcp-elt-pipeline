import pyarrow as pa
import pyarrow.dataset as ds

from gcp_pipeline.generate import Generator

if __name__ == "__main__":
    # Generate some data
    data = Generator().generate(days=3)

    # Pour into pyarrow
    table = pa.table(data)

    # Write to gcp in parquet format
    ds.write_dataset(
        table,
        base_dir="gs://yossi-data-bucket",
        format="parquet",
        partitioning=["date"],
    )
