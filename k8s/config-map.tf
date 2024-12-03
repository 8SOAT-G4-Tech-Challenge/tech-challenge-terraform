resource "kubernetes_config_map" "env_config" {
  metadata {
    name = "env-config"
    labels = {
      name = "env-config"
    }
  }

  data = {
    API_PORT = "3333"
    POSTGRES_DB = "tech-challenger"
    POSTGRES_USER = "postgres"
    MERCADO_PAGO_TOKEN = "APP_USR-8947872587675457-092119-5efc606bd65ca741c729cd17c29ea83a-1999874453"
    MERCADO_PAGO_USER_ID = "1999874453"
    MERCADO_PAGO_EXTERNAL_POS_ID = "01"
  }
}