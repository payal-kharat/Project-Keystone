#####################################
# Frontend Repository
#####################################

resource "aws_ecr_repository" "frontend" {

  name = var.frontend_repository_name

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {

    scan_on_push = true

  }

  tags = {

    Name = "${var.project_name}-frontend-ecr"

  }

}

#####################################
# Backend Repository
#####################################

resource "aws_ecr_repository" "backend" {

  name = var.backend_repository_name

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {

    scan_on_push = true

  }

  tags = {

    Name = "${var.project_name}-backend-ecr"

  }

}