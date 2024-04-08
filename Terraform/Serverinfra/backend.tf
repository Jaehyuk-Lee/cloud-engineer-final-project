terraform {
  backend "s3" {
    bucket         = "swordbillz"
    key            = "backend/App-eks.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "dynamoDB-state-locking"
  }
}
