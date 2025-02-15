resource "kubernetes_config_map" "env_config" {
  metadata {
    name      = "env-config-tech-challenge-payment"
    namespace = kubernetes_namespace.payment.metadata[0].name
    labels = {
      name = "env-config-tech-challenge-payment"
    }
  }

  data = {
    API_PORT                     = "3333"
    MERCADO_PAGO_TOKEN           = "APP_USR-8947872587675457-092119-5efc606bd65ca741c729cd17c29ea83a-1999874453"
    MERCADO_PAGO_USER_ID         = "1999874453"
    MERCADO_PAGO_EXTERNAL_POS_ID = "01"
    MERCADO_PAGO_BASE_URL        = "https://api.mercadopago.com"
  }

  depends_on = [kubernetes_namespace.payment]
}
