output "endpoint_url" {
  # invoke_url already ends with a slash
  value = "${aws_api_gateway_deployment.deployment.invoke_url}${aws_api_gateway_stage.deploy_stage.stage_name}/"
}