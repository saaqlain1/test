resource "aws_connect_instance" "testconnectv3" {
  identity_management_type = "CONNECT_MANAGED"
  inbound_calls_enabled    = true
  instance_alias           = "terraformconnectv3"
  outbound_calls_enabled   = true
  contact_flow_logs_enabled = true
}

resource "aws_connect_hours_of_operation" "general" {
  instance_id = aws_connect_instance.testconnectv3.id
  name        = "General Hours"
  description = "Monday Only"
  time_zone   = "EST"

  config {
    day = "MONDAY"

    start_time {
      hours   = 9
      minutes = 0
    }
    end_time {
      hours   = 17
      minutes = 0
    }
  }
}

resource "aws_connect_queue" "sales" {
  instance_id           = aws_connect_instance.testconnectv3.id
  name                  = "Sales"
  description           = "Customers want to buy our products"
  hours_of_operation_id = aws_connect_hours_of_operation.general.hours_of_operation_id
}

resource "aws_connect_queue" "technical_support" {
  instance_id           = aws_connect_instance.testconnectv3.id
  name                  = "Technical Support"
  description           = "Customers are having issues with our products"
  hours_of_operation_id = aws_connect_hours_of_operation.general.hours_of_operation_id
}

resource "aws_connect_queue" "customer_service" {
  instance_id           = aws_connect_instance.testconnectv3.id
  name                  = "Customer Service"
  description           = "Customers want to ask about our products"
  hours_of_operation_id = aws_connect_hours_of_operation.general.hours_of_operation_id
}

resource "aws_connect_contact_flow" "general" {
 instance_id = aws_connect_instance.testconnectv3.id
 name        = "General"
 description = "General Flow routing customers to queues"
 filename = "C:/My Work/my Tasks/AWSconnectterraform/flows/general_contact_flow.json"
}

