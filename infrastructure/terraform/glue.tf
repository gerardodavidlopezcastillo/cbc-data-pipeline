resource "aws_glue_catalog_database" "cbcmobility" {
  name        = "cbcmobility"
  description = "Glue database for CBC Mobility datasets"
}

resource "aws_glue_catalog_table" "st_cbc_test" {
  name          = "st_cbc_test"
  database_name = aws_glue_catalog_database.cbcmobility.name
  table_type    = "EXTERNAL_TABLE"

  parameters = {
    classification = "parquet"
    EXTERNAL       = "TRUE"
  }

  storage_descriptor {
    location      = "s3://${var.processed_bucket}/mobility/processed/"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    ser_de_info {
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
    }

    columns {
      name = "desc_fuente"
      type = "string"
    }

    columns {
      name = "desc_nombre_archivo"
      type = "string"
    }

    columns {
      name = "dtm_fecha_carga"
      type = "timestamp"
    }

    columns {
      name = "desc_pais"
      type = "string"
    }

    columns {
      name = "id_transporte"
      type = "int"
    }

    columns {
      name = "id_ruta"
      type = "int"
    }

    columns {
      name = "cod_sku_material"
      type = "string"
    }

    columns {
      name = "desc_unidad"
      type = "string"
    }

    columns {
      name = "num_unidades"
      type = "int"
    }

    columns {
      name = "cantidad"
      type = "double"
    }

    columns {
      name = "cantidad_unidades_totales"
      type = "double"
    }

    columns {
      name = "vlr_precio"
      type = "double"
    }

    columns {
      name = "desc_tipo_entrega"
      type = "string"
    }

    columns {
      name = "es_entrega_rutina"
      type = "int"
    }

    columns {
      name = "es_entrega_bonificacion"
      type = "int"
    }
  }

  partition_keys {
    name = "fecha_particion"
    type = "bigint"
  }
}
