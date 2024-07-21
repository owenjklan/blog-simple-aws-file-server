# Lambda permissions to allow trigger from API Gateway
resource "aws_lambda_permission" "apigw_lambda" {
    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.download_file.function_name
    principal     = "apigateway.amazonaws.com"

    # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
    source_arn = "arn:aws:execute-api:${var.my_region}:${var.account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
}

# Package our Python source into a ZIP file for deployment
data "archive_file" "lambda" {
    type = "zip"
    source_file = "../src/download_file.py"
    output_path = "lambda_function_payload.zip"
}

# Create the actual function definition
resource "aws_lambda_function" "download_file" {
    filename = "lambda_function_payload.zip"
    function_name = "download-file-blog"
    role = aws_iam_role.iam_for_lambda.arn
    source_code_hash = data.archive_file.lambda.output_base64sha256
    handler = "download_file.lambda_handler"
    runtime = "python3.12"
}