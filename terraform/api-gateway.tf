resource "aws_api_gateway_rest_api" "api" {
    name = "download-file-blog"
}

resource "aws_api_gateway_resource" "resource" {
    path_part   = "{filename}"
    parent_id   = aws_api_gateway_rest_api.api.root_resource_id
    rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_method" "method" {
    rest_api_id   = aws_api_gateway_rest_api.api.id
    resource_id   = aws_api_gateway_resource.resource.id
    http_method   = "GET"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
    rest_api_id             = aws_api_gateway_rest_api.api.id
    resource_id             = aws_api_gateway_resource.resource.id
    http_method             = aws_api_gateway_method.method.http_method
    integration_http_method = "POST"
    type                    = "AWS_PROXY"
    uri                     = aws_lambda_function.download_file.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
    rest_api_id = aws_api_gateway_rest_api.api.id

    triggers = {
        redeployment = sha1(jsonencode([
            aws_api_gateway_resource.resource.id,
            aws_api_gateway_method.method.id,
            aws_api_gateway_integration.integration.id,
        ]))
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_api_gateway_stage" "deploy_stage" {
    deployment_id = aws_api_gateway_deployment.deployment.id
    rest_api_id   = aws_api_gateway_rest_api.api.id
    stage_name    = "deploy"
}
