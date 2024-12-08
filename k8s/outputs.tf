/* output "kubernetes_service_endpoint" {
  value = kubernetes_service.api_tech_challenge_service.kubernetes_network_config.elastic_load_balancing
} */
/* output "nlb_hostname" {
  value = data.kubernetes_service.nlb_service.status[0].load_balancer[0].ingress[0].hostname
} */

/* output "loadbalancer_metadata" {
  value = kubernetes_service.api_tech_challenge_service.metadata[0]
} */

/* output "load_balancer_ingress" {
  value = data.kubernetes_service.nlb_service.status[0].load_balancer[0].ingress[0].hostname
} */

output "nlb_listener_arn" {
	value = data.aws_lb_listener.nlb_listener.arn
}