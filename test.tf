terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.39.0"
    }
  }
}

provider "github" {
  # Configuration options
}

locals {
  repos = toset([
    "actions/checkout",
    "actions/runner-images",
  ])
}

data "github_repository" "whitelist_repos" {
  for_each  = local.repos
  full_name = each.key
}

output "repo_id" {
    value = [ for repo in data.github_repository.whitelist_repos: repo.repo_id]
}
