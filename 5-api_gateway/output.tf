output "api_gateway_endpoint" {
  value = aws_apigatewayv2_api.api_gateway.api_endpoint
}

/* output "nlb_arn" {
  value = data.aws_lb.nlb.arn
}

output "nlb_dns_name" {
  value = data.aws_lb.nlb.dns_name
} */